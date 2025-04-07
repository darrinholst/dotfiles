local x = vim.diagnostic.severity

vim.diagnostic.config({
  virtual_text = false,
  signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
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
