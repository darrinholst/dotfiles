require 'FTerm'.setup({
  border     = 'double',
  dimensions = {
    height = 0.9,
    width = 0.9,
  },
})

-- Example keybindings
vim.keymap.set('n', '<leader><leader>t', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<leader><leader>t', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
