return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    local is_alpine = vim.fn.system("cat /etc/os-release 2>/dev/null"):match("Alpine") ~= nil

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
        map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
        map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = "single",
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = "single",
        })

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = true,
          signs = true,
        })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      bashls = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = { "${3rd}/luv/library", unpack(vim.api.nvim_get_runtime_file("", true)) },
            },
            completion = { callSnippet = "Replace" },
            diagnostics = { disable = { "missing-fields" } },
          },
        },
      },
    }

    if not is_alpine then
      servers.jsonls = {}
      servers.lemminx = {}
      servers.ts_ls = {
        settings = {
          diagnostics = {
            ignoredCodes = { 6133, 7016, 80001, 80006, 80007 },
          },
        },
      }
      servers.yamlls = {}
      servers.eslint = {
        settings = {
          workingDirectories = { mode = "auto" },
        },
        on_attach = function(client, bufnr)
          local group = vim.api.nvim_create_augroup("FixIt", { clear = true })
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = group,
            callback = function()
              vim.schedule(function()
                vim.cmd("EslintFixAll")
              end)
            end,
          })
        end,
      }
    end

    require("mason").setup({
      ui = {
        check_outdated_packages_on_open = false,
        border = "single",
      },
      log_level = vim.log.levels.WARN,
      max_concurrent_installers = is_alpine and 1 or 4,
    })

    local ensure_installed = is_alpine and { "bash-language-server", "lua-language-server" }
      or vim.tbl_keys(servers or {})

    if not is_alpine then
      vim.list_extend(ensure_installed, { "stylua" })
    end

    require("mason-tool-installer").setup({
      ensure_installed = ensure_installed,
      auto_update = false,
      run_on_start = not is_alpine,
    })

    require("mason-lspconfig").setup({
      automatic_installation = not is_alpine,
      handlers = {
        function(server_name)
          if servers[server_name] then
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
            require("lspconfig")[server_name].setup(server)
          end
        end,
      },
    })
  end,
}
