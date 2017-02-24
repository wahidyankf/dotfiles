" set non compatible mode with vi
set nocompatible

" set relative number
set relativenumber

" install plugin using vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py'}
Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'reewr/vim-monokai-phoenix'
Plug 'christoomey/vim-system-copy'
call plug#end()

" set the split, so that it behave more 'normal'
set splitbelow
set splitright
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" searching preference
set smartcase
set incsearch

" column
set tw=79
set colorcolumn=80
highlight ColorColumn ctermbg=233

" set tab to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" disable backup and swap
set nobackup
set nowritebackup
set noswapfile

" key mapping

" map leader to space
let mapleader = "\<Space>"

" map space cv to compile vimrc
nnoremap <Leader>cv :source $MYVIMRC<CR>

" space w to save file
nnoremap <Leader>w :w<CR>

" space q to close the file
nnoremap <Leader>q :q<CR>

" disable arrow key, just because, you know..
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" you complete me
nnoremap <Leader>ydef :YcmCompleter GoTo<CR>
nnoremap <Leader>yref :YcmCompleter GoToReferences<CR>
nnoremap <Leader>ydoc :YcmCompleter GetDoc<CR>

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
