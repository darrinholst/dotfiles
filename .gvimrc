if has("gui_macvim")
  " Ctrl P
  let g:ctrlp_match_window_reversed = 0
  au FocusGained * :ClearCtrlPCache
  macmenu &File.New\ Tab key=<D-T>
  macmenu &File.Print key=<D-P>
  map <D-t> :CtrlPCurWD<CR>
  map <D-p> :CtrlPCurWD<CR>
  imap <D-t> <Esc>:CtrlPCurWD<CR>
  imap <D-p> <Esc>:CtrlPCurWD<CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

  " File Browser
  map <S-F7> :maca openFileBrowser:<cr>
  map <F7> :maca toggleFileBrowser:<cr>
endif

