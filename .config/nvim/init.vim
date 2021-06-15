let mapleader = '\'

syntax enable
filetype plugin indent on

set wildignore+=**/node_modules/*
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
set completeopt=menuone,noselect
set splitright
set splitright
set autowrite
set termguicolors
set signcolumn=yes

call plug#begin('~/.config/nvim/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'tjdevries/express_line.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'css', 'less', 'scss', 'json', 'markdown', 'html'] }
Plug 'cohama/lexima.vim'

Plug 'fnune/base16-vim'
Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'

call plug#end()

lua require('init')

colorscheme base16-tomorrow-night
highlight MatchParen ctermbg=240 guibg=#5b5d5b

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" vim-prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" autostart nvim-lsp on new buffers
nnoremap <leader>ast <cmd>lua require('lspconfig').tsserver.autostart()<cr>
nnoremap <leader>asg <cmd>lua require('lspconfig').gopls.autostart()<cr>

" Go
let g:go_list_type = "quickfix"

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
