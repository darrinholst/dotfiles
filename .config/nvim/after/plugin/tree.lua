local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

local function collapse_all()
  require("nvim-tree.actions.tree-modifiers.collapse-all").fn()
end

local function edit_or_open()
  local action = "edit"
  local node = lib.get_node_at_cursor()

  if node.link_to and not node.nodes then
    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
    view.close() -- Close the tree if file was opened
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
    view.close()
  end
end

local function vsplit_preview()
  local action = "vsplit"
  local node = lib.get_node_at_cursor()

  if node.link_to and not node.nodes then
    require("nvim-tree.actions.node.open-file").fn(action, node.link_to)
  elseif node.nodes ~= nil then
    lib.expand_or_collapse(node)
  else
    require("nvim-tree.actions.node.open-file").fn(action, node.absolute_path)
  end

  view.focus()
end

require("nvim-tree").setup({
  git = { enable = true, ignore = false },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        -- { key = "l", action = "edit", action_cb = edit_or_open },
        -- { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
        { key = "h", action = "close_node" },
        -- { key = "H", action = "collapse_all", action_cb = collapse_all },
        { key = { "<C-g>" }, action = "grep here", action_cb = function(node)
          require("telescope.builtin").live_grep({ search_dirs = { node.absolute_path } })
        end }
      }
    }
  },
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("NvimTree", { clear = true }),
  pattern = "NvimTree",

  callback = function()
    vim.diagnostic.disable(0)
  end
})
