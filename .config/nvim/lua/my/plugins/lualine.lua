return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        startify = {},
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      },
      lualine_b = {
        { "branch", icons_enabled = false },
        { "diff" },
        { "diagnostics" },
      },
      lualine_c = {
        { "filename" },
      },
      lualine_x = {},
      lualine_y = {
        { "filetype", separator = "", padding = { left = 1, right = 0 } },
        { "fileformat" },
      },
      lualine_z = {
        { "progress", separator = "" },
        { "location", padding = { left = 0, right = 1 } },
      },
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
}
