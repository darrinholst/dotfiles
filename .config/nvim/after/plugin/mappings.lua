local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ⌘C for copy (I'm not an animal)
map('', '<M-c>', '"*y', opts)

-- j/k with wrapped lines
map('', 'j', 'gj', opts)
map('', 'k', 'gk', opts)

-- scroll half pages and move cursor to middle of the screen
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)

-- moving lines
map('', '<C-k>', '<Plug>unimpairedMoveUp', opts)
map('', '<C-j>', '<Plug>unimpairedMoveDown', opts)
map('x', '<C-k>', '<Plug>unimpairedMoveSelectionUpgv', opts)
map('x', '<C-j>', '<Plug>unimpairedMoveSelectionDowngv', opts)

-- saving
map('i', '<F3>', '<esc><cmd>wall!|e<cr>', opts)
map('', '<F3>', '<cmd>wall!|e<cr>', opts)
map('', '<leader>w', '<cmd>w!|e<cr>', opts)
map('', '<leader>q', '<cmd>wall!|q<cr>', opts)

-- tree
map('', '<F6>', '<cmd>Neotree reveal<cr>', opts)
map('i', '<F6>', '<esc><cmd>Neotree reveal<cr>', opts)
map('', '<F7>', '<cmd>Neotree toggle<cr>', opts)
map('i', '<F7>', '<esc><cmd>Neotree toggle<cr>', opts)

-- git
map('n', '<leader>gg', '<cmd>Git | resize 20<cr>', opts)
map('n', '<leader>gp', '<cmd>Git push<cr>', opts)
map('n', '<leader>gb', '<cmd>Gitsigns blame_line<cr>', opts)
map('n', '<leader>gh', '<cmd>Gitsigns preview_hunk<cr>', opts)
map('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', opts)
map('n', ']h', '<cmd>Gitsigns next_hunk<cr>', opts)
map('n', '[h', '<cmd>Gitsigns prev_hunk<cr>', opts)

-- diagnostics
map('n', '<space>d', '<CMD>TroubleToggle<CR>')
map('n', '<space>e', vim.diagnostic.open_float, opts)
map('n', '[d', ':lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<cr>', opts)
map('n', ']d', ':lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<cr>', opts)
map('n', '<space>q', vim.diagnostic.setloclist, opts)

-- formatter
map('', '<C-f>', '<cmd>FormatWrite<cr>')
map('i', '<C-f>', '<esc><cmd>FormatWrite<cr>')

-- telescope
map('', '<leader>t', '<cmd>Telescope<cr>', opts)
map('', '<leader>y', '<cmd>Telescope yank_history<cr>', opts)
map('', '<leader>f', '<cmd>Telescope find_files<cr>', opts)
map('', '<C-p>', "<cmd>lua require('my/telescope-recipes').project_files()<cr>", opts)
map('', '<C-g>', ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", opts)
map('', '<leader>gw', require('telescope.builtin').grep_string, opts)
map('', '<C-b>', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)
map('', '<C-e>', '<cmd>Telescope buffers<cr>', opts)
map('', '<space>o', '<cmd>Telescope lsp_document_symbols<cr>', opts)
map('', '<space>r', '<cmd>Telescope resume<cr>', opts)
map('i', '^^', '<cmd>Telescope emoji<cr>', opts)


-- search
map('', '<leader>n', '<cmd>noh<cr>', opts)
map('', '<F4>', '<cmd>cn<cr>', opts)
map('', '<F16>', '<cmd>cp<cr>', opts)
map('v', '<C-r>', '<CMD>SearchReplaceSingleBufferVisualSelection<CR>', opts)
map('v', '<C-s>', '<CMD>SearchReplaceWithinVisualSelection<CR>', opts)
map('v', '<C-b>', '<CMD>SearchReplaceWithinVisualSelectionCWord<CR>', opts)
map('n', '<leader>rs', '<CMD>SearchReplaceSingleBufferSelections<CR>', opts)
map('n', '<leader>ro', '<CMD>SearchReplaceSingleBufferOpen<CR>', opts)
map('n', '<leader>rw', '<CMD>SearchReplaceSingleBufferCWord<CR>', opts)
map('n', '<leader>rW', '<CMD>SearchReplaceSingleBufferCWORD<CR>', opts)
map('n', '<leader>re', '<CMD>SearchReplaceSingleBufferCExpr<CR>', opts)
map('n', '<leader>rf', '<CMD>SearchReplaceSingleBufferCFile<CR>', opts)
map('n', '<leader>rbs', '<CMD>SearchReplaceMultiBufferSelections<CR>', opts)
map('n', '<leader>rbo', '<CMD>SearchReplaceMultiBufferOpen<CR>', opts)
map('n', '<leader>rbw', '<CMD>SearchReplaceMultiBufferCWord<CR>', opts)
map('n', '<leader>rbW', '<CMD>SearchReplaceMultiBufferCWORD<CR>', opts)
map('n', '<leader>rbe', '<CMD>SearchReplaceMultiBufferCExpr<CR>', opts)
map('n', '<leader>rbf', '<CMD>SearchReplaceMultiBufferCFile<CR>', opts)

-- cucumber
map('i', '<Bar>', '<Bar><Esc><cmd>call FormatGherkinTable()<cr>a', opts)

-- window management
map('', '<leader>z', '<cmd>ZoomWinTabToggle<cr>', { noremap = true })
map('', '<M-Down>', '<cmd>call DownHorizontal()<cr>', opts)
map('', '<M-Up>', '<cmd>call UpHorizontal()<cr>', opts)
map('', '<M-Right>', '<cmd>call RightVertical()<cr>', opts)
map('', '<M-Left>', '<cmd>call LeftVertical()<cr>', opts)
map('', '<leader><space>', '<cmd>wincmd =<cr>', opts)
map('', '<leader>h', '<cmd>wincmd h<cr>', opts)
map('', '<leader>j', '<cmd>wincmd j<cr>', opts)
map('', '<leader>k', '<cmd>wincmd k<cr>', opts)
map('', '<leader>l', '<cmd>wincmd l<cr>', opts)
map('', '<leader>cj', '<cmd>wincmd j<cr><cmd>close<cr>', opts)
map('', '<leader>ck', '<cmd>wincmd k<cr><cmd>close<cr>', opts)
map('', '<leader>ch', '<cmd>wincmd h<cr><cmd>close<cr>', opts)
map('', '<leader>cl', '<cmd>wincmd l<cr><cmd>close<cr>', opts)
map('', '<leader>cc', '<cmd>close<cr>', opts)
map('', '<leader>cw', '<cmd>cclose<cr>', opts)
map('', '<leader>bd', '<cmd>bd<cr>', opts)
map('', '<leader>p', '<plug>(choosewin)', opts)

-- debugging
map('n', '<F5>', ":lua require('dap').continue()<cr>", opts)
map('n', '<F10>', ":lua require('dap').step_over()<cr>", opts)
map('n', '<F11>', ":lua require('dap').step_into()<cr>", opts)
map('n', '<F12>', ":lua require('dap').step_out()<cr>", opts)
map('n', '<leader>b', ":lua require('dap').toggle_breakpoint()<cr>", opts)
map('n', '<leader>d', ":lua require('dapui').toggle()<cr>", opts)

-- vimux
map('', '<leader>vp', '<cmd>wa|VimuxPromptCommand<cr>', opts)
map('', '<leader>vl', '<cmd>wa|VimuxRunLastCommand<cr>', opts)

-- undo
map('n', '<leader>u', '<CMD>UndotreeToggle<CR>')

-- startify
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('Startify', { clear = true }),
  pattern = 'startify',
  callback = function()
    map('', 'r', '<cmd>Startify<cr>', { buffer = 0 })
  end,
})

-- quickfix
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  callback = function()
    map('', 'o', '<cr>|<cmd>ccl<cr>', { buffer = 0 })
  end,
})

-- auto manage hlsearch
vim.on_key(function(char)
  if vim.fn.mode() == 'n' then
    vim.opt.hlsearch = vim.tbl_contains({ '<CR>', 'n', 'N', '*', '#', '?', '/' }, vim.fn.keytrans(char))
  end
end, vim.api.nvim_create_namespace 'auto_hlsearch')

require('leap').add_default_mappings()
