let s:theme_name_path = expand("~/.config/tinted-theming/theme_name")
if filereadable(s:theme_name_path)
  let s:theme_name = readfile(s:theme_name_path)[0]
  if s:theme_name =~ '^catppuccin-'
    execute 'colorscheme ' . s:theme_name
  else
    execute 'colorscheme base16-' . s:theme_name
  endif
else
  colorscheme catppuccin-mocha
endif

" // in visual mode to search buffer for selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>    

map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" remember last location in files
au BufReadPost * if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" Control font size
nmap <D-+> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR>
nmap <D--> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR>

" focus lost
au FocusLost * nested :silent! wall!         " Save on FocusLost
au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost
