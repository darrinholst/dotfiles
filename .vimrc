set nocompatible " be iMproved

" -------- "
" Vim-Plug "
" -------- "
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'benmills/vimux'
Plug 'cakebaker/scss-syntax.vim'
Plug 'danielwe/base16-vim'
Plug 'edkolev/tmuxline.vim'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular'
Plug 'hashivim/vim-terraform'
Plug 'honza/vim-snippets'
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kevinoid/vim-jsonc'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'leafgarland/typescript-vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'moll/vim-node'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'othree/html5.vim'
Plug 'pedrohdz/vim-yaml-folds'
Plug 'qpkorr/vim-bufkill'
Plug 'regedarek/ZoomWin'
Plug 'sbdchd/neoformat'
Plug 'sheerun/vim-polyglot'
Plug 'Shougo/vimproc.vim'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sickill/vim-pasta'
Plug 'SirVer/ultisnips'
Plug 'sjl/vitality.vim'
Plug 't9md/vim-smalls'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'triglav/vim-visual-increment'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wakatime/vim-wakatime'
Plug 'wincent/ferret'

" order dependent
Plug 'ryanoasis/vim-devicons'

call plug#end()

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
set tags^=./.git/tags
syntax on                       "syntax highlighting
runtime macros/matchit.vim

" ------------ "
" highlighting "
" ------------ "
" hi CocCodeLens ctermfg=19
" hi CursorLineNR ctermfg=white
" hi CursorLineNr ctermbg=black ctermfg=yellow cterm=bold
" hi LineNr ctermbg=black cterm=NONE
" hi MatchParen cterm=NONE ctermbg=darkgreen ctermfg=black
" hi NonText ctermfg=black
" hi Normal ctermbg=NONE
" hi Search term=reverse ctermfg=black ctermbg=darkgreen
" hi SignColumn ctermbg=black
" hi StatusLine ctermbg=grey ctermfg=black cterm=NONE
" hi StatusLineNC ctermbg=grey ctermfg=black cterm=bold
" hi VertSplit ctermbg=black ctermfg=darkgreen
" hi Visual cterm=NONE ctermbg=darkgreen ctermfg=black


" *CocFadeOut* for faded out text, such as for highlighting unnecessary code.
" *CocErrorSign* for error signs.
" *CocWarningSign* for warning signs.
" *CocInfoSign* for information signs.
" *CocHintSign* for hint signs.
" *CocErrorVirtualText* for error virtual text.
" *CocWarningVirtualText* for warning virtual text.
" *CocInfoVirtualText* for information virtual text.
" *CocHintVirtualText* for hint virtual text.
" *CocErrorHighlight* for error code range.
" *CocWarningHighlight* for warning code range.
" *CocInfoHighlight* for information code range.
" *CocHintHighlight* for hint code range.
" *CocDeprecatedHighlight* for deprecated code range, links to
" |CocStrikeThrough| by default.
" *CocUnusedHighlight* for unnecessary code range, links to |CocFadeOut| by default.
" *CocErrorLine* line highlight of sign which contains error.
" *CocWarningLine* line highlight of sign which contains warning.
" *CocInfoLine* line highlight of sign which information.
" *CocHintLine* line highlight of sign which contains hint.

set termguicolors
hi CocGitRemovedSign guibg=19 guifg=#bf6b68
hi CocGitAddedSign guibg=19 guifg=#b7bc72
hi CocGitChangedSign guibg=19 guifg=#e9c780
hi CocCodeLens guifg=#444444
" hi CursorLineNR guibg=18 guifg=white
" hi CursorLineNr guibg=18 guifg=#b7bc72 gui=bold
" hi LineNr guibg=19 gui=NONE
hi MatchParen gui=bold guibg=#b7bc72 guifg=black
hi Normal guibg=NONE
" hi Search term=reverse guifg=black guibg=#b7bc72
hi SignColumn guibg=18
hi StatusLine guibg=grey guifg=19 gui=NONE
hi StatusLineNC guibg=grey guifg=19 gui=bold
hi VertSplit guibg=19 guifg=#b7bc72
hi Visual gui=NONE guibg=#b7bc72 guifg=black
hi EndOfBuffer guifg=#1d1f21

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

" ------ "
" search "
" ------ "
nnoremap <leader>t :Telescope
nnoremap <leader>g <cmd>Telescope live_grep<cr>
map <leader>f <plug>(FerretAck)
map <leader>F <plug>(FerretAckWord)
let g:FerretExecutableArguments = {
  \   'rg': '--vimgrep --no-heading --max-columns 4096'
  \ }

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

" ------------ "
" fuzzy finder "
" ------------ "
nnoremap <C-f> :Files<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <C-e> :Buffers<CR>
nnoremap <C-h> :History<CR>
let g:fzf_layout = { 'up': '~40%' }
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']

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
" duckduckgo            "
" --------------------- "
function! <SID>Ddg()
  execute "!/usr/bin/open https://duckduckgo.com/\\?q\\=" . expand("<cword>")
  redraw!
endfunction

command! Ddg :call <SID>Ddg()
map <leader>ddg :call <SID>Ddg()<CR>

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
vnoremap <M-c> "+y
map <Leader><Leader> :ZoomWin<CR>
nmap <silent> <leader>w :wa<CR>
nmap <silent> <leader>a :vertical resize 30<CR>
nmap <silent> <leader><space> :wincmd =<CR>

func! ResetVertical()
  vertical resize 30
endfun

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

let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_ignore = [ '.git' ]
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }
map <F6> :NvimTreeFindFile<CR>
imap <F6> <Esc>:NvimTreeFindFile<CR>
map <F7> :NvimTreeToggle<CR>
imap <F7> <Esc>:NvimTreeToggle<CR>

" Opens an edit command with the path of the currently edited file filled in
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

nmap <D-+> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) - 1)', '')<CR>
nmap <D--> :let &guifont = substitute(&guifont, ':h\(\d\+\)', '\=":h" . (submatch(1) + 1)', '')<CR>

function! UnmapKeys()
  " ,cl closes windows for me
  nunmap ,cl
  vunmap ,cl
  noremap <silent> <leader>cl :wincmd l<CR>:close<CR>
endfunction

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
  au VimEnter * call UnmapKeys()
augroup END

" ---------- "
" focus lost "
" ---------- "
au FocusLost * :silent! wall!                " Save on FocusLost
au FocusLost * call feedkeys("\<C-\>\<C-n>") " Return to normal mode on FocustLost

" ------------- "
" file mappings "
" ------------- "
au BufNewFile,BufRead Gemfile,Rakefile,Guardfile,config.ru,Procfile,Procfile.*,*.csv.csvbuilder setfiletype ruby
au BufNewFile,BufRead *.pdf.erb,*.html.erb let b:eruby_subtype='html'
au BufNewFile,BufRead *.pdf.erb set filetype=eruby
au BufNewFile,BufRead *.eslintrc,*.babelrc,*.stylelintrc,*.nycrc,*.rng set filetype=json
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

" ---------- "
" unimparied "
" ---------- "
nmap <C-k> <Plug>unimpairedMoveUp
nmap <C-j> <Plug>unimpairedMoveDown
xmap <C-k> <Plug>unimpairedMoveSelectionUp
xmap <C-j> <Plug>unimpairedMoveSelectionDown

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
let g:airline_theme='base16_tomorrow_night'
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

" ----------------- "
" vim-autoformatter "
" ----------------- "
let g:autoformat_verbosemode = 1
imap <silent> <F5> <Esc><F5>
noremap <F5> :Neoformat<CR>


" --- "
" coc "
" --- "
autocmd FileType json syntax match Comment +\/\/.\+$+

let g:coc_disable_transparent_cursor=1
let g:coc_global_extensions = [
      \ "coc-css",
      \ "coc-git",
      \ "coc-eslint",
      \ "coc-html",
      \ "coc-json",
      \ "coc-snippets",
      \ "coc-tsserver",
      \ "coc-ultisnips",
      \ "coc-yank",
      \ "coc-emoji",
      \ "coc-diagnostic",
      \ "coc-spell-checker",
      \]

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
        \ },
        \ 'component_function': {
          \   'cocstatus': 'coc#status'
          \ },
          \ }

" Using CocList
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr> " Show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr> " Manage extensions
nnoremap <silent> <space>c  :<C-u>CocList commands<cr> " Show commands
nnoremap <silent> <space>o  :<C-u>CocList outline<cr> " Find symbol of current document
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr> " Search workspace symbols
nnoremap <silent> <space>j  :<C-u>CocNext<CR> " Do default action for next item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR> " Do default action for previous item.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR> " Resume latest coc list
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

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
let g:neoformat_enabled_json = ['jq', 'prettier', 'fixjson']
let g:neoformat_enabled_javascript = ['prettier', 'eslint_d']
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_enabled_scss = ['prettier']
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

" ---- "
" yaml "
" ---- "
au Filetype yaml call SetYamlOptions()

function! SetYamlOptions()
  normal zR
endfunction

" ---------- "
" TypeScript "
" ---------- "
au Filetype typescript call SetTypeScriptOptions()

function! SetTypeScriptOptions()
  setlocal foldmethod=indent
  setlocal colorcolumn=81
  normal zR
endfunction

" ---------- "
" JavaScript "
" ---------- "
au Filetype javascript call SetJavaScriptOptions()

function! SetJavaScriptOptions()
  setlocal foldmethod=indent
  setlocal colorcolumn=81
  normal zR
endfunction

" --- "
" CSV "
" --- "
let g:csv_no_conceal = 1

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

" ------- "
" resizer "
" ------- "
nnoremap <silent> <M-Down> :call DownHorizontal()<CR>
nnoremap <silent> <M-Up> :call UpHorizontal()<CR>
nnoremap <silent> <M-Right> :call RightVertical()<CR>
nnoremap <silent> <M-Left> :call LeftVertical()<CR>

func! DownHorizontal()
  let currentWin = winnr()
  "If no window below or above leave as is, otherwise call function
  wincmd j
  if winnr() == currentWin
    wincmd k
    if winnr() == currentWin
      wincmd k
    else
      exe currentWin . "wincmd w"
      call DownHorizontalAdjust()
    endif
  else
    exe currentWin . "wincmd w"
    call DownHorizontalAdjust()
  endif
endfun

func! DownHorizontalAdjust()
  let currentWin = winnr()
  "If very bottom window, decrease window size, otherwise just increase current window size
  wincmd j
  if winnr() == currentWin
    resize -3
  else
    exe currentWin . "wincmd w"
    resize +3
  endif
endfun

func! UpHorizontal ()
  let currentWin = winnr()
  "If no window below or above leave as is
  wincmd j
  if winnr() == currentWin
    wincmd k
    if winnr() == currentWin
      wincmd k
    else
      exe currentWin . "wincmd w"
      call UpHorizontalAdjust()
    endif
  else
    exe currentWin . "wincmd w"
    call UpHorizontalAdjust()
  endif
endfun

func! UpHorizontalAdjust()
  let currentWin = winnr()
  "If very top window, decrease window size, otherwise just increase current window size
  wincmd k
  if winnr() == currentWin
    resize -3
  else
    resize -3
    exe currentWin . "wincmd w"
  endif
endfun

func! RightVertical()
  let currentWin = winnr()
  " If very right window, decrease window size, otherwise just increase current window size
  wincmd l
  if winnr() == currentWin
    vertical resize -3
  else
    exe currentWin . "wincmd w"
    vertical resize +3
  endif
endfun

func! LeftVertical()
  let currentWin = winnr()
  " If very left window, decrease window size, otherwise just increase current window size
  wincmd h
  if winnr() == currentWin
    vertical resize -3
  else
    vertical resize -3
    exe currentWin . "wincmd w"
  endif
endfun

