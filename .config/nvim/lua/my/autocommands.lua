vim.api.nvim_create_autocmd("FileType", {
  desc = "Refresh the cow",
  group = vim.api.nvim_create_augroup("Startify", { clear = true }),
  pattern = "startify",
  callback = function()
    vim.keymap.set("", "r", "<cmd>Startify<cr>", { buffer = 0 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Open qf item and close",
  pattern = "qf",
  callback = function()
    vim.keymap.set("", "o", "<cr>|<cmd>ccl<cr>", { buffer = 0 })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "81"
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.colorcolumn = "81"
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",

  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "73"
    vim.opt_local.spell = true
  end,
})
