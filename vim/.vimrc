" Py 3 imp warning

if has('python3')
  silent! python3 1
endif

" -----------------------------------------------------------------------------
" install plugin using vim-plug
" -----------------------------------------------------------------------------
"
call plug#begin('~/.vim/plugged')

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'flazz/vim-colorschemes'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'rizzatti/dash.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-system-copy'
Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'wakatime/vim-wakatime'

" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'graphql', 'markdown', 'vue'] }

" Deoplete

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'wokalski/autocomplete-flow'

" For func argument completion
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Deoplete completion source
Plug 'carlitux/deoplete-ternjs', {'do': 'npm install -g tern'}

" syntax
Plug 'https://github.com/pangloss/vim-javascript'

" flow
Plug 'https://github.com/flowtype/vim-flow'

call plug#end()

" deoplete
let g:deoplete#enable_at_startup = 1

" neosnippet
let g:neosnippet#enable_completed_snippet = 1

" -----------------------------------------------------------------------------
" vim settings (without plugins)
" -----------------------------------------------------------------------------

set nocompatible

" syntax
syntax on
" colorscheme dracula

"" Use python.
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" set hybridnumber
set relativenumber
set number

" show the cursor position all the time
set ruler

" set backspace like normal apps
set backspace=2

" set the split, so that it behave more 'normal', also modify the focused split
set splitbelow
set splitright
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999

" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set list

" searching preference
set ignorecase
set smartcase
set incsearch

" column and cursor
set textwidth=0
set wrapmargin=0
set colorcolumn=80
hi ColorColumn ctermbg=DarkGray

" set tab to 2 spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set autoindent
set ai " auto indent
set si " smart indent
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
      \
" Quick Fix Open\

autocmd! FileType qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>L

" -----------------------------------------------------------------------------
" plugins setup
" -----------------------------------------------------------------------------

" ----------
" Syntax
" ----------

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" ----------
" Prettier
" ----------

" "prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.graphql,*.md,*.vue PrettierAsync

" max line length that prettier will wrap on
" Prettier default: 80
let g:prettier#config#print_width = 80

" use tabs over spaces
" Prettier default: false
let g:prettier#config#use_tabs = 'false'

" number of spaces per indentation level
" Prettier default: 2
let g:prettier#config#tab_width = 2

" single quotes over double quotes
" Prettier default: false
let g:prettier#config#single_quote = 'true'

" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'false'

" put > on the last line instead of new line
" Prettier default: false
let g:prettier#config#jsx_bracket_same_line = 'true'

" none|es5|all
" Prettier default: none
let g:prettier#config#trailing_comma = 'es5'

" avoid|always
" Prettier default: avoid
" let g:prettier#config#arrow_parens = 'always'

" flow|babylon|typescript|css|less|scss|json|graphql|markdown
" Prettier default: babylon
" let g:prettier#config#parser = 'flow'

" cli-override|file-override|prefer-file
" let g:prettier#config#config_precedence = 'prefer-file'

" always|never|preserve
" let g:prettier#config#prose_wrap = 'preserve'

" print semicolons
" Prettier default: true
" let g:prettier#config#semi = 'true'

" ----------
" Ctrl P
" ----------

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_cmd = 'CtrlPMixed'


" ----------
" Silver Searcher
" ----------

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" -----------------------------------------------------------------------------
" key mapping
" -----------------------------------------------------------------------------

" disable arrow key, just because, you know..
" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

" map leader to space
let mapleader = "\<Space>"

" map space cv to compile vimrc
nnoremap <Leader>cv :source $MYVIMRC<CR>

" space w to save file
nnoremap <Leader>w :w<CR>

" space q to close the file
nnoremap <Leader>q :q<CR>

" copy all to system clipboard
nnoremap <Leader>cpa gg"*yG

" ctrlp
let g:ctrlp_map = '<c-p>'

" nerd tree
map <Leader>nt :NERDTreeToggle<CR>

" deoplete
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
