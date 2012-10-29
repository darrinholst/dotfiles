let g:ctrlp_match_window_reversed = 0
au FocusGained * :ClearCtrlPCache

map <C-e> :<C-U>CtrlPBuffer<CR>
imap <C-e> <ESC>:<C-U>CtrlPBuffer<CR>

