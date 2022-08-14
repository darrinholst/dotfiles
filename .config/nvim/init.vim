set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc

lua << EOF
  require('dh.fiik')
  require('dh.nvim-tree')
  require('dh.nvim-surround')
  require('dh.telescope')
EOF

