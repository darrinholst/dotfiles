local Plug = vim.fn["plug#"]

vim.call("plug#begin")

-- file explorer
Plug "kyazdani42/nvim-tree.lua"
Plug "kyazdani42/nvim-web-devicons"

-- windowing
Plug "troydm/zoomwintab.vim"
Plug "fgheng/winbar.nvim"
Plug "t9md/vim-choosewin"

-- 🌳
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })
Plug "nvim-treesitter/playground"
Plug "nvim-treesitter/nvim-treesitter-textobjects"

-- 🔭
Plug "nvim-telescope/telescope.nvim"
Plug("nvim-telescope/telescope-fzf-native.nvim",
  { ["do"] = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build" })
Plug "xiyaowong/telescope-emoji.nvim"
Plug "nvim-telescope/telescope-live-grep-args.nvim"
Plug "nvim-lua/plenary.nvim"

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

-- git
Plug "lewis6991/gitsigns.nvim"
Plug "shumphrey/fugitive-gitlab.vim"
Plug "tpope/vim-fugitive"
Plug "tpope/vim-rhubarb"

-- search
Plug "wincent/ferret"

-- lsp/diagnostics
Plug "neovim/nvim-lspconfig"
Plug "folke/trouble.nvim"
Plug "onsails/lspkind.nvim"
Plug "jose-elias-alvarez/null-ls.nvim"
Plug "williamboman/mason.nvim"
Plug "williamboman/mason-lspconfig.nvim"

-- debugging
Plug "mfussenegger/nvim-dap"
Plug "rcarriga/nvim-dap-ui"

-- random
Plug "chrisbra/csv.vim"
Plug "godlygeek/tabular"
Plug "jiangmiao/auto-pairs"
Plug "kylechui/nvim-surround"
Plug "mhartington/formatter.nvim"
Plug "mhinz/vim-startify"
Plug "suy/vim-context-commentstring"
Plug "t9md/vim-smalls"
Plug "tpope/vim-commentary"
Plug "tpope/vim-eunuch"
Plug "tpope/vim-repeat"
Plug "tpope/vim-unimpaired"
Plug "triglav/vim-visual-increment"
Plug "wakatime/vim-wakatime"

vim.call("plug#end")
