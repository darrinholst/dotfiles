return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = "davidmh/cspell.nvim",
    config = function()
      local null_ls = require("null-ls")
      local cspell = require("cspell")
      local cspell_config = {
        diagnostics_postprocess = function(diagnostic)
          diagnostic.severity = vim.diagnostic.severity["HINT"] -- ERROR, WARN, INFO, HINT
        end,
        diagnostic_config = {
          underline = true,
          virtual_text = false,
          signs = false,
        },
        config = {
          on_success = function(cspell_config_file_path, params, action_name)
            if action_name == "add_to_json" then
              os.execute(
                string.format(
                  "cat %s | jq -S '.words |= sort' | tee %s > /dev/null",
                  cspell_config_file_path,
                  cspell_config_file_path
                )
              )
            end
          end,
        },
      }
      null_ls.setup({
        sources = {
          cspell.diagnostics.with(cspell_config),
          cspell.code_actions.with(cspell_config),
        },
      })
    end,
  },
}
