return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  priority = 100,
  event = "InsertEnter",

  dependencies = {
    "L3MON4D3/LuaSnip",
    "dmitmel/cmp-cmdline-history",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",
    "onsails/lspkind.nvim",
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load()

    luasnip.filetype_extend("typescript", { "javascript" })
    luasnip.filetype_extend("javascriptreact", { "javascript" })
    luasnip.filetype_extend("typescriptreact", { "javascript" })

    local lspkind = require("lspkind")
    lspkind.init()

    cmp.setup({
      sources = {
        { name = "nvim_lsp" },
        { name = "path" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        { name = "luasnip" },
        { name = "nvim_lua" },
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
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = {
          border = "single",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
        documentation = {
          border = "single",
          winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
        },
      },

      formatting = {
        format = lspkind.cmp_format({
          with_text = true,
          menu = {
            buffer = "[buf]",
            luasnip = "[snip]",
            nvim_lsp = "[lsp]",
            nvim_lua = "[api]",
            path = "[path]",
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
