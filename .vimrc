" ------- "
" Plugins "
" ------- "
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Chiel92/vim-autoformat'
Plugin 'LeonB/vim-nginx'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'benmills/vimux'
Plugin 'bling/vim-airline'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'diepm/vim-rest-console'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'elzr/vim-json'
Plugin 'fatih/vim-go'
Plugin 'gabesoft/vim-ags'
Plugin 'garbas/vim-snipmate'
Plugin 'git-time-metric/gtm-vim-plugin'
Plugin 'godlygeek/tabular'
Plugin 'groenewege/vim-less'
Plugin 'honza/vim-snippets'
Plugin 'janko-m/vim-test'
Plugin 'kana/vim-textobj-user'
Plugin 'kchmck/vim-coffee-script'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'leafgarland/typescript-vim'
Plugin 'marijnh/tern_for_vim'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'othree/html5.vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'qpkorr/vim-bufkill'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sickill/vim-pasta'
Plugin 'sjl/vitality.vim'
Plugin 't9md/vim-smalls'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'triglav/vim-visual-increment'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-ruby/vim-ruby'
Plugin 'vim-scripts/matchit.zip'
Plugin 'wincent/ferret'

call vundle#end()            " required
filetype plugin indent on    " required

" -------------- "
" General Config "
" -------------- "
set t_Co=256                    "256 colors please
let base16colorspace=256        "Access colors present in 256 colorspace
set background=dark             "dark
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
set mouse=a
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
hi Search term=reverse ctermfg=18 ctermbg=16

" ------ "
" search "
" ------ "
set incsearch        "Find the next match as we type the search
set hlsearch         "Hilight searches by default
set ignorecase       "ignore case
set smartcase        "don't ignore case if there's an uppercase character
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
map <leader>f :Ags<space>
"map <leader>f <plug>(FerretAck)
"map <leader>F <plug>(FerretAckWord)
nmap <silent> <leader>n :noh<CR>
let g:ags_agcontext = 0
let g:ags_edit_show_line_numbers = 0
let g:ags_winheight = 15

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
  nunmap ,hp
  nunmap ,hr
  nunmap ,hs

  " ,cl closes windows for me
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
au BufNewFile,BufRead *.eslintrc set filetype=json

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
let g:syntastic_javascript_checkers = ['eslint']
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
let g:airline_theme='wombat'
let g:airline#extensions#tmuxline#snapshot_file = '~/.tmuxline.conf'
let g:airline_skip_empty_sections=1

" -------- "
" tmuxline "
" -------  "
let g:tmuxline_preset = {
      \'a'           : '#S',
      \'win'         : ['#I', '#W'],
      \'cwin'        : ['#I', '#W#F'],
      \'y'           : ['#(if [[ `pmset -g batt | grep -c "AC Power"` > 0 ]]; then echo "🔌 "; else pmset -g batt | grep -o -e "\\\\\\\\d\\\\\\\\{1,\\\\\\\\}%%"; fi)', '%H:%M'],
      \'z'           : '#h',
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
let g:vrc_debug = 1

" --------- "
" vim-pasta "
" --------- "
let g:pasta_disabled_filetypes = ['agsv', 'python', 'coffee', 'markdown', 'yaml', 'slim']

" ------------ "
" tern_for_vim "
" ------------ "
nnoremap <leader>R :TernRename<CR>

" ----------------- "
" vim-autoformatter "
" ----------------- "
let g:autoformat_verbosemode = 1
imap <silent> <F5> <Esc><F5>
noremap <F5> :Autoformat<CR>

" ------------- "
" vim-yankstack "
" ------------- "
nmap <leader>p <Plug>yankstack_substitute_older_paste

" ------------ "
" vim-snipmate "
" ------------ "
imap <C-L> <esc>a<Plug>snipMateNextOrTrigger
smap <C-L> <Plug>snipMateNextOrTrigger

" -------- "
" markdown "
" -------- "
let g:markdown_fenced_languages = ['html', 'vim', 'ruby', 'python', 'bash=sh', 'javascript']

" --- "
" gtm "
" --- "
let g:gtm_plugin_status_enabled = 1
