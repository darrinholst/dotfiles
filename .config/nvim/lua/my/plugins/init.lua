return {
  { "mhinz/vim-startify" },
  { "ibhagwan/smartyank.nvim", opts = { highlight = { timeout = 1000 } } },
  { "troydm/zoomwintab.vim" },
  { "t9md/vim-choosewin" },
  { "anuvyklack/animation.nvim" },
  { "anuvyklack/middleclass" },
  { "benmills/vimux" },
  { "sjl/vitality.vim" },
  { "shumphrey/fugitive-gitlab.vim" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "folke/trouble.nvim", opts = { position = "right" } },
  { "chrisbra/csv.vim" },
  { "DaikyXendo/nvim-material-icon" },
  { "kylechui/nvim-surround", opts = {} },
  { "suy/vim-context-commentstring" },
  { "tpope/vim-commentary" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-repeat" },
  { "tpope/vim-unimpaired" },
  { "triglav/vim-visual-increment" },
  { "wakatime/vim-wakatime" },
  { "lambdalisue/suda.vim" },
  { "thinca/vim-qfreplace" },
  { "smjonas/inc-rename.nvim", opts = { input_buffer_type = "dressing" } },
  { "roobert/search-replace.nvim", opts = {} },
  { "stevearc/dressing.nvim" },
  { "mbbill/undotree" },

  {
    "ggandor/leap.nvim",
    config = function()
      require("leap").add_default_mappings()
    end,
  },

  {
    "fgheng/winbar.nvim",
    opts = {
      enabled = true,

      show_file_path = true,
      show_symbols = true,

      icons = {
        file_icon_default = "",
        seperator = "/",
        editor_state = "●",
        lock_icon = "",
      },

      exclude_filetype = {
        "help",
        "startify",
        "dashboard",
        "packer",
        "neogitstatus",
        "Trouble",
        "alpha",
        "lir",
        "Outline",
        "spectre_panel",
        "toggleterm",
        "qf",
      },
    },
  },

  {
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
      disable_in_macro = true,
      disable_in_visualblock = true,
    },
  },

  {
    "RRethy/nvim-base16",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme("base16-tomorrow-night")
    end,
  },

  {
    "ggandor/leap.nvim",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
      disable_in_macro = true,
      disable_in_visualblock = true,
    },
  },

  {
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
    opts = {
      ring = { storage = "sqlite" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
        delete = { hl = "GitSignsDelete", text = "|", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        changedelete = { hl = "GitSignsChange", text = "|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
      },
    },
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*", "!vim-plug" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = "background", -- Set the display mode.
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },

  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.align").setup()
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("which-key").setup()
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = "davidmh/cspell.nvim",
    config = function()
      local null_ls = require("null-ls")
      local cspell = require("cspell")
      local cspell_config = {
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity["HINT"] -- ERROR, WARN, INFO, HINT
        end,
        diagnostic_config = {
          underline = true,
          virtual_text = false,
          signs = false,
        },
        config = {
          on_success = function(cspell_config_file_path, params, action_name)
            if action_name == "add_to_json" then
              os.execute(
                string.format(
                  "cat %s | jq -S '.words |= sort' | tee %s > /dev/null",
                  cspell_config_file_path,
                  cspell_config_file_path
                )
              )
            end
          end,
        },
      }
      null_ls.setup({
        sources = {
          cspell.diagnostics.with(cspell_config),
          cspell.code_actions.with(cspell_config),
        },
      })
    end,
  },
}
