vim.cmd('set runtimepath^=~/.vim runtimepath+=~/.vim/after')
vim.cmd('let &packpath = &runtimepath')
vim.cmd("source ~/.vimrc")

require("my.cmp")
require("my.diagnostics")
require("my.formatter")
require("my.icons")
require("my.lsp")
require("my.surround")
require("my.telescope")
require("my.tree")
require("my.trouble")
require("my.vgit")
require("my.winbar")