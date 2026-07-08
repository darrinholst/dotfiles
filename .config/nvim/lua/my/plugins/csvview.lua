return {
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    config = function()
      require("csvview").setup({
        parser = { comments = { "#", "//" } },
        view = {
          display_mode = "border",
        },
        keymaps = {
          textobject_field_inner = { "if", mode = { "o", "x" } },
          textobject_field_outer = { "af", mode = { "o", "x" } },
          jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
          jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
          jump_next_row = { "<Enter>", mode = { "n", "v" } },
          jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
        },
      })

      local function clear_csv_colors()
        for i = 0, 8 do
          vim.api.nvim_set_hl(0, "CsvViewCol" .. i, { link = "Normal" })
          vim.api.nvim_set_hl(0, "csvCol" .. i, { link = "Normal" })
        end
      end

      clear_csv_colors()

      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = clear_csv_colors,
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "csv", "tsv" },
        callback = function() vim.cmd("CsvViewEnable") end,
      })
    end,
  },
}
