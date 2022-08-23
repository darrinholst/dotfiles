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
Plug 'nvim-treesitter/playground'
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
Plug 'folke/trouble.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'jose-elias-alvarez/null-ls.nvim'

" random
Plug 'godlygeek/tabular'
Plug 'kylechui/nvim-surround'
Plug 'mhartington/formatter.nvim'
Plug 'suy/vim-context-commentstring'
Plug 't9md/vim-smalls'
Plug 'triglav/vim-visual-increment'
Plug 'wakatime/vim-wakatime'

call plug#end()

" --------------- "
" Colors and Font "
" --------------- "
if filereadable(expand("~/.vimrc_background"))
  set t_Co=256
  let base16colorspace=256
  source ~/.vimrc_background
endif

" ------------ "
" highlighting "
" ------------ "
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
hi DiagnosticVirtualTextError guifg=#969896
hi DiagnosticVirtualTextInfo guifg=#969896
hi DiagnosticVirtualTextWarn guifg=#969896
hi DiagnosticVirtualTextHint guifg=#969896

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
set viminfo='100,f1  "Save up to 100 marks, enable capital marks
nmap <silent> <leader>n :noh<CR>
map <F4> :cn<CR>
map <S-F4> :cp<CR>
map <C-F4> :cnf<CR>
map <S-C-F4> :cpf<CR>
set <S-F4>=\eO1;2S
map <leader>f <plug>(FerretAck)
map <leader>F <plug>(FerretAckWord)
let g:FerretExecutableArguments = { 'rg': '--vimgrep --no-heading --max-columns 4096' }

" ---------- "
" completion "
" ---------- "
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*/tmp/*

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
nmap <leader><leader>r :source ~/.config/nvim/init.lua<CR>

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
inoremap <silent> <F3> <Esc>:wall!<cr>
nnoremap <silent> <F3> :wall!<cr>

" ---------- "
" unimparied "
" ---------- "
nmap <C-k> <Plug>unimpairedMoveUp
nmap <C-j> <Plug>unimpairedMoveDown
xmap <C-k> <Plug>unimpairedMoveSelectionUpgv
xmap <C-j> <Plug>unimpairedMoveSelectionDowngv

" ------- "
" airline "
" ------- "
let g:airline_powerline_fonts=1
let g:airline_theme='jet'
let g:airline#extensions#tmuxline#snapshot_file = '~/.tmuxline.conf'
let g:airline_skip_empty_sections=1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#default#section_truncate_width = {'a': 90, 'b': 90, 'x': 90, 'y': 90, 'z': 30, 'warning': 80, 'error': 80 }

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


" --- "
" CSV "
" --- "
let g:csv_no_conceal = 1

