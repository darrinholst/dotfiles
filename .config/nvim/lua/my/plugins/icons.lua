return {
  { "DaikyXendo/nvim-material-icon", lazy = false },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    opts = {
      override = { ["cjs"] = { icon = "", color = "#f1e05a", cterm_color = "221", name = "Cjs" } },
      default = true,
    },
  },
}
