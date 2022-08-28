vim.g.startify_change_to_vcs_root = 1

vim.api.nvim_create_autocmd("FileType", {
  pattern = "startify",

  callback = function()
    vim.keymap.set("", "r", "<cmd>Startify<cr>", { buffer = 0 })
  end
})
