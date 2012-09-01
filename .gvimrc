if has('gui_running')
  " Ctrl P
  let g:ctrlp_match_window_reversed = 0
  au FocusGained * :ClearCtrlPCache

endif

if has("gui_macvim")
  " Command-p for fuzzy finder
  macmenu &File.Print key=<D-P>
  map <D-p> :CtrlPCurWD<CR>
  imap <D-p> <Esc>:CtrlPCurWD<CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i
endif


