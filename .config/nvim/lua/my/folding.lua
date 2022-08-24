vim.wo.foldmethod = "indent"

-- Treesitter is folding automatically after reading the buffer somehow
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

local group = vim.api.nvim_create_augroup("OpenEm", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
  group = group,
  callback = function()
    vim.schedule(function()
      vim.cmd("normal zR")
    end)
  end,
})
