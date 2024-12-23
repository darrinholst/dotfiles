return {
  {
    "stevearc/conform.nvim",
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local ignore_filetypes = { "json" }

        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end

        local bufname = vim.api.nvim_buf_get_name(bufnr)

        if bufname:match("/node_modules/") then
          return
        end

        return { timeout_ms = 500, lsp_fallback = true }
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        json = { "jq", "fixjson", "trim_whitespace" },
        javascript = { "eslint_d", "trim_whitespace" },
        javascriptreact = { "eslint_d", "trim_whitespace" },
        ["_"] = { "trim_whitespace" },
      },
    },
  },
}
