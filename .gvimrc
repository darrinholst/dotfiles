if has("gui_macvim")
  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-W closes buffer
  macmenu &File.Close key=<nop>
  map <D-w> :bd<CR>
  imap <D-w> <Esc>:bd<CR>

  " Command-T for CommandT
  macmenu &File.New\ Tab key=<D-T>
  " map <D-t> :CommandT<CR>
  " imap <D-t> <Esc>:CommandT<CR>

  let g:ctrlp_match_window_reversed = 0
  map <D-t> :CtrlPCurWD<CR>
  imap <D-t> <Esc>:CtrlPCurWD<CR>

  " Command-Return for fullscreen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>

  " Command-e for ConqueTerm
  map <D-e> :call StartTerm()<CR>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>i

  " Command-][ to increase/decrease indentation
  vmap <D-]> >gv
  vmap <D-[> <gv

  " Command-Option-ArrowKey to switch viewports
  map <D-M-Up> <C-w>k
  imap <D-M-Up> <Esc> <C-w>k
  map <D-M-Down> <C-w>j
  imap <D-M-Down> <Esc> <C-w>j
  map <D-M-Right> <C-w>l
  imap <D-M-Right> <Esc> <C-w>l
  map <D-M-Left> <C-w>h
  imap <D-M-Left> <C-w>h

  " File Browser
  map <S-F7> :maca openFileBrowser:<cr>
  map <F7> :maca toggleFileBrowser:<cr>
else
  " Ctrl-T for Command-T
  map <C-t> :CommandT<CR>
  imap <C-t> <Esc>:CommandT<CR>

  " Ctrl-Shift-F for Ack
  map <C-F> :Ack<space>

  " Alt-][ to increase/decrease indentation
  vmap <A-]> >gv
  vmap <A-[> <gv

  " Ctrl-Option-ArrowKey to switch viewports
  map <C-S-Up> <C-w>k
  imap <C-S-Up> <Esc> <C-w>k
  map <C-S-Down> <C-w>j
  imap <C-S-Down> <Esc> <C-w>j
  map <C-S-Right> <C-w>l
  imap <C-S-Right> <Esc> <C-w>l
  map <C-S-Left> <C-w>h
  imap <C-S-Left> <C-w>h
endif

" Don't beep
set visualbell

" Start without the toolbar
set guioptions-=T

" No vertical scrollbar
set guioptions-=r

" Default gui color scheme
color ir_black

" ConqueTerm wrapper
function StartTerm()
  execute 'ConqueTerm ' . $SHELL . ' --login'
  setlocal listchars=tab:\ \
endfunction

