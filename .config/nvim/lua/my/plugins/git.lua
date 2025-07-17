return {
  { "shumphrey/fugitive-gitlab.vim" },
  { "tpope/vim-fugitive" },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      preview_config = {
        border = "rounded",
      },
    },
  },
}
