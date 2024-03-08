local function map(mode, key, cmd, opts)
  vim.keymap.set(mode, key, cmd, vim.tbl_deep_extend("force", { noremap = true, silent = true }, opts or {}))
end

-- LSP
map("", "<leader>rl", "<cmd>LspRestart<cr>", { desc = "Restart the LSP" })
map("", "<leader>n", "<cmd>nohlsearch<cr>")
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ⌘C for copy (I'm not an animal)
map("", "<M-c>", '"*y')

-- j/k with wrapped lines
map("", "j", "gj")
map("", "k", "gk")

-- scroll half pages and move cursor to middle of the screen
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- moving lines
map("", "<C-k>", "<Plug>unimpairedMoveUp")
map("", "<C-j>", "<Plug>unimpairedMoveDown")
map("x", "<C-k>", "<Plug>unimpairedMoveSelectionUpgv")
map("x", "<C-j>", "<Plug>unimpairedMoveSelectionDowngv")

-- saving
map("i", "<F3>", "<esc><cmd>wall!|e<cr>")
map("", "<F3>", "<cmd>wall!|e<cr>")
map("", "<leader>w", "<cmd>w!|e<cr>")
map("", "<leader>q", "<cmd>wall!|q<cr>")

-- tree
map("", "<F6>", "<cmd>Neotree reveal<cr>")
map("i", "<F6>", "<esc><cmd>Neotree reveal<cr>")
map("", "<F7>", "<cmd>Neotree toggle<cr>")
map("i", "<F7>", "<esc><cmd>Neotree toggle<cr>")

-- git
map("n", "<leader>gg", "<cmd>Git | resize 20<cr>")
map("n", "<leader>gp", "<cmd>Git push<cr>")
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<cr>")
map("n", "<leader>gB", "<cmd>Git blame<cr>")
map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>")
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>")
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>")
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>")

-- diagnostics
map("n", "<space>d", "<CMD>TroubleToggle<CR>")
map("n", "<space>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<space>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- formatter
map("", "<C-f>", "<cmd>lua require('conform').format()<cr>")
map("i", "<C-f>", "<esc><cmd>lua require('conform').format()<cr>")
-- map("", "<C-f>", "<cmd>FormatWrite<cr>")
-- map("i", "<C-f>", "<esc><cmd>FormatWrite<cr>")

-- telescope
map("", "<leader>t", "<cmd>Telescope<cr>")
map("", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Search keymaps" })
map("", "<leader>y", "<cmd>Telescope yank_history<cr>", { desc = "Search yank history" })
map("", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find file" })
map("", "<C-p>", "<cmd>lua require('my/telescope-recipes').project_files()<cr>", { desc = "Find project file" })
map("", "<C-g>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Grep project" })
map("", "<leader>gw", require("telescope.builtin").grep_string, { desc = "Grep current word" })
map("", "<C-b>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in current buffer" })
map("", "<C-e>", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("", "<space>o", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })
map("", "<space>r", "<cmd>Telescope resume<cr>", { desc = "Resume last telescope" })
map("i", "^^", "<cmd>Telescope emoji<cr>")

-- search
map("", "<F4>", "<cmd>cn<cr>")
map("", "<F16>", "<cmd>cp<cr>")
map("v", "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>")
map("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>")
map("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>")
map("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>")
map("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>")
map("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>")
map("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>")
map("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>")
map("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>")
map("n", "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>")
map("n", "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>")
map("n", "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>")
map("n", "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>")
map("n", "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>")
map("n", "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>")

-- cucumber
map("i", "<Bar>", "<Bar><Esc><cmd>call FormatGherkinTable()<cr>a")

-- window management
map("", "<leader>z", "<cmd>ZoomWinTabToggle<cr>")
map("", "<M-Down>", "<cmd>call DownHorizontal()<cr>")
map("", "<M-Up>", "<cmd>call UpHorizontal()<cr>")
map("", "<M-Right>", "<cmd>call RightVertical()<cr>")
map("", "<M-Left>", "<cmd>call LeftVertical()<cr>")
map("", "<leader><space>", "<cmd>wincmd =<cr>")
map("", "<leader>h", "<cmd>wincmd h<cr>")
map("", "<leader>j", "<cmd>wincmd j<cr>")
map("", "<leader>k", "<cmd>wincmd k<cr>")
map("", "<leader>l", "<cmd>wincmd l<cr>")
map("", "<leader>cj", "<cmd>wincmd j<cr><cmd>close<cr>")
map("", "<leader>ck", "<cmd>wincmd k<cr><cmd>close<cr>")
map("", "<leader>ch", "<cmd>wincmd h<cr><cmd>close<cr>")
map("", "<leader>cl", "<cmd>wincmd l<cr><cmd>close<cr>")
map("", "<leader>cc", "<cmd>close<cr>")
map("", "<leader>cw", "<cmd>cclose<cr>")
map("", "<leader>bd", "<cmd>bd<cr>")
map("", "<leader>p", "<plug>(choosewin)")

-- debugging
-- map('n', '<F5>', ":lua require('dap').continue()<cr>")
-- map('n', '<F10>', ":lua require('dap').step_over()<cr>")
-- map('n', '<F11>', ":lua require('dap').step_into()<cr>")
-- map('n', '<F12>', ":lua require('dap').step_out()<cr>")
-- map('n', '<leader>b', ":lua require('dap').toggle_breakpoint()<cr>")
-- map('n', '<leader>d', ":lua require('dapui').toggle()<cr>")

-- vimux
map("", "<leader>vp", "<cmd>wa|VimuxPromptCommand<cr>")
map("", "<leader>vl", "<cmd>wa|VimuxRunLastCommand<cr>")

-- undo
map("n", "<leader>u", "<CMD>UndotreeToggle<CR>")

-- auto manage hlsearch
vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    vim.opt.hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
  end
end, vim.api.nvim_create_namespace("auto_hlsearch"))
