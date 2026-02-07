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
        vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, desc = "[C]ode [A]ction" })
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "single", max_width = math.floor(vim.o.columns * 0.75) }) end, { buffer = event.buf, desc = "Hover Documentation" })
      end,
    })

    -- Configure diagnostics using the new API
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = { border = "single" }
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Global LSP configuration using new API
    vim.lsp.config('*', {
      capabilities = capabilities,
    })

    -- Configure specific servers using new vim.lsp.config API
    vim.lsp.config('tsserver', {
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
      init_options = {
        preferences = {
          disableSuggestions = false,
        },
      },
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
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
        diagnostics = {
          ignoredCodes = { 6133, 7016, 7044, 80001, 80006, 80007 },
        },
      },
    })

    vim.lsp.config('eslint', {
      settings = {
        workingDirectories = { mode = "auto" },
      },
      on_attach = function(client, bufnr)
        local group = vim.api.nvim_create_augroup("FixIt", { clear = true })
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.lsp.buf.code_action({
              context = { only = { "source.fixAll.eslint" } },
              apply = true,
            })
          end,
        })
      end,
    })

    vim.lsp.config('lua_ls', {
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
    })

    require("mason").setup()

    local mason_packages = {
      "bash-language-server",
      "gopls",
      "json-lsp",
      "lemminx",
      "yaml-language-server",
      "typescript-language-server",
      "eslint-lsp",
      "lua-language-server"
    }
    local ensure_installed = vim.list_extend(vim.deepcopy(mason_packages), { "stylua" })
    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    -- Enable LSP servers using the new API
    vim.lsp.enable({ 'bashls', 'gopls', 'jsonls', 'lemminx', 'yamlls', 'tsserver', 'eslint', 'lua_ls' })
  end,
}
