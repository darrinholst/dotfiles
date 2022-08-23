vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

local group = vim.api.nvim_create_augroup("OpenEm", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
  group = group,
  command = "normal zR"
})
