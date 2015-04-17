set nocompatible
execute pathogen#infect()
syntax on
filetype plugin indent on

set title
set encoding=utf-8
set scrolloff=3
set autoindent
set smartindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set number
"set relativenumber
set undofile

set splitbelow splitright

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set nowrap
set textwidth=79
set formatoptions=n

if exists("+colorcolumn")
	set colorcolumn=80
endif

nmap tt :tabnew ./
