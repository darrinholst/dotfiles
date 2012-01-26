nmap <silent> <leader>n :set invhls<CR>
nmap <silent> <leader>w :bd<CR>

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

" Opens an edit command with the path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a rename command with the path of the currently edited file filled in
map <Leader>r :Rename <C-R>=expand("%:p") <CR>
