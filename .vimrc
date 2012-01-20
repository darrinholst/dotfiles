call pathogen#infect()
set guifont=Meslo\ LG\ M:h15

let mapleader = ","
set nocompatible

set number
set ruler
syntax on

" Highlight current line
set cursorline

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·
nmap <leader>w :set list!<CR>

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*/tmp/*

" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\.git$\|tmp$',
"   \ 'file': '\.exe$\|\.so$\|\.dll$',
"   \ 'link': 'bad_symbolic_link',
"   \ }

" Status bar
set laststatus=2

" Without setting this, ZoomWin restores windows in a way that causes
" equalalways behavior to be triggered the next time CommandT is used.
" This is likely a bludgeon to solve some other issue, but it works
set noequalalways

" Command-T configuration
let g:CommandTMaxHeight=20

" ZoomWin configuration
map <Leader><Leader> :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile Capfile,Gemfile,Rakefile,Guardfile,config.ru setfiletype ruby

au BufNewFile,BufRead *.html,*.erb let g:html_indent_tags = g:html_indent_tags.'\|p\|li'
au BufNewFile,BufRead *.pdf.erb,*.html.erb let b:eruby_subtype='html'
au BufNewFile,BufRead *.pdf.erb set filetype=eruby

" add json syntax highlighting
au BufNewFile,BufRead *.json setfiletype ruby

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a rename command with the path of the currently edited file filled in
unmap <leader>rt
map <Leader>r :Rename <C-R>=expand("%:p") <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
nmap <C-k> [e
nmap <C-j> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
vmap <C-k> [egv
vmap <C-j> ]egv

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color ir_black

" Directories for swp files
set backupdir=~/.vim/backup//
set directory=~/.vim/backup//

" Show (partial) command in the status line
set showcmd

" get the eff out of insert mode on foucs lost
:au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

" auto save files
:au FocusLost * :call SaveAll()

function! SaveAll()
  try
    wa
  catch
    " ignore
  endtry
endfunction

" set visual bell -- i hate that damned beeping
set vb

" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
set hidden

" toggle search highligthing
nmap <silent> <leader>n :set invhls<CR>:set hls?<CR>

" buffer explorer
" noremap <silent> <leader>bb :BufExplorer<CR>

" Ctrl Tab to switch to last buffer used
" map <C-Tab> :bu #<cr>

let g:LustyJugglerSuppressRubyWarning = 1
let g:LustyJugglerAltTabMode = 1
noremap <silent> <C-Tab> :LustyJuggler<CR>

" auto align |'s
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" ruby runner
vmap <silent> <F8> :call Ruby_eval()<CR>
nmap <silent> <F8> mzggVG<F8>`z
imap <silent> <F8> <Esc><F8>a
map <silent> <S-F8> <C-W>l:bw<CR>
imap <silent> <S-F8> <Esc><S-F8>a

function! Ruby_eval() range
  let src = tempname()
  let dst = tempname()
  execute ": " . a:firstline . "," . a:lastline . "w " . src
  execute ":silent ! $HOME/.rvm/bin/ruby " . src . " > " . dst . " 2>&1 "
  execute ":!mvim " . dst
endfunction

" json and xml code formatters
map ,jt <Esc>:%!jsonpp<CR>
map ,xt :call DoPrettyXML()<CR>

function! DoPrettyXML()
  let l:origft = &ft
  set ft=
  1s/<?xml .*?>//e
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  2d
  $d
  silent %<
  1
  exe "set ft=" . l:origft
endfunction

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

" strip trailing whitespace
command! StripTrailingWhitespaces :call <SID>StripTrailingWhitespaces()

function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

augroup cleanup_files
  au!
  au BufWritePre *.css,*.coffee,*.html.*,*.json,*.js,*.rb,*.feature,*.erb :call <SID>StripTrailingWhitespaces()
  au BufWritePre *.css,*.coffee,*.html.*,*.json,*.js,*.rb,*.feature retab!
augroup END

" If the parameter is a directory, cd into it and delete the netrw buffer
function <SID>CdIfDirectory(directory)
  if isdirectory(a:directory)
    exe "cd " . fnameescape(a:directory)
    bd
  endif
endfunction

augroup vim_enter
  au VimEnter * call <SID>CdIfDirectory(expand("<amatch>"))
augroup END
