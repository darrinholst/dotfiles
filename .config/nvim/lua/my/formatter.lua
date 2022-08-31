require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,

  filetype = {
    json = {
      function()
        return nil
      end
    },

    ["*"] = {
      function()
        return { exe = "sed", args = { "-i", "''", "'s/[	 ]*$//'" } }
      end,
    }
  }
}

vim.keymap.set("", "<F5>", "<cmd>FormatWrite<cr>")
vim.keymap.set("i", "<F5>", "<esc><cmd>FormatWrite<cr>")
