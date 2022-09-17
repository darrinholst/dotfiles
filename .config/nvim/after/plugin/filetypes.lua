vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",

  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "81"
    vim.opt_local.spell = true
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact" },

  callback = function()
    vim.opt_local.colorcolumn = "81"
  end
})
