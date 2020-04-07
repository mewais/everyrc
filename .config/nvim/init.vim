""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""   VUNDLE STUFF  """"""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim

" Start vundle
call vundle#begin('~/.config/nvim/bundle')

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Class explorer (tags)
Plugin 'majutsushi/tagbar'

" Auto completion
Plugin 'roxma/nvim-yarp'
Plugin 'ncm2/ncm2'
Plugin 'ncm2/ncm2-path'
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-pyclang'
Plugin 'ncm2/ncm2-jedi'

"Syntax Checking
Plugin 'neomake/neomake'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'gabrielelana/vim-markdown'

" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Colorschemes
Plugin 'drewtempelmeyer/palenight.vim'

" end Vundle
call vundle#end()
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""   PERSONAL STUFF  """"""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Read local .vimrc (if any) in a secure way
set exrc
set secure

" Syntax
syntax on

" Line numbers
set nu

" Mouse support
set mouse=a

" Highlight search
set hlsearch
set incsearch

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Start NERDTree if no files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close if NERDTree is last
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Syntax Checking
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)

" Autocompletion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Open Tagbar
" autocmd VimEnter * TagbarToggle

" Color
set background=dark
colorscheme palenight
let g:palenight_terminal_italics=1
if (has("termguicolors"))
    set termguicolors
endif

" Airline
let g:airline_theme='palenight'
let g:airline_powerline_fonts = 1
