local function grep_at_current_tree_node()
  local node = require("nvim-tree.lib").get_node_at_cursor()
  if not node then return end
  require("telescope.builtin").live_grep({ search_dirs = { node.absolute_path } })
end

require("nvim-tree").setup({
  create_in_closed_folder = true,
  git = { enable = true, ignore = false },
  view = {
    mappings = {
      list = {
        { key = { "g" }, cb = grep_at_current_tree_node }
      }
    }
  },
})
