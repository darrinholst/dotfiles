vim.keymap.set("n", "ggg", "<cmd>Git | resize 20<cr>")
vim.keymap.set("n", "ggp", "<cmd>Git push<cr>")
vim.keymap.set("n", "ggb", "<cmd>Git blame<cr>")
vim.keymap.set("n", "ggh", "<cmd>Gitsigns preview_hunk<cr>")
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>")
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>")

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
