set lines=40 columns=150

set guifont=Meslo\ LG\ S\ DZ:h14
colorscheme ir_black
let mapleader = ","

"-----------------------------------------------------------------------------
" get the eff out of insert mode on foucs lost
"-----------------------------------------------------------------------------
:au FocusLost,TabLeave * call feedkeys("\<C-\>\<C-n>")

"-----------------------------------------------------------------------------
" auto save files
"-----------------------------------------------------------------------------
:au FocusLost * :call SaveAll()

function! SaveAll()
  try
    wa
  catch
    " ignore
  endtry
endfunction

"-----------------------------------------------------------------------------
" set visual bell -- i hate that damned beeping
"-----------------------------------------------------------------------------
set vb

"-----------------------------------------------------------------------------
" Make sure that unsaved buffers that are to be put in the background are
" allowed to go in there (ie. the "must save first" error doesn't come up)
"-----------------------------------------------------------------------------
set hidden

"-----------------------------------------------------------------------------
" random key bindings
"-----------------------------------------------------------------------------

nmap <silent> ,n :set invhls<CR>:set hls?<CR>
map <C-Tab> :bu #<cr>

"-----------------------------------------------------------------------------
" Window Commands
"-----------------------------------------------------------------------------
noremap <silent> ,h :wincmd h<CR>
noremap <silent> ,j :wincmd j<CR>
noremap <silent> ,k :wincmd k<CR>
noremap <silent> ,l :wincmd l<CR>
noremap <silent> ,cj :wincmd j<CR>:close<CR>
noremap <silent> ,ck :wincmd k<CR>:close<CR>
noremap <silent> ,ch :wincmd h<CR>:close<CR>
noremap <silent> ,cl :wincmd l<CR>:close<CR>
noremap <silent> ,cc :close<CR>
noremap <silent> ,cw :cclose<CR>

"-----------------------------------------------------------------------------
" some commands
"-----------------------------------------------------------------------------
command! StripTrailingWhitespaces :call <SID>StripTrailingWhitespaces()

function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

"-----------------------------------------------------------------------------
" Auto commands
"-----------------------------------------------------------------------------
augroup cleanup_files
  au!
  au BufWritePre *.css,*.html,*.json,*.js,*.rb,*.feature :call <SID>StripTrailingWhitespaces()
  au BufWritePre *.css,*.html,*.json,*.js,*.rb,*.feature retab!
augroup END

au BufRead,BufNewFile *.json set filetype=json
au BufRead,BufNewFile *.txt setfiletype markdown

"-----------------------------------------------------------------------------
" NERDTree
"-----------------------------------------------------------------------------
nmap <F7> :NERDTreeToggle<CR>


"-----------------------------------------------------------------------------
" Stuff I stole from janus
"-----------------------------------------------------------------------------
set nocompatible

set number
set ruler
syntax on

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" Show (partial) command in the status line
set showcmd

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on


"-----------------------------------------------------------------------------
" Stuff I stole from janus gvimrc
"-----------------------------------------------------------------------------

" Start without the toolbar
set guioptions-=T
set guioptions+=b

" Command-/ to toggle comments
map <C-/> <plug>NERDCommenterToggle<CR>
imap <C-/> <Esc><plug>NERDCommenterToggle<CR>i


" Command-t to 
" see http://rfbrazier.posterous.com/installing-the-command-t-vim-plugin-on-window
map <C-t> :CommandT<CR>
imap <C-t> <Esc>:CommandT<CR>i

" Project Tree
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction


" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

