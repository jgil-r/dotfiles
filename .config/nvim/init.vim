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

Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'css', 'less', 'scss', 'json', 'markdown', 'html'] }

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
highlight LineNr ctermfg=8 ctermbg=none guifg=#969896 guibg=none
highlight SignColumn ctermfg=8 ctermbg=none guifg=#969896 guibg=none
highlight MatchParen ctermbg=240 guibg=#5b5d5b

highlight LspDiagnosticsUnderlineError cterm=none gui=none guisp=Red
highlight LspDiagnosticsUnderlineHint cterm=none gui=none guisp=LightGrey
highlight LspDiagnosticsUnderlineInformation cterm=none gui=none guisp=LightBlue
highlight LspDiagnosticsUnderlineWarning cterm=none gui=none guisp=Orange

" Prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
