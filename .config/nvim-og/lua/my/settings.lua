vim.g.mapleader        = ','
vim.opt.cursorline     = true --  highlight current line
vim.opt.cmdheight      = 2
vim.opt.expandtab      = true --  spaces, not tabs
vim.opt.guifont        = 'Fira Code Retina Nerd Font Complete:h16'
vim.opt.ignorecase     = true --  ignore case
vim.opt.laststatus     = 3    --     show the nvim global status line
vim.opt.swapfile       = false
vim.opt.backup         = false
vim.opt.number         = true
vim.opt.relativenumber = false
vim.opt.scrolloff      = 5    --     Start scrolling 5 lines away from margins
vim.opt.shiftwidth     = 2    --     autoindent == 2 spaces
vim.opt.sidescrolloff  = 10   --    Start scrolling 10 columns away from margins
vim.opt.signcolumn     = 'yes'
vim.opt.smartcase      = true --  don't ignore case if there's an uppercase character
vim.opt.softtabstop    = 2    --     don't use <Tab>s
vim.opt.tabstop        = 2    --     tab == 2 spaces
vim.opt.termguicolors  = true
vim.opt.timeoutlen     = 1000
vim.opt.ttimeoutlen    = 100
vim.opt.updatetime     = 300   --   Smaller updatetime for CursorHold & CursorHoldI
-- vim.opt.inccommand     = 'split' -- show the effects of a search / replace in a live preview window
vim.opt.vb             = true  --  no beeping
vim.opt.wrap           = false -- no line wrapping by default
vim.opt.hlsearch       = true
vim.opt.undofile       = true
vim.wo.foldlevel       = 99
vim.wo.foldmethod      = 'expr'
vim.wo.foldexpr        = 'nvim_treesitter#foldexpr()'


vim.g.choosewin_overlay_enable = 1
vim.g.VimuxOrientation         = 'h'
vim.g.VimuxHeight              = '30'
vim.g.csv_no_conceal           = 1
vim.g.do_filetype_lua          = 1

vim.g.python_host_prog         = '/usr/bin/python'
vim.g.python3_host_prog        = '/usr/bin/python3'