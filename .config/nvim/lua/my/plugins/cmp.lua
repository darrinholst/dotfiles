return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'SirVer/ultisnips',
    'dmitmel/cmp-cmdline-history',
    'honza/vim-snippets',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    'hrsh7th/cmp-path',
    'quangnguyen30192/cmp-nvim-ultisnips',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local cmp_ultisnips_mappings = require('cmp_nvim_ultisnips.mappings')

    lspkind.init()

    cmp.setup({
      snippet = {
        expand = function(args)
          vim.fn['UltiSnips#Anon'](args.body) -- For `ultisnips` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = lspkind.cmp_format({
          with_text = true,
          menu = {
            buffer = '[buf]',
            nvim_lsp = '[lsp]',
            nvim_lua = '[api]',
            path = '[path]',
            ultisnips = '[snip]',
          },
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-j>'] = cmp.mapping(
          function(fallback) cmp_ultisnips_mappings.expand_or_jump_forwards(fallback) end,
          { 'i', 's' --[[ "c" (to enable the mapping in command mode) ]] }
        ),
        ['<C-k>'] = cmp.mapping(
          function(fallback) cmp_ultisnips_mappings.jump_backwards(fallback) end,
          { 'i', 's' --[[ "c" (to enable the mapping in command mode) ]] }
        ),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'nvim_lua' },
        { name = 'path' },
        {
          name = 'buffer',
          option = {
            get_bufnrs = function() return vim.api.nvim_list_bufs() end,
            keyword_length = 4,
          },
        },
      }),
      experimental = {
        ghost_text = false,
        native_menu = false,
      },
    })

    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
        { name = 'cmdline' },
        { name = 'cmdline_history' },
      }),
    })
  end,
}
