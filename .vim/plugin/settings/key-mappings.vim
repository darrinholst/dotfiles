nmap <silent> <leader>n :set invhls<CR>
nmap <silent> <leader>w :bd<CR>

" Commenter
map <leader>/ <plug>NERDCommenterToggle<CR>
" imap <leader>/ <Esc><plug>NERDCommenterToggle<CR>i

" Window Commands
noremap <silent> <leader>h :wincmd h<CR>
noremap <silent> <leader>j :wincmd j<CR>
noremap <silent> <leader>k :wincmd k<CR>
noremap <silent> <leader>l :wincmd l<CR>
noremap <silent> <leader>cj :wincmd j<CR>:close<CR>
noremap <silent> <leader>ck :wincmd k<CR>:close<CR>
noremap <silent> <leader>ch :wincmd h<CR>:close<CR>
noremap <silent> <leader>cl :wincmd l<CR>:close<CR>
noremap <silent> <leader>cc :close<CR>
noremap <silent> <leader>cw :cclose<CR>
noremap <silent> <S-Up> 5<C-W>+
noremap <silent> <S-Down> 5<C-W>-
noremap <silent> <S-Left> 5<C-W><
noremap <silent> <S-Right> 5<C-W>>

" wrapped lines support
nnoremap j gj
nnoremap k gk

" File Browser
map <F6> :NERDTreeFind<CR>
imap <F6> <Esc>:NERDTreeFind<CR>
map <F7> :NERDTreeToggle<CR>
imap <F7> <Esc>:NERDTreeToggle<CR>

" Opens an edit command with the path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a rename command with the path of the currently edited file filled in
map <Leader>r :Rename <C-R>=expand("%:p") <CR>

nmap <D-+> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR>
nmap <D--> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR>

function UnmapKeys()
"  if has("gui_macvim")
    nunmap ,lj
    nunmap ,lg
    nunmap ,lb
    nunmap ,lr
    nunmap ,lf
    nunmap ,cl
    vunmap ,cl
    noremap <silent> <leader>cl :wincmd l<CR>:close<CR>
"  endif
endfunction

autocmd VimEnter * call UnmapKeys()
