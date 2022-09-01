require("gitsigns").setup({
  signs = {
    add          = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change       = { hl = "GitSignsChange", text = "│", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete       = { hl = "GitSignsDelete", text = "|", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete    = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "|", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
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
