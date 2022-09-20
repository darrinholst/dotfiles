local configs = require("nvim-treesitter.configs")

configs.setup({
  textobjects = {
    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
      }
    }
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
})

require'treesitter-context'.setup()
