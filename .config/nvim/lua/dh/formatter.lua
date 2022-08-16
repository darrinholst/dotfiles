local util = require("formatter.util")

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,

	filetype = {
		lua = {
			require("formatter.filetypes.lua").stylua,
		},

		["*"] = {
			function()
				return { exe = "sed", args = { "-i", "''", "'s/[	 ]*$//'" } }
			end,
		},
	},
})

vim.api.nvim_set_keymap("", "<F5>", ":FormatWrite<CR>", { silent = true })
vim.api.nvim_set_keymap("i", "<F5>", "<Esc>:FormatWrite<CR>", { silent = true })
