" sleek_cyber vim config
colorscheme sleek_cyber
set termguicolors
set number relativenumber
set cursorline
set tabstop=4 shiftwidth=4 expandtab
set smartindent
set wrap linebreak
set scrolloff=5
set ignorecase smartcase
set incsearch hlsearch
set laststatus=2
set showmatch
set splitbelow splitright
set mouse=a
set clipboard=unnamedplus
set encoding=utf-8
set signcolumn=yes
syntax on
filetype plugin indent on

" Status line
set statusline=\ %f\ %m\ %r%=%y\ %{&fileencoding}\ %l:%c\ 
