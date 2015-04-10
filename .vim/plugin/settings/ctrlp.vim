let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|build\|target\|vendor\/bundle\|vendor\/cache'
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_window_reversed = 0
au FocusGained * :ClearCtrlPCache

map <C-e> :<C-U>CtrlPBuffer<CR>
imap <C-e> <ESC>:<C-U>CtrlPBuffer<CR>

