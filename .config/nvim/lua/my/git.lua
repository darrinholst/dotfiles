vim.keymap.set('n', '<space>g', '<cmd>Git | resize 20<cr>')

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
  end
})
