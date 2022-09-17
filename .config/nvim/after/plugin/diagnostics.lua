vim.cmd("sign define DiagnosticSignError text= linehl= texthl=DiagnosticSignError numhl=")
vim.cmd("sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl=")
vim.cmd("sign define DiagnosticSignInfo text= linehl= texthl=DiagnosticSignInfo numhl=")
vim.cmd("sign define DiagnosticSignHint text= linehl= texthl=DiagnosticSignHint numhl=")

vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
