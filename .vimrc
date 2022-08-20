set nocompatible " be iMproved

" -------- "
" Vim-Plug "
" -------- "
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" nvim
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fgheng/winbar.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

" fuzzy finder
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

" tmux integrations
Plug 'benmills/vimux'
Plug 'edkolev/tmuxline.vim'
Plug 'sjl/vitality.vim'

" completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'

" snippets
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'honza/vim-snippets'

" colors/theme
Plug 'chriskempson/base16-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

" search
Plug 'wincent/ferret'

" git
Plug 'tanvirtin/vgit.nvim',

" lsp/diagnostics
Plug 'dense-analysis/ale'
Plug 'folke/trouble.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'williamboman/nvim-lsp-installer'

" random
Plug 'godlygeek/tabular'
Plug 'kylechui/nvim-surround'
Plug 'mhartington/formatter.nvim'
Plug 'sickill/vim-pasta'
Plug 'suy/vim-context-commentstring'
Plug 't9md/vim-smalls'
Plug 'triglav/vim-visual-increment'
Plug 'wakatime/vim-wakatime'

call plug#end()

" ----- "
" Folds "
" ----- "
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
autocmd BufReadPost,FileReadPost * normal zR

" --------------- "
" Colors and Font "
" --------------- "
set guifont=Fura\ Code\ Retina\ Nerd\ Font\ Complete:h17 " http://nerdfonts.com/

if filereadable(expand("~/.vimrc_background"))
  set t_Co=256
  let base16colorspace=256
  source ~/.vimrc_background
endif

" -------------- "
" General Config "
" -------------- "
let mapleader = ","             "override default map leader
set guioptions-=T               "no toolbar
set guioptions-=r               "no right scrollbar
set guioptions-=L               "no left scrollbar
set encoding=utf-8              "utf-8
set number                      "show line numbers
set backspace=indent,eol,start  "allow backspace in insert mode
set history=1000                "store lots of :cmdline history
set laststatus=3                "show the nvim global status line
set showcmd                     "show incomplete commands
set showmode                    "show current mode
set autoread                    "reload files changed outside vim
set hidden                      "buffers can exist in the background without being in a window
set ruler                       "show row and column
set cursorline                  "highlight current line
set vb                          "no beeping
set scrolloff=5                 "Start scrolling 3 lines away from margins
set sidescroll=1
set sidescrolloff=10            "Start scrolling 10 columns away from margins
set signcolumn=yes
set nrformats=                  "treat all numbers as decimal
set timeoutlen=1000
set ttimeoutlen=100
set mouse=a
set re=1                        "https://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting#16920294
set updatetime=300              " Smaller updatetime for CursorHold & CursorHoldI
syntax on                       "syntax highlighting
runtime macros/matchit.vim
let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
let g:node_host_prog = '~/.nodenv/shims/node'

" ------------ "
" highlighting "
" ------------ "
set termguicolors
hi CursorLineNR guibg=18 guifg=white
hi TelescopeSelection guibg=#555555
hi CursorLineNr guibg=18 guifg=#b7bc72 gui=bold
hi LineNr guibg=19 gui=NONE
hi MatchParen gui=bold guibg=#b7bc72 guifg=black
hi Normal guibg=NONE
hi SignColumn guibg=18
hi StatusLine guibg=grey guifg=19 gui=NONE
hi StatusLineNC guibg=grey guifg=19 gui=bold
hi VertSplit guibg=19 guifg=#b7bc72
hi Visual gui=NONE guibg=#b7bc72 guifg=black
hi EndOfBuffer guifg=#1d1f21

" ----- "
" signs "
" ----- "
sign define DiagnosticSignError text= linehl= texthl=DiagnosticSignError numhl=
sign define DiagnosticSignWarn text= linehl= texthl=DiagnosticSignWarn numhl=
sign define DiagnosticSignInfo text= linehl= texthl=DiagnosticSignInfo numhl=
sign define DiagnosticSignHint text= linehl= texthl=DiagnosticSignHint numhl=

" ------ "
" search "
" ------ "
set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set ignorecase       "ignore case
set smartcase        "don't ignore case if there's an uppercase character
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
nmap <silent> <leader>n :noh<CR>
map <F4> :cn<CR>
map <S-F4> :cp<CR>
map <C-F4> :cnf<CR>
map <S-C-F4> :cpf<CR>
set <S-F4>=\eO1;2S
map <leader>f <plug>(FerretAck)
map <leader>F <plug>(FerretAckWord)
let g:FerretExecutableArguments = {
\  'rg': '--vimgrep --no-heading --max-columns 4096'
\}

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

" ------ "
" smalls "
" ------ "
nmap s <Plug>(smalls)

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
vnoremap <M-c> "+y
nmap <silent> <leader><space> :wincmd =<CR>
nmap <leader><leader>r :source ~/.config/nvim/init.vim<CR>

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
" Opens an edit command with the path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nmap <D-+> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR>
nmap <D--> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR>

" wrapped lines support
nnoremap j gj
nnoremap k gk

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

" ------------- "
" file mappings "
" ------------- "
au BufNewFile,BufRead *.eslintrc,*.babelrc,*.stylelintrc,*.nycrc set filetype=json
au BufNewFile,BufRead *.envrc,*.env,*.env.leave set filetype=sh

" --- "
" ale "
" --- "
let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\}
let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\}
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_fix_on_save = 1
hi ALEErrorSign guibg=18 guifg=red

" -------- "
" run with "
" -------- "
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

" -------- "
" save all "
" -------- "
imap <F3> <Esc><F3>
nnoremap <F3> :silent! wall!<cr>

" ---------- "
" unimparied "
" ---------- "
nmap <C-k> <Plug>unimpairedMoveUp
nmap <C-j> <Plug>unimpairedMoveDown
xmap <C-k> <Plug>unimpairedMoveSelectionUpgv
xmap <C-j> <Plug>unimpairedMoveSelectionDowngv

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
  au BufWritePre *.scss,*.less,*.css,*.coffee,*.html.*,*.ts,*.js,*.json,*.rb,*.feature,*.erb :call <SID>StripTrailingWhitespaces()
  au BufWritePre *.scss,*.less,*.css,*.coffee,*.html.*,*.ts,*.js,*.json,*.rb,*.feature retab!
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
let g:airline_theme='jet'
let g:airline#extensions#tmuxline#snapshot_file = '~/.tmuxline.conf'
let g:airline_skip_empty_sections=1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#default#section_truncate_width = {
  \'a': 90,
  \'b': 90,
  \'x': 90,
  \'y': 90,
  \'z': 30,
  \'warning': 80,
  \'error': 80,
\}

" -------- "
" tmuxline "
" -------  "
let g:tmuxline_preset = {
  \'a'           : '#S',
  \'cwin'        : ['#I', '#W#F'],
  \'win'         : ['#I', '#W'],
  \'x'           : '#(cut -c3- ~/.tmux.conf | sh -s _testvpn) | #(cut -c3- ~/.tmux.conf | sh -s _prodvpn)',
  \'y'           : '%l:%M',
  \'z'           : '#(cut -c3- ~/.tmux.conf | sh -s _hostname)',
  \'options'     : {'status-justify' : 'left'},
\}

" ----- "
" vimux "
" ----- "
let g:VimuxOrientation='h'
let g:VimuxHeight='30'
map <Leader>vp :wa \| :VimuxPromptCommand<CR>
map <Leader>vl :wa \| :VimuxRunLastCommand<CR>

" --------- "
" vim-pasta "
" --------- "
let g:pasta_disabled_filetypes = ["python", "coffee", "markdown", "yaml", "slim", "nerdtree", "netrw", "startify", "ctrlp", "agsv"]

" --- "
" JSX "
" --- "
let g:jsx_ext_required = 0

" -------- "
" markdown "
" -------- "
let g:markdown_fenced_languages = ['html', 'vim', 'ruby', 'python', 'bash=sh', 'javascript']
au FileType markdown call SetMarkdownOptions()
au FileType pandoc call SetMarkdownOptions()

function! SetMarkdownOptions()
  setlocal ft=markdown
  setlocal textwidth=80
  setlocal colorcolumn=81
  setlocal spell
endfunction

" ---------- "
" Git Commit "
" ---------- "
au FileType gitcommit call SetGitCommitOptions()

function! SetGitCommitOptions()
  setlocal textwidth=72
  setlocal colorcolumn=73
  setlocal spell
endfunction

" ---------- "
" JavaScript "
" ---------- "
au Filetype typescript,javascript call SetJavaScriptOptions()

function! SetJavaScriptOptions()
  setlocal colorcolumn=81
endfunction

" --- "
" CSV "
" --- "
let g:csv_no_conceal = 1

