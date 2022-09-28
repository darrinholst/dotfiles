local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ⌘C for copy (I'm not an animal)
map("", "<M-c>", '"*y', opts)

-- j/k with wrapped lines
map("", "j", "gj", opts)
map("", "k", "gk", opts)

-- moving lines
map("", "<C-k>", "<Plug>unimpairedMoveUp", opts)
map("", "<C-j>", "<Plug>unimpairedMoveDown", opts)
map("x", "<C-k>", "<Plug>unimpairedMoveSelectionUpgv", opts)
map("x", "<C-j>", "<Plug>unimpairedMoveSelectionDowngv", opts)

-- saving
map("i", "<F3>", "<esc><cmd>wall!|e<cr>", opts)
map("", "<F3>", "<cmd>wall!|e<cr>", opts)
map("", "<leader>w", "<cmd>w!|e<cr>", opts)
map("", "<leader>q", "<cmd>wall!|q<cr>", opts)

-- tree
map("", "<F6>", "<cmd>NvimTreeFindFile<cr>", opts)
map("i", "<F6>", "<esc><cmd>NvimTreeFindFile<cr>", opts)
map("", "<F7>", "<cmd>NvimTreeToggle<cr>", opts)
map("i", "<F7>", "<esc><cmd>NvimTreeToggle<cr>", opts)

-- git
map("n", "<leader>gg", "<cmd>Git | resize 20<cr>", opts)
map("n", "<leader>gp", "<cmd>Git push<cr>", opts)
map("n", "<leader>gb", "<cmd>Git blame<cr>", opts)
map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", opts)
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", opts)
map("n", "]h", "<cmd>Gitsigns next_hunk<cr>", opts)
map("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", opts)

-- diagnostics
map("n", "<space>d", "<CMD>TroubleToggle<CR>")
map("n", "<space>e", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
map("n", "<space>q", vim.diagnostic.setloclist, opts)

-- formatter
map("", "<C-f>", "<cmd>FormatWrite<cr>")
map("i", "<C-f>", "<esc><cmd>FormatWrite<cr>")

-- telescope
map("", "<leader>t", "<cmd>Telescope<cr>", opts)
map("", "<leader>y", "<cmd>Telescope yank_history<cr>", opts)
map("", "<C-p>", "<cmd>lua require('my/telescope-recipes').project_files()<cr>", opts)
map("", "<C-g>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
map("", "<C-b>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
map("", "<C-e>", "<cmd>Telescope buffers<cr>", opts)
map("", "<space>o", "<cmd>Telescope lsp_document_symbols<cr>", opts)
map("i", "^^", "<cmd>Telescope emoji<cr>", opts)

-- search
map("", "<leader>n", "<cmd>noh<cr>", opts)
map("", "<F4>", "<cmd>cn<cr>", opts)
map("", "<S-F4>", "<cmd>cp<cr>", opts)
map("", "<C-F4>", " <cmd>cnf<cr>", opts)
map("", "<S-C-F4>", "<cmd>cpf<cr>", opts)
map("", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
map("", "<M-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
map("", "<M-F>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
map("x", "<M-F>", ":lua require('telescope').extensions.live_grep_args.live_grep_args({default_text = 'figure out how to get selection in here'})<CR>", opts)

-- smalls
map("n", "s", "<plug>(smalls)", opts)

-- cucumber
map("i", "<Bar>", "<Bar><Esc><cmd>call FormatGherkinTable()<cr>a", opts)

-- window management
map("", "<leader>z", "<cmd>ZoomWinTabToggle<cr>", { noremap = true })
map("", "<M-Down>", "<cmd>call DownHorizontal()<cr>", opts)
map("", "<M-Up>", "<cmd>call UpHorizontal()<cr>", opts)
map("", "<M-Right>", "<cmd>call RightVertical()<cr>", opts)
map("", "<M-Left>", "<cmd>call LeftVertical()<cr>", opts)
map("", "<leader><space>", "<cmd>wincmd =<cr>", opts)
map("", "<leader>h", "<cmd>wincmd h<cr>", opts)
map("", "<leader>j", "<cmd>wincmd j<cr>", opts)
map("", "<leader>k", "<cmd>wincmd k<cr>", opts)
map("", "<leader>l", "<cmd>wincmd l<cr>", opts)
map("", "<leader>cj", "<cmd>wincmd j<cr><cmd>close<cr>", opts)
map("", "<leader>ck", "<cmd>wincmd k<cr><cmd>close<cr>", opts)
map("", "<leader>ch", "<cmd>wincmd h<cr><cmd>close<cr>", opts)
map("", "<leader>cl", "<cmd>wincmd l<cr><cmd>close<cr>", opts)
map("", "<leader>cc", "<cmd>close<cr>", opts)
map("", "<leader>cw", "<cmd>cclose<cr>", opts)
map("", "<leader>bd", "<cmd>bd<cr>", opts)
map("", "<leader>p", "<plug>(choosewin)", opts)

-- debugging
map("n", "<F5>", ":lua require('dap').continue()<cr>", opts)
map("n", "<F10>", ":lua require('dap').step_over()<cr>", opts)
map("n", "<F11>", ":lua require('dap').step_into()<cr>", opts)
map("n", "<F12>", ":lua require('dap').step_out()<cr>", opts)
map("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<cr>", opts)
map("n", "<leader>d", ":lua require('dapui').toggle()<cr>", opts)

-- vimux
map("", "<leader>vp", "<cmd>wa|VimuxPromptCommand<cr>", opts)
map("", "<leader>vl", "<cmd>wa|VimuxRunLastCommand<cr>", opts)

-- startify
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("Startify", { clear = true }),
  pattern = "startify",

  callback = function()
    map("", "r", "<cmd>Startify<cr>", { buffer = 0 })
  end
})

-- quickfix
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",

  callback = function()
    map("", "o", "<cr>|<cmd>ccl<cr>", { buffer = 0 })
  end
})

-- harpoon
map("", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)
map("", "<leader>ha", ":lua require('harpoon.mark').add_file()<cr>", opts)
map("", "<leader>ht", "<cmd>Telescope harpoon marks<cr>", opts)
map("", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", opts)
map("", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<cr>", opts)
map("", "<leader>h1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", opts)
map("", "<leader>h2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", opts)
map("", "<leader>h3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", opts)
map("", "<leader>h4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", opts)
map("", "<leader>h5", "<cmd>lua require('harpoon.ui').nav_file(5)<cr>", opts)
map("", "<leader>h6", "<cmd>lua require('harpoon.ui').nav_file(6)<cr>", opts)
map("", "<leader>h7", "<cmd>lua require('harpoon.ui').nav_file(7)<cr>", opts)
map("", "<leader>h8", "<cmd>lua require('harpoon.ui').nav_file(8)<cr>", opts)
map("", "<leader>h9", "<cmd>lua require('harpoon.ui').nav_file(9)<cr>", opts)
