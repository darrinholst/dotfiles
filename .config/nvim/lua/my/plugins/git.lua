return {
  { "shumphrey/fugitive-gitlab.vim" },
  {
    "tpope/vim-fugitive",
    config = function()
      -- vim.api.nvim_command("command! -nargs=* Browse call fugitive#GBrowse(<f-args>)")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
}
