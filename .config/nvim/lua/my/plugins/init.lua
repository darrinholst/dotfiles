return {
  { "benmills/vimux" },
  { "chrisbra/csv.vim" },
  { "ibhagwan/smartyank.nvim", opts = { highlight = { timeout = 1000 } } },
  { "kylechui/nvim-surround", opts = {} },
  { "mbbill/undotree" },
  { "mhinz/vim-startify" },
  { "roobert/search-replace.nvim", opts = {} },
  { "sjl/vitality.vim" },
  { "smjonas/inc-rename.nvim", opts = { input_buffer_type = "dressing" } },
  { "stevearc/dressing.nvim" },
  { "suy/vim-context-commentstring" },
  { "t9md/vim-choosewin" },
  { "thinca/vim-qfreplace" },
  { "tpope/vim-commentary" },
  { "tpope/vim-eunuch" },
  { "tpope/vim-repeat" },
  { "tpope/vim-rhubarb" },
  { "tpope/vim-unimpaired" },
  { "triglav/vim-visual-increment" },
  { "troydm/zoomwintab.vim" },
  { "wakatime/vim-wakatime" },
  {
    url = "https://codeberg.org/andyg/leap.nvim",
    "ggandor/leap.nvim",
    config = function()
      vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
      vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
      vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
    end,
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
    "gbprod/yanky.nvim",
    dependencies = {
      { "kkharji/sqlite.lua" },
    },
    opts = {
      ring = { storage = "sqlite" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = false } end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
    config = function() require("grug-far").setup {} end,
  },
}
