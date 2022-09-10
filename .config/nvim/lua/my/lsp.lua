require("mason").setup {}

require("mason-lspconfig").setup {
  ensure_installed = {
    "cucumber-language-server",
    "eslint-lsp",
    "json-lsp",
    "lemminx",
    "lua-language-server",
    "r-languageserver",
    "typescript-language-server",
    "yaml-language-server",
  },
}

local lspconfig = require("lspconfig")

local on_attach = function(client, bufnr)
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
  })

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local disableDiagnostics = function()
    vim.diagnostic.disable(bufnr)
  end

  vim.keymap.set("n", "<space>x", disableDiagnostics, bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<f2>", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

  if client.supports_method("textDocument/formatting") then
    vim.keymap.set("", "<C-f>", vim.lsp.buf.format, bufopts)
    vim.keymap.set("i", "<C-f>", vim.lsp.buf.format, bufopts)
  end
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.diagnostics.cspell.with({
      -- filetypes = { "javascript", "javascriptreact" },
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity["HINT"]
      end,
    })
  },
})

lspconfig.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim", "hs" } },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  }
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    diagnostics = {
      ignoredCodes = { 7016, 80001, 80006, 80007 },
    },
  }
}

lspconfig.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      schemas = {
        ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = ".gitlab-ci.yml",
      },
    },
  }
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "tsconfig.json", "tsconfig.*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = { ".eslintrc.json", ".eslintrc" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
          url = "https://json.schemastore.org/prettierrc",
        },
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
      },
    },
  },
}

-- not working well for me at the moment
-- lspconfig.cucumber_language_server.setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
--   settings = {
--     glue = {
--       "features/**/*.js",
--       "features/**/*.ts",
--     }
--   }
-- }

lspconfig.r_language_server.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    r = {
      lsp = {
        diagnostics = false
      }
    }
  }
}

lspconfig.lemminx.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.eslint.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

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
