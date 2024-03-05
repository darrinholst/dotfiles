require("formatter").setup {
  logging = true,
  log_level = vim.log.levels.WARN,

  filetype = {
    cucumber = {
      -- npm i -g source-map-support @cucumber/gherkin @cucumber/gherkin-utils
      function()
        return { exe = "gherkin-utils", args = { "format", }, stdin = true }
      end
    },

    ["*"] = {
      function()
        return { exe = "sed", args = { "-i", "''", "'s/[	 ]*$//'" } }
      end,
    }
  }
}
