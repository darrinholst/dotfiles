if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  color base16-tomorrow-night
endif

" // in visual mode to search buffer for selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>    

" remember last location in files
au BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" Control font size
nmap <D-+> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR>
nmap <D--> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR>

" focus lost
au FocusLost * nested :silent! wall!         " Save on FocusLost
au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost
