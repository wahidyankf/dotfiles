"please move on, she is not that good anyway
set nocompatible

" syntax
syntax on

" set hybridnumber
set relativenumber
set number

" show the cursor position all the time
set ruler

" set backspace like normal apps
set backspace=2

" install plugin using vim-plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py'}
Plug 'tpope/vim-commentary'
Plug 'rizzatti/dash.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'reewr/vim-monokai-phoenix'
Plug 'christoomey/vim-system-copy'
Plug 'scrooloose/nerdtree'
call plug#end()

" set the split, so that it behave more 'normal', also modify the focused split
set splitbelow
set splitright
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" searching preference
set ignorecase
set smartcase
set incsearch

" column and cursor
set textwidth=0
set wrapmargin=0
set colorcolumn=80
set cursorline
hi ColorColumn ctermbg=DarkGray

" set tab to 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set autoindent
set ai "auto indent
set si "smart indent
set wrap " wrap

" set wildmenu
set wildmenu
set wildmode=list:longest,full 

" disable backup and swap
set nobackup
set nowritebackup
set noswapfile

" set encoding
set encoding=utf8

" history
set history=700

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

" add new line shortcut
nnoremap <Leader><CR><CR> $a<CR><Esc> 

" create a title
nnoremap <Leader>ti- i----------<CR><CR>----------<CR><Esc>kki
nnoremap <Leader>ti= i==========<CR><CR>==========<CR><Esc>kki

" nerd tree

map <Leader>nrd :NERDTreeToggle<CR>

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
noremap <Leader>md- i----------<CR><Esc>
