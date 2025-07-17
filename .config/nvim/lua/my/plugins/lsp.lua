return {
  "neovim/nvim-lspconfig",

  dependencies = {
    { "mason-org/mason.nvim", version = "^1.0.0" },
    { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf, desc = "[R]e[n]ame" })
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "[C]ode [A]ction" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf, desc = "Hover Documentation" })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

        vim.lsp.handlers["textDocument/signatureHelp"] =
          vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

        vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = true, signs = true })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      bashls = {},
      jsonls = {},
      lemminx = {},
      yamlls = {},

      ts_ls = {
        settings = {
          diagnostics = {
            ignoredCodes = { 6133, 7016, 7044, 80001, 80006, 80007 },
          },

          typescript = {
            implicitProjectConfig = {
              checkJs = true,
              allowJs = true,
              allowSyntheticDefaultImports = true,
              target = "ESNext",
              module = "ESNext",
            },
          },
          javascript = {
            implicitProjectConfig = {
              checkJs = true,
              allowSyntheticDefaultImports = true,
              target = "ESNext",
              module = "ESNext",
            },
          },
        },
      },

      eslint = {
        settings = {
          workingDirectories = { mode = "auto" },
        },

        on_attach = function(client, bufnr)
          local group = vim.api.nvim_create_augroup("FixIt", { clear = true })

          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = group,
            callback = function()
              vim.schedule(function() vim.cmd "EslintFixAll" end)
            end,
          })
        end,
      },

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

    require("mason").setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, { "stylua" })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end,
}
