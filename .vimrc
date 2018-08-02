" ------- "
" Plugins "
" ------- "
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

":sort /\/[^']*/ri

Plugin 'file:///Users/darrinholst/Projects/vim-vimrc'
"Plugin 'chriskempson/base16-vim'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'mattn/emmet-vim'
Plugin 'wincent/ferret'
Plugin 'othree/html5.vim'
Plugin 'sbdchd/neoformat'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'ternjs/tern_for_vim'
Plugin 'tomtom/tlib_vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'Quramy/tsuquyomi'
Plugin 'leafgarland/typescript-vim'
Plugin 'SirVer/ultisnips'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'gabesoft/vim-ags'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'qpkorr/vim-bufkill'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'mxw/vim-jsx'
Plugin 'tpope/vim-markdown'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'moll/vim-node'
Plugin 'sickill/vim-pasta'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'diepm/vim-rest-console'
Plugin 'tpope/vim-rhubarb'
Plugin 'vim-ruby/vim-ruby'
Plugin 't9md/vim-smalls'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'janko-m/vim-test'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tpope/vim-unimpaired'
Plugin 'triglav/vim-visual-increment'
Plugin 'pedrohdz/vim-yaml-folds'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'Shougo/vimproc.vim'
Plugin 'benmills/vimux'
Plugin 'sjl/vitality.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'regedarek/ZoomWin'

" order dependent
Plugin 'ryanoasis/vim-devicons'

call vundle#end()            " required
filetype plugin indent on    " required

" --------------- "
" Colors and Font "
" --------------- "
color Tomorrow-Night
set guifont=Fura\ Code\ Retina\ Nerd\ Font\ Complete:h17 " http://nerdfonts.com/
set t_Co=256

"if filereadable(expand("~/.vimrc_background"))
  "set t_Co=256
  "let base16colorspace=256
  "source ~/.vimrc_background
"endif

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
set laststatus=2                "always show the status bar
set showcmd                     "show incomplete commands
set showmode                    "show current mode
set autoread                    "reload files changed outside vim
set hidden                      "buffers can exist in the background without being in a window
set ruler                       "show row and column
set cursorline                  "highlight current line
set vb                          "no beeping
set scrolloff=5                 "Start scrolling 3 lines away from margins
set sidescrolloff=10            "Start scrolling 10 columns away from margins
set sidescroll=1
set nrformats=                  "treat all numbers as decimal
set timeoutlen=1000
set ttimeoutlen=100
set mouse=a
set re=1                        "https://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting#16920294
syntax on                       "syntax highlighting
runtime macros/matchit.vim

" ------------ "
" highlighting "
" ------------ "
hi Visual cterm=NONE ctermbg=darkgreen ctermfg=black
hi StatusLine ctermbg=grey ctermfg=black cterm=NONE
hi StatusLineNC ctermbg=grey ctermfg=black cterm=bold
hi VertSplit ctermbg=black ctermfg=grey
hi NonText ctermfg=black
hi Normal ctermbg=NONE
hi MatchParen cterm=NONE ctermbg=darkgreen ctermfg=black
hi Search term=reverse ctermfg=black ctermbg=darkgreen
hi CursorLineNR ctermfg=white
hi clear CursorLine

" ------ "
" search "
" ------ "
set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set ignorecase       "ignore case
set smartcase        "don't ignore case if there's an uppercase character
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
"map <leader>f :Ags<space>
map <leader>f <plug>(FerretAck)
map <leader>F <plug>(FerretAckWord)
nmap <silent> <leader>n :noh<CR>
let g:ags_agcontext = 0
let g:ags_edit_show_line_numbers = 0
let g:ags_winheight = 15
let g:FerretHlsearch=0

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

" ----- "
" ctrlp "
" ----- "
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_custom_ignore = 'bower_components\|node_modules\|DS_Store\|\.git$\|target\|vendor\/bundle\|vendor\/cache'
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_window_reversed = 0
au FocusGained * :ClearCtrlPCache
map <C-e> :<C-U>CtrlPBuffer<CR>
imap <C-e> <ESC>:<C-U>CtrlPBuffer<CR>

" ---------------- "
" dash integration "
" ---------------- "
function! <SID>Dash()
  execute "silent ! /usr/bin/open dash://" . expand("<cword>")
  redraw!
endfunction

command! Dash :call <SID>Dash()
map <leader>d :call <SID>Dash()<CR>

" --------------------- "
" lookup an eslint rule "
" --------------------- "
function! <SID>Eslint()
  execute "normal \"ayi\""
  execute "silent ! /usr/bin/open http://eslint.org/docs/rules/" . @a
  redraw!
endfunction

command! Eslint :call <SID>Eslint()

" ------------------------------ "
" lookup stuff at dictionary.com "
" ------------------------------ "
function! <SID>Dictionary()
  execute "silent ! /usr/bin/open http://dictionary.reference.com/browse/" . expand("<cword>")
  redraw!
endfunction

command! Dictionary :call <SID>Dictionary()
"map <leader>s :call <SID>Dictionary()<CR>

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
nmap <silent> <leader>a :vertical resize 30<CR>
nmap <silent> <leader><space> :wincmd =<CR>

func! ResetVertical()
  vertical resize 30
endfun

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
  " git gutter commands slow down window navigation
  nunmap ,hu
  nunmap ,hp
  "nunmap ,hr
  nunmap ,hs

  " ,cl closes windows for me
  nunmap ,cl
  vunmap ,cl
  noremap <silent> <leader>cl :wincmd l<CR>:close<CR>
endfunction

au VimEnter * call UnmapKeys()

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
au BufNewFile,BufRead Capfile,Gemfile,Rakefile,Guardfile,config.ru,Procfile,Procfile.*,*.csv.csvbuilder setfiletype ruby
au BufNewFile,BufRead *.pdf.erb,*.html.erb let b:eruby_subtype='html'
au BufNewFile,BufRead *.pdf.erb set filetype=eruby
au BufNewFile,BufRead *.eslintrc,*.babelrc,*.stylelintrc,*.nycrc,*.rng set filetype=json
au BufNewFile,BufRead *.jstd set filetype=javascript
au BufNewFile,BufRead *.envrc,*.env,*.env.leave set filetype=sh

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
  execute 'au Filetype ' . ft_name . ' nnoremap <buffer> <F8> :write !' . ft_stdout_mappings[ft_name] . '<CR>'
endfor

imap <silent> <F8> <Esc><F8>

" -------- "
" save all "
" -------- "
imap <F3> <Esc><F3>
nnoremap <F3> :silent! wall!<cr>

" --------- "
" syntastic "
" --------- "
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_typescript_checkers = ['tslint']
let g:syntastic_cucumber_checkers = []
let g:syntastic_less_checkers = []
let g:syntastic_scss_checkers = ['stylelint']
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
au VimEnter * call MapVimSmallsKeys()

function! MapVimSmallsKeys()
  unmap s
  nmap s <Plug>(smalls)
endfunction

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
let g:airline_theme='minimalist'
let g:airline#extensions#tmuxline#snapshot_file = '~/.tmuxline.conf'
let g:airline_skip_empty_sections=1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#default#section_truncate_width = {
      \ 'a': 90,
      \ 'b': 90,
      \ 'x': 90,
      \ 'y': 90,
      \ 'z': 60,
      \ 'warning': 80,
      \ 'error': 80,
      \ }

" -------- "
" tmuxline "
" -------  "
let g:tmuxline_preset = {
      \'a'           : '#S',
      \'win'         : ['#I', '#W'],
      \'cwin'        : ['#I', '#W#F'],
      \'x'           : '#(cut -c3- ~/.tmux.conf | sh -s _battery)',
      \'y'           : '%l:%M',
      \'z'           : '#(cut -c3- ~/.tmux.conf | sh -s _hostname)',
      \'options'     : {'status-justify' : 'left'},
      \'win_options' : {'window-status-activity-attr' : 'none'}}

" -------- "
" dispatch "
" -------- "
nnoremap <F9> :wa \| :Dispatch<CR>

" ----- "
" vimux "
" ----- "
let g:VimuxOrientation='h'
let g:VimuxHeight='30'
map <Leader>vp :wa \| :VimuxPromptCommand<CR>
map <Leader>vl :wa \| :VimuxRunLastCommand<CR>

" --- "
" vrc "
" --- "
let g:vrc_trigger = '<C-r>'
let g:vrc_curl_opts = {
  \ '--connect-timeout' : 10,
  \ '-L': '',
  \ '-i': '',
  \ '--max-time': 10,
  \ '--ipv4': '',
  \ '-k': '',
\}

" --------- "
" vim-pasta "
" --------- "
let g:pasta_disabled_filetypes = ['agsv', 'python', 'coffee', 'markdown', 'yaml', 'slim']

" ----------------- "
" vim-autoformatter "
" ----------------- "
let g:autoformat_verbosemode = 1
imap <silent> <F5> <Esc><F5>
noremap <F5> :Neoformat<CR>

" ------------- "
" vim-yankstack "
" ------------- "
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" ------------- "
" YouCompleteMe "
" ------------- "
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

" --------- "
" UtilSnips "
" --------- "
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

" --------- "
" Neoformat "
" --------- "
let g:neoformat_basic_format_align = 1
let g:neoformat_run_all_formatters = 1
let g:neoformat_only_msg_on_error = 1
let g:neoformat_enabled_json = ['prettier', 'fixjson']
let g:neoformat_enabled_javascript = ['prettier', 'eslint_d']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
let g:neoformat_enabled_ruby = ['rufo']
au BufWritePre *.js,*.ts,*.scss,*.rb Neoformat

" --- "
" JSX "
" --- "
let g:jsx_ext_required = 0

" -------- "
" markdown "
" -------- "
let g:markdown_fenced_languages = ['html', 'vim', 'ruby', 'python', 'bash=sh', 'javascript']
au FileType markdown call SetMarkdownOptions()

function! SetMarkdownOptions()
  setlocal textwidth=120
  setlocal colorcolumn=121
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
" TypeScript "
" ---------- "
au Filetype typescript call SetTypeScriptOptions()

function! SetTypeScriptOptions()
  nmap <buffer> <leader>R :TsuRenameSymbol<CR>
  nmap <buffer> <Leader>t :<C-u>echo tsuquyomi#hint()<CR>
  nmap <buffer> <Leader>ti :TsuImport<CR>
  setlocal colorcolumn=81
endfunction

" ---------- "
" JavaScript "
" ---------- "
au Filetype javascript call SetJavaScriptOptions()

function! SetJavaScriptOptions()
  nnoremap <leader>R :TernRename<CR>
  setlocal colorcolumn=81
  normal zR
endfunction

" ---- "
" JSON "
" ---- "
let g:vim_json_syntax_conceal = 0
au Filetype json call SetJsonOptions()

function! SetJsonOptions()
  setlocal foldmethod=indent
  normal zR
endfunction

au BufNewFile,BufRead call OpenFolds()

function! OpenFolds()
  normal zR
endfunction

" --- "
" Vim "
" --- "
au Filetype vim call SetVimOptions()

function! SetVimOptions()
  normal zR
endfunction

" --- "
" Vim "
" --- "
au Filetype vim call SetVimOptions()

function! SetVimOptions()
  normal zR
endfunction
