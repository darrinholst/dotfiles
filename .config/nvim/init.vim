set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc

lua << EOF
  require('my.icons')
  require('my.cmp')
  require('my.diagnostics')
  require('my.formatter')
  require('my.lsp')
  require('my.surround')
  require('my.telescope')
  require('my.tree')
  require('my.trouble')
  require('my.vgit')
  require('my.winbar')
EOF

