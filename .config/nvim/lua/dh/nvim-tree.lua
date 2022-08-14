require('nvim-tree').setup({
  git = {
    enable = true,
    ignore = false,
  },
  filters = {
    custom = { '.git' },
  },
})

vim.api.nvim_set_keymap('', '<F6>', ':NvimTreeFindFile<CR>', {silent = true})
vim.api.nvim_set_keymap('i', '<F6>', '<Esc>:NvimTreeFindFile<CR>', {silent = true})
vim.api.nvim_set_keymap('', '<F7>', ':NvimTreeToggle<CR>', {silent = true})
vim.api.nvim_set_keymap('i', '<F7>', '<Esc>:NvimTreeToggle<CR>', {silent = true})

