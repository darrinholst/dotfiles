local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  extensions = {
    emoji = {
      action = function(emoji)
        vim.fn.setreg("*", emoji.value)
        print([[Press p or "*p to paste this emoji]] .. emoji.value)
        -- insert emoji when picked 
        vim.api.nvim_put({ emoji.value }, 'c', false, true)
      end,
    }
  },
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
    sorting_strategy = "ascending",
    layout_config = {
      prompt_position = "top",
      horizontal = { width = 0.99, height = 0.99 }
    },
  },
  pickers = {
    buffers = {
      ignore_current_buffer = true,
      sort_lastused = true,
      sort_mru = true,
    },
  },
})

telescope.load_extension("fzf")
telescope.load_extension("emoji")
telescope.load_extension("live_grep_args")
telescope.load_extension("harpoon")