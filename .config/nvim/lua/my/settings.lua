vim.g.mapleader = ","
vim.g.startify_change_to_vcs_root = 1

-- vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.backup = false
vim.opt.breakindent = true -- Enable break indent
vim.opt.cmdheight = 1
vim.opt.cursorline = true --  highlight current line
vim.opt.expandtab = true --  spaces, not tabs
vim.opt.hlsearch = true
vim.opt.ignorecase = true --  ignore case
vim.opt.inccommand = "split" -- Preview substitutions live, as you type!
vim.opt.laststatus = 3 --     show the nvim global status line
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.scrolloff = 5 --     Start scrolling 5 lines away from margins
vim.opt.shiftwidth = 2 --     autoindent == 2 spaces
vim.opt.showmode = false
vim.opt.sidescrolloff = 10 --    Start scrolling 10 columns away from margins
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true --  don't ignore case if there's an uppercase character
vim.opt.softtabstop = 2 --     don't use <Tab>s
vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.swapfile = false
vim.opt.tabstop = 2 --     tab == 2 spaces
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 100
vim.opt.undofile = true
vim.opt.updatetime = 300 --   Smaller updatetime for CursorHold & CursorHoldI
vim.opt.vb = true --  no beeping
vim.opt.wrap = false -- no line wrapping by default

vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldlevel = 99
vim.wo.foldmethod = "expr"

vim.g.VimuxHeight = "30"
vim.g.VimuxOrientation = "h"
vim.g.choosewin_overlay_enable = 1
vim.g.csv_no_conceal = 1
vim.g.do_filetype_lua = 1

-- Hide tab characters in Go files (Go uses tabs by convention)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.list = false
  end,
})
