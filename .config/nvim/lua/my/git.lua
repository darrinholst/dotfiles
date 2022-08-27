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
