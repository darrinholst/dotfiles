return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  priority = 100,
  event = "InsertEnter",

  dependencies = {
    "SirVer/ultisnips",
    "dmitmel/cmp-cmdline-history",
    "honza/vim-snippets",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "quangnguyen30192/cmp-nvim-ultisnips",
    "onsails/lspkind.nvim",
  },

  config = function()
    local cmp = require("cmp")
    local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

    local lspkind = require("lspkind")
    lspkind.init()

    cmp.setup({
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
        { name = "ultisnips" },
        { name = "nvim_lua" },
        { name = "path" },
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-y>"] = cmp.mapping(
          cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
          { "i", "c" }
        ),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-j>"] = cmp.mapping(function(fallback)
          cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          cmp_ultisnips_mappings.jump_backwards(fallback)
        end, { "i", "s" }),
      }),

      snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
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
            buffer = "[buf]",
            nvim_lsp = "[lsp]",
            nvim_lua = "[api]",
            path = "[path]",
            ultisnips = "[snip]",
          },
        }),
      },

      experimental = {
        ghost_text = false,
        native_menu = false,
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
        { name = "cmdline_history" },
      }),
    })
  end,
}
