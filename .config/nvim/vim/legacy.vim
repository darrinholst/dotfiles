" colors
colorscheme base16-tomorrow-night
set t_Co=256
let base16colorspace=256

" window swap
let g:windowswap_map_keys = 0 " prevent default bindings

" signs
sign define DiagnosticSignError text= linehl= texthl=DiagnosticSignError numhl=
sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl=
sign define DiagnosticSignInfo text= linehl= texthl=DiagnosticSignInfo numhl=
sign define DiagnosticSignHint text= linehl= texthl=DiagnosticSignHint numhl=

" search
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
set <S-F4>=\eO1;2S
let g:FerretExecutableArguments = { 'rg': '--vimgrep --no-heading --max-columns 4096' }

" completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*/tmp/*

" remember last location in files
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif
endif

" Opens an edit command with the path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Control font size
nmap <D-+> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR>
nmap <D--> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR>

" focus lost
au FocusLost * :silent! wall!                " Save on FocusLost
au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost

" run with
let ft_stdout_mappings = {
  \'bash': 'bash',
  \'javascript': 'node',
  \'python': 'python3',
  \'ruby': 'ruby',
  \'sh': 'sh'
\}

for ft_name in keys(ft_stdout_mappings)
  execute 'au Filetype ' . ft_name . ' nnoremap <buffer> <F8> :write !' . ft_stdout_mappings[ft_name] . '<CR>'
endfor

imap <silent> <F8> <Esc><F8>

" airline
let g:airline_powerline_fonts=1
let g:airline_theme='jet'
let g:airline#extensions#tmuxline#snapshot_file = '~/.tmuxline.conf'
let g:airline#extensions#nvimlsp#enabled = 1
let g:airline#extensions#nvimlsp#error_symbol = ' '
let g:airline#extensions#nvimlsp#warning_symbol = ' '
let g:airline_skip_empty_sections=1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#default#section_truncate_width = {'a': 90, 'b': 90, 'x': 90, 'y': 90, 'z': 30, 'warning': 80, 'error': 80 }

" tmuxline
let g:tmuxline_preset = {
  \'a'           : '#S',
  \'cwin'        : ['#I', '#W#F'],
  \'win'         : ['#I', '#W'],
  \'x'           : '#(tmux-spotify-info)#(cut -c3- ~/.tmux.conf | sh -s _testvpn) | #(cut -c3- ~/.tmux.conf | sh -s _prodvpn)',
  \'y'           : '%l:%M',
  \'z'           : '#(cut -c3- ~/.tmux.conf | sh -s _hostname)',
  \'options'     : {'status-justify' : 'left'},
\}

" vimux
let g:VimuxOrientation='h'
let g:VimuxHeight='30'

" csv
let g:csv_no_conceal = 1

" startify
function! s:gitModified()
  let files = systemlist('git ls-files -m 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

function! s:gitUntracked()
  let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
  \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
  \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]
