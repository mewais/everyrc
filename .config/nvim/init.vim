""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""   VUNDLE STUFF  """"""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

" Start vundle
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Class explorer (tags)
Plugin 'majutsushi/tagbar'

" Auto completion
Plugin 'Valloric/YouCompleteMe'

"Syntax Checking
Plugin 'vim-syntastic/syntastic'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Markdown
Plugin 'godlygeek/tabular'
Plugin 'gabrielelana/vim-markdown'

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

" Recommended Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"YCM
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" Open Tagbar
autocmd VimEnter * TagbarToggle

" Color
colorscheme snazzy
if (has("termguicolors"))
    set termguicolors
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""   EXTRA SYNTAX  """"""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable LLVM IR and TD
augroup filetype
    au! BufRead,BufNewFile *.ll     set filetype=llvm
augroup END

augroup filetype
    au! BufRead,BufNewFile *.td     set filetype=tablegen
augroup END
