require("filetype").setup({
  overrides = {
    extensions = {
      eslintrc = "json",
      babelrc = "json",
      envrc = "sh",
      env = "sh",
    },
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",

  callback = function()
    vim.opt_local.textwidth = 72
    vim.opt_local.colorcolumn = "73"
    vim.opt_local.spell = true
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",

  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.colorcolumn = "81"
    vim.opt_local.spell = true
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "javascript",

  callback = function()
    vim.opt_local.colorcolumn = "81"
  end
})