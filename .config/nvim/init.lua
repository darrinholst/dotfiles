vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after')
vim.cmd('let &packpath = &runtimepath')

vim.g.mapleader       = ","
vim.opt.number        = true --  show line numbers
vim.opt.laststatus    = 3 --     show the nvim global status line
vim.opt.cursorline    = true --  highlight current line
vim.opt.vb            = true --  no beeping
vim.opt.scrolloff     = 5 --     Start scrolling 5 lines away from margins
vim.opt.sidescrolloff = 10 --    Start scrolling 10 columns away from margins
vim.opt.signcolumn    = "yes"
vim.opt.timeoutlen    = 1000
vim.opt.ttimeoutlen   = 100
vim.opt.updatetime    = 300 --   Smaller updatetime for CursorHold & CursorHoldI
vim.opt.ignorecase    = true --  ignore case
vim.opt.smartcase     = true --  don't ignore case if there's an uppercase character
vim.opt.wrap          = false -- no line wrapping by default
vim.opt.tabstop       = 2 --     tab == 2 spaces
vim.opt.shiftwidth    = 2 --     autoindent == 2 spaces
vim.opt.softtabstop   = 2 --     don't use <Tab>s
vim.opt.expandtab     = true --  spaces, not tabs

vim.g.python_host_prog  = "/usr/bin/python"
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.node_host_prog    = "~/.nodenv/shims/node"

vim.opt.guifont = "Fura Code Retina Nerd Font Complete:h17"
vim.opt.termguicolors = true

vim.cmd("source ~/.vimrc")

require("my.cmp")
require("my.diagnostics")
require("my.filetypes")
require("my.folding")
require("my.formatter")
require("my.icons")
require("my.lsp")
require("my.surround")
require("my.telescope")
require("my.tree")
require("my.trouble")
require("my.vgit")
require("my.winbar")
