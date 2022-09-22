require("nvim-tree").setup({
  create_in_closed_folder = true,
  git = { enable = true, ignore = false },
  view = {
    mappings = {
      list = {
        { key = { "<C-g>" }, action = "grep here", action_cb = function(node)
          require("telescope.builtin").live_grep({ search_dirs = { node.absolute_path } })
        end }
      }
    }
  },
})
