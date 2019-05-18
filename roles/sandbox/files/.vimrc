" basics
set nocompatible
set encoding=utf-8
set number relativenumber
set noshowmode
set backspace=indent,eol,start
set whichwrap+=<,>,h,l,[,]
set ttimeoutlen=10
set tabstop=2
set cursorline
set laststatus=2

let g:onedark_termcolors=16
let g:onedark_hide_endofbuffer=1

" let g:airline_powerline_fonts = 1
let g:airline_theme = "onedark"
" let g:airline_theme = "minimalist"

" hides start message
set shortmess+=I

" autocomplete
set wildmode=longest,list,full

" disables autocomments
autocmd FileType * setlocal formatoptions-=c formatoptions-=o formatoptions-=r

" split
set splitbelow splitright

" disables netrw
let loaded_netrwPlugin = 1

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

colorscheme onedark

filetype plugin on
syntax on
