require("nvim-tree").setup({
  create_in_closed_folder = true,
  git = {
    enable = true,
    ignore = false,
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",

  callback = function()
    vim.diagnostic.disable(0)
  end
})
