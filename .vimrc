" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" =============== Pathogen Initialization ===============
" This loads all the plugins in ~/.vim/bundle
" Use tpope's pathogen plugin to manage all other plugins
call pathogen#infect()


" ================ General Config ====================
color base16-tomorrow           "default color scheme
set background=dark
let mapleader = ","             "override default map leader
set guifont=Meslo\ LG\ M:h17    "sweet ass font
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
syntax on                       "syntax highlighting
runtime macros/matchit.vim


" ================ Highlighting ==================
hi Visual cterm=NONE ctermbg=grey ctermfg=black
hi StatusLine ctermbg=grey ctermfg=black cterm=NONE
hi StatusLineNC ctermbg=grey ctermfg=black cterm=bold
hi VertSplit ctermbg=grey ctermfg=grey
hi NonText ctermfg=black


" ================ Search Settings ==================
set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set ignorecase       "ignore case
set smartcase        "don't ignore case if there's an uppercase character
set viminfo='100,f1  "Save up to 100 marks, enable capital marks


" ============== Whitespace Settings ================
set nowrap                      "no line wrapping by default
set tabstop=2                   "tab == 2 spaces
set shiftwidth=2                "(auto)indent == 2 spaces
set softtabstop=2               "please don't use <Tab>s
set expandtab                   "spaces, not tabs
set list listchars=tab:\ \ ,trail:·
filetype plugin on
filetype indent on


" ================ Completion =======================
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*/tmp/*


" =================== Swap Files=====================
set backupdir=~/.vim/backup
set directory=~/.vim/backup


" ========== Remember last location in file =========
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

