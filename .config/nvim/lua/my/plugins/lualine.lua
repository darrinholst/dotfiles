return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local current_theme = "onedark"

    local function setup_lualine(theme)
      current_theme = theme
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = theme,
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
      })
    end

    -- Initialize with default theme
    setup_lualine(current_theme)

    vim.api.nvim_create_user_command("LualineTheme", function(opts)
      setup_lualine(opts.args)
    end, {
      nargs = 1,
      complete = function()
        -- List of themes for completion
        return {
          "auto",
          "gruvbox",
          "gruvbox_light",
          "nord",
          "dracula",
          "tokyonight",
          "palenight",
          "nightfly",
          "onedark",
          "solarized_dark",
          "solarized_light",
          "ayu_dark",
          "ayu_light",
          "ayu_mirage",
          "codedark",
        }
      end,
    })
  end,
}
