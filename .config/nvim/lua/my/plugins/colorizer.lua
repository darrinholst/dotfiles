return {
  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        filetypes = { "*" },
        user_default_options = {
          RGB = true,
          RRGGBB = true,
          names = true,
          RRGGBBAA = false,
          rgb_fn = true,
          hsl_fn = false,
          css = false,
          css_fn = false,
          mode = "background",
        },
      })
    end,
  },
}
