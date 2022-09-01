require("nvim-tree").setup({
  create_in_closed_folder = true,
  git = {
    enable = true,
    ignore = false,
  },
  view = {
    adaptive_size = true,
    side = "right",
  },
})
