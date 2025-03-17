set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'gregsexton/matchtag'
Plugin 'mxw/vim-jsx'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

syntax on
colorscheme desert
set autoindent
colorscheme industry
set smartcase
set hlsearch
set laststatus=2
set ruler
set cursorline
set number
set visualbell
set mouse=a
set title
set foldmethod=indent
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif