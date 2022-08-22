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
