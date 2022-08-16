require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
	},
	pickers = {
		buffers = {
			ignore_current_buffer = true,
			sort_lastused = true,
			sort_mru = true,
		},
	},
})

-- require('telescope').load_extension('coc')
require("telescope").load_extension("fzf")

vim.api.nvim_set_keymap("", "<leader>t", "<cmd>Telescope<CR>", { noremap = true })
vim.api.nvim_set_keymap("", "<leader>g", "<cmd>Telescope live_grep<CR>", { noremap = true })
vim.api.nvim_set_keymap("", "<C-b>", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { noremap = true })
vim.api.nvim_set_keymap("", "<C-f>", "<cmd>Telescope find_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("", "<C-p>", "<cmd>Telescope git_files<CR>", { noremap = true })
vim.api.nvim_set_keymap("", "<C-e>", "<cmd>Telescope buffers<CR>", { noremap = true })
vim.api.nvim_set_keymap("", "<space>o", "<cmd>Telescope lsp_document_symbols<CR>", { noremap = true })
