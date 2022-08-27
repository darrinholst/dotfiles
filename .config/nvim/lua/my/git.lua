vim.keymap.set('n', '<space>gg', '<cmd>Git | resize 20<cr>')
vim.keymap.set('n', '<space>gp', '<cmd>Git push<cr>')
vim.keymap.set('n', '<space>gb', '<cmd>Git blame<cr>')

require('vgit').setup({
  settings = {
    live_blame = {
      enabled = false,
    },
    authorship_code_lens = {
      enabled = false,
    },
  }
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",

  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "73"
    vim.opt_local.spell = true
  end
})
