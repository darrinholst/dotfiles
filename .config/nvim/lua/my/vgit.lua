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

vim.api.nvim_set_keymap("", "<space>gb", "<cmd>VGit toggle_live_blame<cr><cmd>VGit toggle_authorship_code_lens<cr>", { noremap = true })
