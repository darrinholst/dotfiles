-- vim.lsp.set_log_level "debug"
-- require("vim.lsp.log").set_format_func(vim.inspect)

require('mason').setup({
  ui = {
    border = 'single'
  },
})

require('mason-lspconfig').setup {
  ensure_installed = {
    'bashls',
    'eslint',
    'jsonls',
    'lemminx',
    'lua_ls',
    'tsserver',
    'yamlls',
  },
}

local lspconfig = require('lspconfig')
require('lspconfig.ui.windows').default_options.border = 'single'

local on_attach = function(client, bufnr)
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      border = 'single',
    }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      border = 'single',
    }
  )

  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
  })

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local disableDiagnostics = function()
    vim.diagnostic.disable(bufnr)
  end

  vim.keymap.set('n', '<space>x', disableDiagnostics, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)

  -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>rn', function()
    return ':IncRename ' .. vim.fn.expand('<cword>')
  end, { buffer = bufnr, noremap = true, expr = true })

  vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

  if client.supports_method('textDocument/formatting') then
    vim.keymap.set('', '<C-f>', vim.lsp.buf.format, bufopts)
    vim.keymap.set('i', '<C-f>', vim.lsp.buf.format, bufopts)
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.codespell,
    null_ls.builtins.formatting.fixjson,
    null_ls.builtins.formatting.xmlformat,
    null_ls.builtins.code_actions.cspell,
    null_ls.builtins.diagnostics.cspell.with({
      diagnostics_postprocess = function(diagnostic)
        diagnostic.severity = vim.diagnostic.severity['HINT']
      end,
      diagnostic_config = {
        underline = true,
        virtual_text = false,
        signs = false,
      },
    }),
  },
})

lspconfig.bashls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim', 'hs' } },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
      },
    },
  },
}

lspconfig.terraformls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    diagnostics = {
      ignoredCodes = { 7016, 80001, 80006, 80007 },
    },
  },
}

lspconfig.yamlls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    yaml = {
      customTags = {
        '!reference'
      },
      schemas = {
        ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = '.gitlab-ci.yml',
      },
    },
  },
}

lspconfig.jsonls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.r_language_server.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    r = {
      lsp = {
        -- diagnostics = false,
      },
    },
  },
}

lspconfig.lemminx.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.eslint.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    local group = vim.api.nvim_create_augroup('FixIt', { clear = true })

    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      group = group,
      callback = function()
        vim.schedule(function()
          vim.cmd('EslintFixAll')
        end)
      end,
    })
  end,
}