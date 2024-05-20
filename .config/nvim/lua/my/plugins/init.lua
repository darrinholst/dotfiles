return {
  { "DaikyXendo/nvim-material-icon" },
  { "benmills/vimux" },
  { "chrisbra/csv.vim" },
  { "ibhagwan/smartyank.nvim", opts = { highlight = { timeout = 1000 } } },
  { "kylechui/nvim-surround", opts = {} },
  { "mbbill/undotree" },
  { "mhinz/vim-startify" },
  { "roobert/search-replace.nvim", opts = {} },
  { "shumphrey/fugitive-gitlab.vim" },
  { "sjl/vitality.vim" },
  { "smjonas/inc-rename.nvim", opts = { input_buffer_type = "dressing" } },
  { "stevearc/dressing.nvim" },
  { "suy/vim-context-commentstring" },
  { "t9md/vim-choosewin" },
  { "thinca/vim-qfreplace" },
  { "tpope/vim-commentary" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-repeat" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-unimpaired" },
  { "triglav/vim-visual-increment" },
  { "troydm/zoomwintab.vim" },
  { "wakatime/vim-wakatime" },

  {
    "stevearc/oil.nvim",
    opts = {
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
    },
  },

  {
    "folke/trouble.nvim",
    branch = "dev", -- IMPORTANT!
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {},
  },

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
        separator = "/",
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
        "fugitiveblame",
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
      format_on_save = function(bufnr)
        local ignore_filetypes = { "json" }

        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        local bufname = vim.api.nvim_buf_get_name(bufnr)

        if bufname:match("/node_modules/") then
          return
        end

        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        json = { "jq", "fixjson", "trim_whitespace" },
        javascript = { "eslint_d", "trim_whitespace" },
        javascriptreact = { "eslint_d", "trim_whitespace" },
        ["_"] = { "trim_whitespace" },
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
