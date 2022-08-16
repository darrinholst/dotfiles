set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc

lua << EOF
  require('dh.cmp')
  require('dh.formatter')
  require('dh.lsp')
  require('dh.surround')
  require('dh.telescope')
  require('dh.tree')
  require('dh.trouble')
  require('dh.vgit')
  require('dh.winbar')
EOF

