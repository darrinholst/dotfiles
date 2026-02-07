local function map(mode, key, cmd, opts)
  vim.keymap.set(mode, key, cmd, vim.tbl_deep_extend("force", { noremap = true, silent = true }, opts or {}))
end

-- esc
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", "<Esc>")
vim.keymap.set("v", "<C-c>", "<Esc>")
vim.keymap.set("c", "<C-c>", "<Esc>")

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
map("n", "<space>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
map("n", "<space>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
map(
  "n",
  "[d",
  "<cmd>lua vim.diagnostic.goto_prev({ wrap = true, severity = vim.diagnostic.severity.ERROR })<CR>",
  { desc = "Go to previous [D]iagnostic message" }
)
map(
  "n",
  "]d",
  "<cmd>lua vim.diagnostic.goto_next({ wrap = true, severity = vim.diagnostic.severity.ERROR })<CR>",
  { desc = "Go to next [D]iagnostic message" }
)

-- formatter
map("", "<C-f>", "<cmd>lua require('conform').format({lsp_fallback=true, async=true})<cr>")
map("i", "<C-f>", "<esc><cmd>lua require('conform').format({lsp_fallback=true, async=true})<cr>")

-- pickers
map("", "<leader>y", "<cmd>YankyRingHistory<cr>", { desc = "Search yank history" })
map("i", "^^", function() Snacks.picker.icons() end, { desc = "Emoji picker" })

-- search
map("", "<F4>", "<cmd>cn<cr>")
map("", "<F16>", "<cmd>cp<cr>")

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

-- oil
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- auto manage hlsearch
vim.on_key(function(char)
  if vim.fn.mode() == "n" then
    vim.opt.hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
  end
end, vim.api.nvim_create_namespace "auto_hlsearch")
