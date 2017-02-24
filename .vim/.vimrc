" set non compatible mode with vi
set nocompatible

" set relative number
set relativenumber

" show the cursor position all the time
set ruler

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
set textwidth=80
set colorcolumn=+1
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

" map for ruler
nnoremap <Leader>-- i----------<CR><Esc> "create a ruler
nnoremap <Leader><CR><CR> $a<CR><Esc> "add new line from normal mode

" create a title
nnoremap <Leader>ti- i----------<CR><CR>----------<CR><Esc>kki
nnoremap <Leader>ti= i==========<CR><CR>==========<CR><Esc>kki

" support for md. it is not might not be faster but easier to remember (at
" least for me :p)

" headings
nnoremap <Leader>mdh1 i#
nnoremap <Leader>mdh2 i##
nnoremap <Leader>mdh3 i###
nnoremap <Leader>mdh4 i####
nnoremap <Leader>mdh5 i#####
nnoremap <Leader>mdh6 i######

" emphasis and italics
nnoremap <Leader>mdit i__<Esc>i
nnoremap <Leader>mdem i****<Esc>hi
nnoremap <Leader>mdcem i**____**<Esc>hhhi
nnoremap <Leader>mdst i~~~~<Esc>hi

" source code
nnoremap <Leader>mdcil i``<CR><Esc>ka
nnoremap <Leader>mdcpy i```python<CR><CR>```<CR><Esc>kki
nnoremap <Leader>mdcjs i```javascript<CR><CR>```<CR><Esc>kki
nnoremap <Leader>mdcgn i```<CR><CR>```<CR><Esc>kki

" quote, link
nnoremap <Leader>mdq i><Space>
nnoremap <Leader>mdln i[hyperlink](link)<Esc>hhhhhhhhhhhhhhh
nnoremap <Leader>md- i----------<CR><Esc> 
