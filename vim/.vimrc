" ============================================================
" NOTES
" ============================================================

" when to use `nore` map:
" - if we don't want to use existing binding
" when to use regular mapping:
" - when we want to utilize existing mapping (e.g. <Plug>)

" ============================================================
" TODO
" ============================================================

" - ack.vim shortcut
" - should be something like 'are -> :Ack! pattern **/*.re

" ============================================================
" BASIC SETTINGS
" ============================================================

" AUTOCMD {{{

augroup vim_enter
    " Redraw screen after entering vim (there is a bugs that make it render only
    " half of the screen available on start up) we can also adjust zoom to make vim recalculate its stuffs
    
    autocmd!
    autocmd VimEnter * :mode
augroup END

augroup vim_cd
    " automatically change current directory to be the same directory as current
    " buffer.
    " source: https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file

    autocmd!
    set autochdir
    autocmd BufEnter * silent! cd %:p:h
augroup END

" }}}

" VIM Plug {{{
"
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'wakatime/vim-wakatime'
Plug 'ryanoasis/vim-devicons'

call plug#end()

" }}}

" Settings - Theming {{{

set term=xterm-256color
colorscheme murphy

" enable syntax highlighting
syntax on

" change popup menu to the same as dracula pop up (for easier use)
hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

" number and characters
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set list

" line settings
" set column width to 80
set columns=80
" enable text wrapping
set wrap
" enable linebreak
set linebreak
" make line break (wrap) shown as ...
set showbreak=....
" mark 81th column line
set colorcolumn=81
highlight ColorColumn ctermbg=8
" set hybrid line numbering
set number relativenumber

" }}}

" Settings - Editing & Navigation {{{

set encoding=UTF-8

" enable file type based indentation
filetype plugin indent on
" respect indentation when starting a new line
set autoindent
" expand tabs to spaces. essential in python
set expandtab
" number of spaces tab is counted for
set tabstop=2
" number of spaces to use for autoindent
set shiftwidth=4
" fix backspace behavior on most terminals
set backspace=2

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" make a fold based on indentation
" set foldmethod=indent

" make newly opened buffer not folded when first opened
" autocmd BufRead * normal zM

" make scroll happened at 15 from top/bottom
set so=15

" }}}

" File and buffers management {{{

" make all swap files to be centralized into .vim/swap
set directory=$HOME/.vim/swap//

" close buffer without closing window
command! Bd :bp | :sp | :bn | :bd

" enable enhanced tab autocomplete
set wildmenu
" complete till longest string, then open the wildmenu
set wildmode=list:longest,full

" overide default split window to split below
set splitbelow
" overide default split window to split right
set splitright

" make netrw able to delete non empty folder
let g:netrw_localrmdir='rm -r'

" }}}

" Folding {{{

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod =marker
augroup END

" }}}

" Abbreviations {{{

iabbrev 'v-- " ============================================================

" }}}

" ============================================================
" KEY-BINDINGS - BASICS
" ============================================================

" Key-bindings - Navigation {{{

function! HLNext (blinktime)
    let [bufnum, lnum, col, off]=getpos('.')
    let matchlen=strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat='\c\%#\%('.@/.'\)'
    let ring=matchadd('ColorColumn', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

nnoremap <silent> n   n:call HLNext(0.025)<cr>
nnoremap <silent> N   N:call HLNext(0.025)<cr>


" }}}

" Key-bindings - Settings {{{

" Toggle signcolumn. Works only on vim>=8.0 or NeoVim
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=auto
        let b:signcolumn_on=1
    endif
endfunction

nnoremap <bs>h :noh<cr>
nnoremap <bs>cp :set number! relativenumber! list!<cr> :call ToggleSignColumn()<cr>

" }}}

" Key-Bindings - Editing {{{

" delete to the beginning of line in insert mode
inoremap <m-c> <esc>0C
inoremap <m-O> <esc>O

" move block of text using alt-something
nnoremap <m-j> :m .+1<cr>==
nnoremap <m-k> :m .-2<cr>==
inoremap <m-j> <Esc>:m .+1<cr>==gi
inoremap <m-k> <Esc>:m .-2<cr>==gi
vnoremap <m-j> :m '>+1<cr>gv=gv
vnoremap <m-k> :m '<-2<cr>gv=gv

" }}}

" Key-Bindings - Folding {{{

" toggle folding current level
nnoremap <bs>ff za
" fold all level
nnoremap <bs>fm zM
" unfold all level
nnoremap <bs>fr zR
" toggle folding all level
nnoremap <expr> <bs>f<space> &foldlevel ? 'zM' :'zR'

" }}}

" Key-Bindings - Sessions {{{

" SessionSaveTarget
nnoremap <bs>sst :mks! ~/.vim/sessions/
" SessionLoadTarget
nnoremap <bs>slt :source ~/.vim/sessions/
" SessionSaveAuto
nnoremap <bs>ssa :mks! ~/.vim/sessions/auto-session.vim<cr>
" SessionLoadAuto
nnoremap <bs>sla :source ~/.vim/sessions/auto-session.vim<cr>
" SessionSaveautoQuit
nnoremap <bs>ssq :mks! ~/.vim/sessions/auto-session.vim<cr>:qa!<cr>

" }}}

" ===========================================================
" KEY-BINDINGS - LEADER
" ============================================================

let mapleader="\<Space>"

" RC files {{{

" config-action-type

" vim
nnoremap <Leader>crv :source $MYVIMRC<cr> :mode<cr> <c-w>=
nnoremap <Leader>cev :tabnew $MYVIMRC<cr>

" vim-coc
nnoremap <Leader>cec :CocConfig<vR>
" zsh
nnoremap <Leader>cez :tabnew ~/.zshrc<cr>
" tmux
nnoremap <Leader>cet :tabnew ~/.tmux.conf<cr>
" work
nnoremap <Leader>cew :tabnew ~/wkf-repos/ruangguru/source/package.re.json<cr>

" }}}

" Editing {{{

nnoremap <Leader>q :q<cr>
nnoremap <Leader>qa! :qa!<cr>

" }}}

" Workspace management {{{

" 'cd' towards the dir in which the current file is edited
" but only change the path for the current window
noremap <leader>cd :lcd %:h<cr>

" }}}

" Window management {{{

nnoremap <Leader>tn :tabnew<Space>

" }}}

" Buffer management {{{

" close all buffers except this one
nnoremap <leader>bca :w <bar> %bd <bar> e# <bar> bd# <cr>

" }}}

" ============================================================
" KEY-BINDINGS - LOCAL LEADER
" ============================================================


" ============================================================
" PLUGINS
" ============================================================

" Plugin - NerdCommenter {{{

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" }}}

" Plugin - Vim DevIcons {{{

set guifont=Fira\ Code:h12

" }}}

" Plugin - Ack.vim {{{

" make ack.vim not to automatically open first result
cnoreabbrev Ack Ack!
nnoremap <Leader>fa :Ack!<Space>-i<Space>
nnoremap <Leader>fijs :Ack!<Space>--js<Space>-i<Space>
nnoremap <Leader>fijon :Ack!<Space>--json<Space>-i<Space>
nnoremap <Leader>fimd :Ack!<Space>--md<Space>-i<Space>
nnoremap <Leader>fire :Ack!<Space>--reasonml<Space>-i<Space>
nnoremap <Leader>fiatd :Ack!<Space>--atd<Space>-i<Space>
nnoremap <Leader>ficss :Ack!<Space>--css<Space>-i<Space>
nnoremap <Leader>fiml :Ack!<Space>--css<Space>-i<Space>

let g:ack_mappings={
              \ 'v':  '<c-W><cr><c-W>L<c-W>p<c-W>J<c-W>p<c-W>=',
              \ 'gv': '<c-W><cr><c-W>L<c-W>p<c-W>J<c-W>='
              \ }
" if executable('ag')
  " let g:ackprg = 'ag --nogroup --nocolor --column --vimgrep'
" endif

" }}}

" Plugin - Prettier {{{

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" }}}

" Plugin - Lightline {{{

set laststatus=2

let g:lightline={
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" }}}

" Plugin - NERDTree {{{

" display bookmarks on startup
let NERDTreeShowBookmarks=1
" don't let nerdtree hijack netrw
let NERDTreeHijackNetrw=0
" show hidden files in nerdtree
let NERDTreeShowHidden=1

let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeChDirMode=2
nnoremap <Leader>ntt :NERDTreeToggle<cr><c-w>=
nnoremap <Leader>ntn :NERDTree<cr><c-w>=
nnoremap <Leader>ntv :NERDTreeVCS<cr><c-w>=

" }}}

" Plugin - Ctrl P {{{

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']

let g:ctrlp_root_markers=['package.json']
let g:ctrlp_custom_ignore='\v[\/](node_modules|target|dist|build)|(\.(swp|ico|git|svn|bs.js|vscode))$'
let g:ctrlp_max_files=0
let g:ctrlp_lazy_update=400
let g:ctrlp_follow_symlinks=1
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}

" map ctrl-p buffer mode to c-b
nnoremap <c-b> :CtrlPBuffer<cr>

" }}}

" Plugin - CoC {{{

let g:coc_global_extensions=[
            \ 'coc-css',
            \ 'coc-flow',
            \ 'coc-git',
            \ 'coc-html', 
            \ 'coc-json', 
            \ 'coc-markdownlint',
            \ 'coc-prettier',
            \ 'coc-python',
            \ 'coc-reason',
            \ 'coc-svg',
            \ 'coc-tsserver',
            \ 'coc-vimlsp',
            \ 'coc-xml',
            \ 'coc-yaml', 
            \ ]

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<c-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
  let col=col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-leader> to trigger completion.
inoremap <silent><expr> <c-leader> coc#refresh()

" Use <cr> to confirm completion
" <c-g>u means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<c-y>" : "\<c-g>u\<cr>"
 
" navigate diagnostic
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nmap <silent> K :call <SID>show_documentation()<cr>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


augroup coc_cursor_hold
    autocmd!

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

" Remap for rename current word
nmap <leader>ern <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>cofs  <Plug>(coc-format-selected)
nmap <leader>cofs <Plug>(coc-format-selected)


augroup coc_format_expr
  autocmd!

  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>coar  <Plug>(coc-codeaction-selected)
nmap <leader>coar <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>coal  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>cofc  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <c-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <c-d> <Plug>(coc-range-select)
xmap <silent> <c-d> <Plug>(coc-range-select)

function! Format()
    let linenumber = line(".")
    call CocAction('format')
    call cursor(linenumber, 0)
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 Format :call Format()

" Use leader cof to format reason
nnoremap <silent> <leader>cof :Format<cr>

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <leader>coda  :<c-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>cole  :<c-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <leader>colc  :<c-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <leader>coou  :<c-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <leader>cols  :<c-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <leader>con  :<c-u>CocNext<cr>
" Do default action for previous item.
nnoremap <silent> <leader>cop  :<c-u>CocPrev<cr>
" Resume latest coc list
nnoremap <silent> <leader>colr  :<c-u>CocListResume<cr>
" Restart
nnoremap <silent> <leader>codr  :<c-u>CocDisable<cr> :<c-u>CocRestart<cr>

" Modify leader w to format and save
nnoremap <Leader>w :Format<cr>:w<cr>

" }}}

