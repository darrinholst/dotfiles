return {
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
}
