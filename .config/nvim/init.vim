let mapleader = '\'

syntax on
filetype plugin indent on

set number
set autowrite
set cursorline
set hidden
set nobackup
set nowritebackup
set updatetime=50
set shortmess+=c
set nohlsearch
set noerrorbells
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set smartcase
set ignorecase
set noswapfile
set undodir=~/.config/nvim/undodir
set undofile
set incsearch
set scrolloff=15
set noshowmode
set completeopt=menuone,noinsert,noselect
set splitright
set splitright
set autowrite
set termguicolors

call plug#begin('~/.config/nvim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'tjdevries/express_line.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'fnune/base16-vim'

Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

call plug#end()

lua require('init')

colorscheme base16-tomorrow-night
highlight Normal ctermfg=7 ctermbg=none guifg=#c5c8c6 guibg=none
highlight LineNr ctermfg=8 ctermbg=none guifg=#969896 guibg=none
highlight SignColumn ctermfg=8 ctermbg=none guifg=#969896 guibg=none
highlight MatchParen ctermbg=240 guibg=#5b5d5b
