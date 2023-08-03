local Plug = vim.fn['plug#']

vim.call('plug#begin')

-- file explorer
Plug 'nvim-tree/nvim-web-devicons'
Plug 'MunifTanjim/nui.nvim'
Plug('nvim-neo-tree/neo-tree.nvim', { branch = 'v3.x' })

-- windowing
Plug 'troydm/zoomwintab.vim'
Plug 'fgheng/winbar.nvim'
Plug 't9md/vim-choosewin'
Plug 'anuvyklack/animation.nvim'
Plug 'anuvyklack/middleclass'

-- 🌳
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'nvim-treesitter/nvim-treesitter-context'

-- 🔭
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-telescope/telescope-fzf-native.nvim',
  {
    ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' })
Plug 'xiyaowong/telescope-emoji.nvim'
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'nvim-lua/plenary.nvim'

-- tmux/terminal integrations
Plug 'benmills/vimux'
Plug 'sjl/vitality.vim'

-- completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-path'
Plug 'dmitmel/cmp-cmdline-history'

-- snippets
Plug 'SirVer/ultisnips'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'honza/vim-snippets'

-- colors/theme
Plug 'RRethy/nvim-base16'

-- status line
Plug 'nvim-lualine/lualine.nvim'

-- git
Plug 'lewis6991/gitsigns.nvim'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

-- lsp/diagnostics
Plug 'neovim/nvim-lspconfig'
Plug 'folke/trouble.nvim'
Plug 'onsails/lspkind.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

-- debugging
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

-- copy/paste
Plug 'gbprod/yanky.nvim'

-- random
Plug 'chrisbra/csv.vim'
Plug 'godlygeek/tabular'
Plug 'windwp/nvim-autopairs'
Plug 'DaikyXendo/nvim-material-icon'
-- Plug 'kyazdani42/nvim-web-devicons'
Plug 'kylechui/nvim-surround'
Plug 'mhartington/formatter.nvim'
Plug 'mhinz/vim-startify'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'suy/vim-context-commentstring'
Plug 'ggandor/leap.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'triglav/vim-visual-increment'
Plug 'wakatime/vim-wakatime'
Plug 'lambdalisue/suda.vim'
Plug 'echasnovski/mini.nvim'
Plug 'thinca/vim-qfreplace'
Plug 'smjonas/inc-rename.nvim'
Plug 'roobert/search-replace.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'github/copilot.vim'
Plug 'ThePrimeagen/refactoring.nvim'
Plug 'mbbill/undotree'
Plug 'aaditeynair/conduct.nvim'
Plug 'james1236/backseat.nvim'

vim.call('plug#end')
