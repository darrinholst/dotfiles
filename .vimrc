" ------ "
" NeoVim "
" ------ "
if !1 | finish | endif " Skip initialization for vim-tiny or vim-small.

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'diepm/vim-rest-console'
NeoBundle 'bling/vim-airline'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'ekalinin/Dockerfile.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'ervandew/supertab'
NeoBundle 'gabesoft/vim-ags'
NeoBundle 'godlygeek/tabular'
NeoBundle 'groenewege/vim-less'
NeoBundle 'janko-m/vim-test'
NeoBundle 'juvenn/mustache.vim'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'MarcWeber/vim-addon-local-vimrc'
NeoBundle 'marijnh/tern_for_vim'
NeoBundle 'maxbrunsfeld/vim-yankstack'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle 'nelstrom/vim-textobj-rubyblock'
NeoBundle 'othree/html5.vim'
NeoBundle 'othree/javascript-libraries-syntax.vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'qpkorr/vim-bufkill'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'sickill/vim-pasta'
NeoBundle 'sjl/vitality.vim'
NeoBundle 't9md/vim-smalls'
NeoBundle 'thoughtbot/vim-rspec'
NeoBundle 'tpope/vim-cucumber'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-jdaddy'
NeoBundle 'tpope/vim-markdown'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'vim-scripts/ZoomWin'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'wincent/ferret'
NeoBundle 'yunake/vimux'

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

" -------------- "
" General Config "
" -------------- "
set t_Co=256                    "256 colors please
let base16colorspace=256        " Access colors present in 256 colorspace
set background=dark             "mmmm, dark
color base16-tomorrow           "default color scheme
let mapleader = ","             "override default map leader
set guifont=Meslo\ LG\ M\ for\ Powerline:h17    "sweet ass font
set guioptions-=T               "no toolbar
set guioptions-=r               "no right scrollbar
set guioptions-=L               "no left scrollbar
set encoding=utf-8              "utf-8
set number                      "show line numbers
set backspace=indent,eol,start  "allow backspace in insert mode
set history=1000                "store lots of :cmdline history
set laststatus=2                "always show the status bar
set showcmd                     "show incomplete cmds down the bottom
set showmode                    "show current mode down the bottom
set autoread                    "reload files changed outside vim
set hidden                      "buffers can exist in the background without being in a window
set ruler                       "show row and column
set cursorline                  "highlight current line
set vb                          "no beeping
set scrolloff=3                 "Start scrolling when we're 3 lines away from margins
set sidescrolloff=10            "Start scrolling when we're 10 columns away from margins
set sidescroll=1
set nrformats=                  "treat all numbers as decimal
set timeoutlen=1000
set ttimeoutlen=100
set pastetoggle=,p
syntax on                       "syntax highlighting
runtime macros/matchit.vim

" ------------ "
" highlighting "
" ------------ "
hi Visual cterm=NONE ctermbg=grey ctermfg=black
hi StatusLine ctermbg=grey ctermfg=black cterm=NONE
hi StatusLineNC ctermbg=grey ctermfg=black cterm=bold
hi VertSplit ctermbg=grey ctermfg=grey
hi NonText ctermfg=black
hi Normal ctermbg=NONE
hi MatchParen cterm=NONE ctermbg=grey ctermfg=black

" ------ "
" search "
" ------ "
set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set ignorecase       "ignore case
set smartcase        "don't ignore case if there's an uppercase character
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
map <leader>f :Ag<space>
nmap <silent> <leader>n :noh<CR>

" ---------- "
" whitespace "
" ---------- "
set nowrap                      "no line wrapping by default
set tabstop=2                   "tab == 2 spaces
set shiftwidth=2                "(auto)indent == 2 spaces
set softtabstop=2               "please don't use <Tab>s
set expandtab                   "spaces, not tabs
set list listchars=tab:\ \ ,trail:·
filetype plugin on
filetype indent on

" ---------- "
" completion "
" ---------- "
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*/tmp/*

" ---------- "
" swap files "
" ---------- "
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" ------------------------------- "
" remember last location in files "
" ------------------------------- "
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" -------------------------- "
" proper git commit messages "
" -------------------------- "
au FileType gitcommit set tw=68 spell

" ----- "
" ctrlp "
" ----- "
let g:ctrlp_custom_ignore = 'bower_components\|node_modules\|DS_Store\|\.git$\|build\|target\|vendor\/bundle\|vendor\/cache'
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_window_reversed = 0
au FocusGained * :ClearCtrlPCache
map <C-e> :<C-U>CtrlPBuffer<CR>
imap <C-e> <ESC>:<C-U>CtrlPBuffer<CR>

" ---------------- "
" dash integration "
" ---------------- "
function! SearchDash()
  let s:browser = "/usr/bin/open"
  let s:wordUnderCursor = expand("<cword>")
  let s:url = "dash://".s:wordUnderCursor
  let s:cmd ="silent ! " . s:browser . " " . s:url
  execute s:cmd
  redraw!
endfunction

map <leader>d :call SearchDash()<CR>

" ------------------------------ "
" lookup stuff at dictionary.com "
" ------------------------------ "
function! SearchDictionary()
  let s:browser = "/usr/bin/open"
  let s:wordUnderCursor = expand("<cword>")
  let s:url = "http://dictionary.reference.com/browse/".s:wordUnderCursor
  let s:cmd ="silent ! " . s:browser . " " . s:url
  execute s:cmd
  redraw!
endfunction

map <leader>s :call SearchDictionary()<CR>

" -------------------------- "
" gherkin auto table aligner "
" -------------------------- "
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

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

" ------------------- "
" random key mappings "
" ------------------- "
map <Leader><Leader> :ZoomWin<CR>
nmap <silent> <leader>w :wa<CR>

" Commenter
map <leader>/ <plug>NERDCommenterToggle

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
map <Leader>r :Move <C-R>=expand("%:p") <CR>

nmap <D-+> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR>
nmap <D--> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR>

function! UnmapKeys()
  nunmap ,cl
  vunmap ,cl
  noremap <silent> <leader>cl :wincmd l<CR>:close<CR>
endfunction

autocmd VimEnter * call UnmapKeys()

" --------------------------- "
" directory handling on enter "
" --------------------------- "
function! <SID>CdIfDirectory(directory)
  if isdirectory(a:directory)
    exe "cd " . fnameescape(a:directory)
    bd
  endif
endfunction

augroup vim_enter
  au VimEnter * call <SID>CdIfDirectory(expand("<amatch>"))
augroup END

" ---------- "
" focus lost "
" ---------- "
au FocusLost * :silent! wall!                " Save on FocusLost
au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost

" ---- "
" ruby "
" ---- "
au BufRead,BufNewFile Capfile,Gemfile,Rakefile,Guardfile,config.ru,Procfile,Procfile.*,*.csv.csvbuilder setfiletype ruby
au BufNewFile,BufRead *.pdf.erb,*.html.erb let b:eruby_subtype='html'
au BufNewFile,BufRead *.pdf.erb set filetype=eruby

command! HashRocket :call HashRocket()

function! HashRocket()
  execute ':%s/:\([^ ]*\)\(\s*\)=>/\1:/g'
endfunction

" -------- "
" run with "
" -------- "
let ft_stdout_mappings = {
      \'bash': 'bash',
      \'javascript': 'node',
      \'nodejs': 'node',
      \'python': 'python3',
      \'ruby': 'ruby',
      \'sh': 'sh'
      \}

for ft_name in keys(ft_stdout_mappings)
  execute 'autocmd Filetype ' . ft_name . ' nnoremap <buffer> <F8> :write !' . ft_stdout_mappings[ft_name] . '<CR>'
endfor

imap <silent> <F8> <Esc><F8>

" -------- "
" save all "
" -------- "
imap <silent> <F3> <Esc><F3>
nnoremap <silent> <F3> :wa<cr>

" --------- "
" syntastic "
" --------- "
let g:syntastic_enable_signs=1
"let g:syntastic_quiet_messages = {'level': 'warnings'}
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_cucumber_checkers = []
let g:syntastic_less_checkers = []
let g:syntastic_html_checkers = ['tidy']

let g:syntastic_html_tidy_ignore_errors = [
  \   '> proprietary attribute "',
  \   '> is not recognized!',
  \   'discarding unexpected <',
  \   'trimming empty <'
  \ ]

" ------- "
" testing "
" ------- "
nmap <silent> <leader>t :wa \| TestNearest<CR>
nmap <silent> <leader>T :wa \| TestLast<CR>
let test#strategy = "vimux"

" ---- "
" tidy "
" ---- "
:command! Thtml :%!tidy -q -i --show-errors 0
:command! Txml  :%!tidy -q -i --show-errors 0 -xml

" ---------- "
" unimparied "
" ---------- "
nmap <C-k> <Plug>unimpairedMoveUp
nmap <C-j> <Plug>unimpairedMoveDown
xmap <C-k> <Plug>unimpairedMoveSelectionUp
xmap <C-j> <Plug>unimpairedMoveSelectionDown

" ------ "
" smalls "
" ------ "
function! MapVimSmallsKeys()
  unmap s
  nmap s <Plug>(smalls)
endfunction

autocmd VimEnter * call MapVimSmallsKeys()

" ------------------ "
" cleanup whitespace "
" ------------------ "
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
  au BufWritePre *.scss,*.less,*.css,*.coffee,*.html.*,*.json,*.js,*.rb,*.feature,*.erb :call <SID>StripTrailingWhitespaces()
  au BufWritePre *.scss,*.less,*.css,*.coffee,*.html.*,*.json,*.js,*.rb,*.feature retab!
augroup END

" --- "
" xml "
" --- "
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

map ,xt :call DoPrettyXML()<CR>

" ------- "
" airline "
" ------- "
let g:airline_powerline_fonts=1
let g:airline_theme='base16'

" -------- "
" dispatch "
" -------- "
nnoremap <F9> :wa \| :Dispatch<CR>

" ----- "
" vimux "
" ----- "
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>
" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

" --- "
" vrc "
" --- "
let g:vrc_trigger = '<C-r>'
