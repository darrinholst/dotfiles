local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug "neovim/nvim-lspconfig"
Plug "nvim-lua/plenary.nvim"
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug "nvim-treesitter/playground"
Plug "fgheng/winbar.nvim"
Plug "kyazdani42/nvim-tree.lua"
Plug "kyazdani42/nvim-web-devicons"
Plug "mhinz/vim-startify"
Plug "lewis6991/gitsigns.nvim"
Plug "wesQ3/vim-windowswap"

-- fuzzy finder
Plug "nvim-telescope/telescope.nvim"
Plug("nvim-telescope/telescope-fzf-native.nvim",
  { ["do"] = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" })
Plug "xiyaowong/telescope-emoji.nvim"

-- tmux/terminal integrations
Plug "benmills/vimux"
Plug "edkolev/tmuxline.vim"
Plug "sjl/vitality.vim"
Plug "numToStr/FTerm.nvim"

-- completion
Plug "hrsh7th/nvim-cmp"
Plug "hrsh7th/cmp-buffer"
Plug "hrsh7th/cmp-cmdline"
Plug "hrsh7th/cmp-nvim-lsp"
Plug "hrsh7th/cmp-nvim-lua"
Plug "hrsh7th/cmp-path"

-- snippets
Plug "SirVer/ultisnips"
Plug "quangnguyen30192/cmp-nvim-ultisnips"
Plug "honza/vim-snippets"

-- colors/theme
Plug "chriskempson/base16-vim"
Plug "vim-airline/vim-airline"
Plug "vim-airline/vim-airline-themes"

-- tpope
Plug "tpope/vim-commentary"
Plug "tpope/vim-eunuch"
Plug "tpope/vim-repeat"
Plug "tpope/vim-unimpaired"
Plug "tpope/vim-fugitive"
Plug "shumphrey/fugitive-gitlab.vim"
Plug "tpope/vim-rhubarb"

-- search
Plug "wincent/ferret"

-- lsp/diagnostics
Plug "folke/trouble.nvim"
Plug "onsails/lspkind.nvim"
Plug "jose-elias-alvarez/null-ls.nvim"
Plug "williamboman/mason.nvim"
Plug "williamboman/mason-lspconfig.nvim"

-- random
Plug "godlygeek/tabular"
Plug "kylechui/nvim-surround"
Plug "mhartington/formatter.nvim"
Plug "suy/vim-context-commentstring"
Plug "t9md/vim-smalls"
Plug "triglav/vim-visual-increment"
Plug "wakatime/vim-wakatime"
Plug "chrisbra/csv.vim"

vim.call("plug#end")
