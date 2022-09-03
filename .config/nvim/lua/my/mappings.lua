local opts = { noremap = true, silent = true }

-- ⌘C for copy (I'm not an animal)
vim.keymap.set("", "<M-c>", '"*y', opts)

-- j/k with wrapped lines
vim.keymap.set("", "j", "gj", opts)
vim.keymap.set("", "k", "gk", opts)

-- moving lines
vim.keymap.set("", "<C-k>", "<Plug>unimpairedMoveUp", opts)
vim.keymap.set("", "<C-j>", "<Plug>unimpairedMoveDown", opts)
vim.keymap.set("x", "<C-k>", "<Plug>unimpairedMoveSelectionUpgv", opts)
vim.keymap.set("x", "<C-j>", "<Plug>unimpairedMoveSelectionDowngv", opts)

-- saving
vim.keymap.set("i", "<F3>", "<esc><cmd>wall!|e<cr>", opts)
vim.keymap.set("", "<F3>", "<cmd>wall!|e<cr>", opts)
vim.keymap.set("", "<leader>w", "<cmd>w!|e<cr>", opts)

-- floating terminal
vim.keymap.set("n", "<leader><leader>t", '<CMD>lua require("FTerm").toggle()<CR>', opts)
vim.keymap.set("t", "<leader><leader>t", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

-- tree
vim.keymap.set("", "<F6>", "<cmd>NvimTreeFindFile<cr>", opts)
vim.keymap.set("i", "<F6>", "<esc><cmd>NvimTreeFindFile<cr>", opts)
vim.keymap.set("", "<F7>", "<cmd>NvimTreeToggle<cr>", opts)
vim.keymap.set("i", "<F7>", "<esc><cmd>NvimTreeToggle<cr>", opts)

-- git
vim.keymap.set("n", "<leader>gg", "<cmd>Git | resize 20<cr>", opts)
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", opts)
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", opts)
vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", opts)
vim.keymap.set("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>", opts)
vim.keymap.set("n", "]h", "<cmd>Gitsigns next_hunk<cr>", opts)
vim.keymap.set("n", "[h", "<cmd>Gitsigns prev_hunk<cr>", opts)

-- diagnostics
vim.keymap.set("n", "<space>d", "<CMD>TroubleToggle<CR>")
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

-- formatter
vim.keymap.set("", "<F5>", "<cmd>FormatWrite<cr>")
vim.keymap.set("i", "<F5>", "<esc><cmd>FormatWrite<cr>")

-- telescope
vim.keymap.set("", "<leader>t", "<cmd>Telescope<cr>", opts)
vim.keymap.set("", "<C-p>", "<cmd>lua require('my/telescope-recipes').project_files()<cr>", opts)
vim.keymap.set("", "<C-g>", "<cmd>Telescope live_grep<cr>", opts)
vim.keymap.set("", "<C-b>", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
vim.keymap.set("", "<C-e>", "<cmd>Telescope buffers<cr>", opts)
vim.keymap.set("", "<space>o", "<cmd>Telescope lsp_document_symbols<cr>", opts)
vim.keymap.set("i", "^", "<cmd>Telescope emoji<cr>", opts)

-- search
vim.keymap.set("", "<leader>n", "<cmd>noh<cr>", opts)
vim.keymap.set("", "<F4>", "<cmd>cn<cr>", opts)
vim.keymap.set("", "<S-F4>", "<cmd>cp<cr>", opts)
vim.keymap.set("", "<C-F4>", " <cmd>cnf<cr>", opts)
vim.keymap.set("", "<S-C-F4>", "<cmd>cpf<cr>", opts)
vim.keymap.set("", "<leader>f", "<plug>(FerretAck)", {})
vim.keymap.set("", "<leader>F", "<plug>(FerretAckWord)", opts)

-- smalls
vim.keymap.set("n", "s", "<plug>(smalls)", opts)

-- cucumber
vim.keymap.set("i", "<Bar>", "<Bar><Esc><cmd>call FormatGherkinTable()<cr>a", opts)

-- window management
vim.keymap.set("", "<leader>z", "<cmd>ZoomWinTabToggle<cr>", { noremap = true })
vim.keymap.set("", "<M-Down>", "<cmd>call DownHorizontal()<cr>", opts)
vim.keymap.set("", "<M-Up>", "<cmd>call UpHorizontal()<cr>", opts)
vim.keymap.set("", "<M-Right>", "<cmd>call RightVertical()<cr>", opts)
vim.keymap.set("", "<M-Left>", "<cmd>call LeftVertical()<cr>", opts)
vim.keymap.set("", "<leader><space>", "<cmd>wincmd =<cr>", opts)
vim.keymap.set("", "<leader>h", "<cmd>wincmd h<cr>", opts)
vim.keymap.set("", "<leader>j", "<cmd>wincmd j<cr>", opts)
vim.keymap.set("", "<leader>k", "<cmd>wincmd k<cr>", opts)
vim.keymap.set("", "<leader>l", "<cmd>wincmd l<cr>", opts)
vim.keymap.set("", "<leader>cj", "<cmd>wincmd j<cr><cmd>close<cr>", opts)
vim.keymap.set("", "<leader>ck", "<cmd>wincmd k<cr><cmd>close<cr>", opts)
vim.keymap.set("", "<leader>ch", "<cmd>wincmd h<cr><cmd>close<cr>", opts)
vim.keymap.set("", "<leader>cl", "<cmd>wincmd l<cr><cmd>close<cr>", opts)
vim.keymap.set("", "<leader>cc", "<cmd>close<cr>", opts)
vim.keymap.set("", "<leader>cw", "<cmd>cclose<cr>", opts)
vim.keymap.set("", "<leader>sw", "<cmd>call WindowSwap#EasyWindowSwap()<cr>", opts)

-- vimux
vim.keymap.set("", "<leader>vp", "<cmd>wa|VimuxPromptCommand<cr>", opts)
vim.keymap.set("", "<leader>vl", "<cmd>wa|VimuxRunLastCommand<cr>", opts)

-- startify
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("Startify", { clear = true }),
  pattern = "startify",

  callback = function()
    vim.keymap.set("", "r", "<cmd>Startify<cr>", { buffer = 0 })
  end
})

-- quickfix
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",

  callback = function()
    vim.keymap.set("", "o", "<cr>|<cmd>ccl<cr>", { buffer = 0 })
  end
})
