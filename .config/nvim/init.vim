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
Plugin 'ryanoasis/vim-devicons'

" Class explorer (tags)
Plugin 'majutsushi/tagbar'

" Auto completion
Plugin 'roxma/nvim-yarp'
Plugin 'ncm2/ncm2'
Plugin 'ncm2/ncm2-path'
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-pyclang'
Plugin 'ncm2/ncm2-jedi'

" Syntax Checking
Plugin 'neomake/neomake'

" Code Style
Plugin 'rhysd/vim-clang-format'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Doxygen
Plugin 'DoxygenToolkit.vim'

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'gabrielelana/vim-markdown'

" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Colorschemes
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'kaicataldo/material.vim'

" CMake
Plugin 'cdelledonne/vim-cmake'

" GDB
Plugin 'cpiger/NeoDebug'

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
set expandtab

" Doxygen
let g:DoxygenToolkit_briefTag_pre="\\brief "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@returns "
let g:DoxygenToolkit_authorName="Mohammad Ewais"

" Open Tagbar
let g:tagbar_left = 1
let g:tagbar_vertical = 25

" Start NERDTree if no files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | execute 'TagbarToggle' | endif

" Close if NERDTree is last
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Syntax Checking
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)

" Autocompletion
let g:ncm2_pyclang#library_path = '/usr/lib/llvm-12/lib/'
let g:ncm2_pyclang#database_path = [
            \ 'compile_commands.json',
            \ 'Debug/compile_commands.json',
            \ 'Release/compile_commands.json'
            \ ]
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Color
set background=dark
" colorscheme palenight
" let g:palenight_terminal_italics=1
let g:material_terminal_italics=1
let g:material_theme_style = 'palenight'
colorscheme material
if (has('nvim'))
    let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
if (has("termguicolors"))
    set termguicolors
endif

" Airline
" let g:airline_theme='palenight'
let g:airline_theme='material'
let g:airline_powerline_fonts = 1

" CMake
let g:cmake_generate_options=['-DCMAKE_EXPORT_COMPILE_COMMANDS=ON']
