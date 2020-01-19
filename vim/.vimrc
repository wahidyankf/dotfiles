" ============================================================
" NOTES
" ============================================================

" when to use regular mapping:
" - when we want to utilize existing mapping (e.g. <Plug>)

" ============================================================
" TODO
" ============================================================

" - grep/ripgrep from the nearest project root

" ============================================================
" BASIC SETTINGS
" ============================================================

" AUTOCMD {{{

augroup vim_enter
    " Redraw screen after entering vim (there is a bugs that make it render only
    " half of the screen available on start up) we can also adjust zoom to make
    " vim recalculate its stuffs
    
    autocmd!
    autocmd VimEnter * :mode
augroup END

augroup vim_cd
    " automatically change current directory to be the same directory as current
    " buffer.

    autocmd!
    set autochdir
    autocmd BufEnter * silent! cd %:p:h
augroup END

" }}}

" VIM Plug {{{
"
call plug#begin('~/.vim/plugged')

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'reasonml-editor/vim-reason-plus'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'wakatime/vim-wakatime'
Plug 'morhetz/gruvbox'
Plug 'figitaki/vim-dune'
Plug 'jpalardy/vim-slime'
Plug 'gcmt/taboo.vim'

call plug#end()

" }}}

" Settings - Theme {{{

set term=xterm-256color

" enable syntax highlighting
syntax on

" Murphy colorscheme - inactive {{{

" colorscheme murphy
" change popup menu to the same as dracula pop up (for easier use)
" hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
" hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

" }}}

" Gruvbox - active {{{

let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
set bg=dark

" color palette: 223, 233, 235, 240, 241, 246, 250,

function! g:SetTablineTheme ()
    " TabLine -> tab pages line, not active tab page label
    highlight TabLine gui=None cterm=NONE term=NONE ctermfg=246 ctermbg=233
    " TabLineFill -> tab pages line, where there are no labels
    highlight TabLineFill gui=None cterm=NONE term=NONE ctermfg=246 ctermbg=233
    " TabLineSel -> tab pages line, active tab page label
    highlight TabLineSel gui=None cterm=bold term=NONE ctermfg=235 ctermbg=246
endfunction

augroup configure_tabline
    autocmd!
    autocmd SourcePost * silent call SetTablineTheme()
    autocmd SessionLoadPost * silent call SetTablineTheme()
augroup END

" }}}

" number and characters
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
set list

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
    autocmd FileType javascript setlocal foldmethod=syntax
    autocmd FileType reason setlocal foldmethod=syntax
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}

" Abbreviations {{{

inoreabbrev 'v-- " ============================================================
cnoreabbrev yarn_cgb yarn clean && yarn gen && yarn build
cnoreabbrev yarn_cbl yarn clean && yarn build:libs

" }}}

" ============================================================
" HELPER FUNCTIONS
" ============================================================

" Navigation {{{

function! g:GetProjectRootPWD()
    " config - what files/dir will be used for project's root directory marker
    " lower index means higher priority
    let l:project_root_marker = ["package.json", ".git", "dune-project"]
    " set maximum round of tree traversal
    let l:maximum_traversal_round = 10

    " initial values
    let l:current_traversal_round = 0
    let l:starting_pwd = system('pwd')

    " accumulator for returned pwd
    let l:last_pwd = system('pwd')

   while current_traversal_round < maximum_traversal_round
        let marker_count_as_str = "0"
        let marker_count = 0

        for marker in project_root_marker
            let marker_count_as_str = system("cd " . last_pwd . " ; ls -a | grep -w " . marker .  " | wc -l")
            let marker_count = str2nr(marker_count_as_str)

            if marker_count > 0
                break
            endif
        endfor

        if marker_count > 0
            " found it!
            break
        else
            "project root marker not found, traversing up
            let last_pwd = system("cd " . last_pwd . " ; cd .. ; pwd")
        endif

        let current_traversal_round += 1
    endwhile

    if current_traversal_round < 10
        return last_pwd
    else 
        return starting_pwd
    endif
endfunction

" Use `:GetProjectRootPWD` to cd Project root
command! -nargs=0 GetProjectRootPWD :call GetProjectRootPWD()

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

" }}}

" ============================================================
" KEY-BINDINGS - BASICS
" ============================================================

" Key-bindings - Navigation {{{

nnoremap <silent> n   n:call HLNext(0.025)<cr>
nnoremap <silent> N   N:call HLNext(0.025)<cr>

nnoremap <c-w>t :tab split<cr>
nnoremap <bs>ts :tab split<cr>
nnoremap <bs>l gt
nnoremap <bs>h gT

" }}}

" ============================================================
" KEY-BINDINGS - EDITING (ALT/META)
" ============================================================

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

" ============================================================
" KEY-BINDINGS - MODES AND BIG MOVEMENTS (BACKSPACE)
" ============================================================

" Key-Bindings - RC files {{{

" mnemonic: config-action-type

" vim
nnoremap <bs>cev :tabnew $MYVIMRC<cr>
nnoremap <bs>vcev :vsp $MYVIMRC<cr>
nnoremap <bs>crv :source $MYVIMRC<cr>:mode<cr><c-w>=

" vim-coc
nnoremap <bs>cec :CocConfig<cr>
" zsh
nnoremap <bs>cez :tabnew ~/.zshrc<cr>
nnoremap <bs>vcez :vsp ~/.zshrc<cr>
" ack
nnoremap <bs>cea :tabnew ~/.ackrc<cr>
nnoremap <bs>vcea :vsp ~/.ackrc<cr>
" tmux
nnoremap <bs>cett :tabnew ~/.tmux.conf<cr>
nnoremap <bs>vcett :vsp ~/.tmux.conf<cr>
nnoremap <bs>cetw :tabnew ~/.config/tmuxinator/work.yml<cr>
nnoremap <bs>vcetw :vsp ~/.config/tmuxinator/work.yml<cr>
nnoremap <bs>cetl :tabnew ~/.config/tmuxinator/learn.yml<cr>
nnoremap <bs>vcetl :vsp ~/.config/tmuxinator/learn.yml<cr>
nnoremap <bs>cetp :tabnew ~/.config/tmuxinator/prod.yml<cr>
nnoremap <bs>vcetp :vsp ~/.config/tmuxinator/prod.yml<cr>
" work
nnoremap <bs>cew :tabnew ~/wkf-repos/ruangguru/source/package.re.json<cr>
nnoremap <bs>vcew :vsp ~/wkf-repos/ruangguru/source/package.re.json<cr>

" }}}

" Key-Bindings - Buffer management {{{

" close all buffers except this one
nnoremap <bs>bca :w <bar> %bd <bar> e# <bar> bd# <cr>

" reload current buffer
nnoremap <bs>e :e<cr>

" bufdo e
nnoremap <bs>bde :bufdo e<cr>

" print pwd
nnoremap <bs>i :pwd<cr>

" }}}

" Key-Bindings - Window management {{{

" windo e
nnoremap <bs>wde :windo e<cr>

" }}}

" Key-Bindings - Modes {{{

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

nnoremap <bs>/ :noh<cr>
nnoremap <bs>y :set number! relativenumber! list!<cr> :call ToggleSignColumn()<cr>

" }}}

" Key-Bindings - Visual {{{

function VisualLength()
  exe 'normal "xy'
  echo "Visual: " . strlen(@x) . "\n"
  exe 'normal gv'
endfunction

map <bs>vc "xy:call VisualLength()<CR>

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
nnoremap <bs>ssaq :mks! ~/.vim/sessions/auto-session.vim<cr>:qa!<cr>

" SessionSaveWork
nnoremap <bs>ssw :mks! ~/.vim/sessions/work-session.vim<cr>
" SessionLoadAuto
nnoremap <bs>slw :source ~/.vim/sessions/work-session.vim<cr>
" SessionSaveWorkQuit
nnoremap <bs>sswq :mks! ~/.vim/sessions/work-session.vim<cr>:qa!<cr>

" SessionSaveLearn
nnoremap <bs>ssl :mks! ~/.vim/sessions/learn-session.vim<cr>
" SessionLoadLearn
nnoremap <bs>sll :source ~/.vim/sessions/learn-session.vim<cr>
" SessionSaveLearnQuit
nnoremap <bs>sslq :mks! ~/.vim/sessions/learn-session.vim<cr>:qa!<cr>

" }}}

" ===========================================================
" KEY-BINDINGS - LEADER
" ============================================================

let mapleader="\<Space>"

" Leader - Editing {{{

nnoremap <leader>q :q<cr>
nnoremap <leader>qa! :qa!<cr>

" }}}

" Leader - Workspace management {{{

" 'cd' towards the dir in which the current file is edited
" but only change the path for the current window
noremap <leader>cd :lcd %:h<cr>

" }}}

" Leader - Window management {{{

nnoremap <leader>tn :tabnew<Space>

" }}}

" ============================================================
" KEY-BINDINGS - LOCAL LEADER
" ============================================================

let maplocalleader=","

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

" Plugin - FZF and Ack.Vim {{{

" Use `:CDProjectRoot` to cd Project root
command! -nargs=0 CDProjectRoot :execute 'cd' GetProjectRootPWD()

nnoremap <bs>fb :Buffers<cr>
nnoremap <bs>fc :Commits<cr>
nnoremap <bs>ff :Files<cr>
nnoremap <bs>fg :GFiles<cr>
nnoremap <bs>fp :CDProjectRoot<cr>:Files

nnoremap <c-g> :GFiles<cr>
nnoremap <c-p> :CDProjectRoot<cr>:Files<cr>
nnoremap <c-b> :Buffers<cr>

nnoremap <bs>gg :CDProjectRoot<cr>:Ack!<Space>-i<Space>
nnoremap <bs>grg :CDProjectRoot<cr>:Rg<cr>
nnoremap <bs>gatd :CDProjectRoot<cr>:Ack!<Space>--atd<Space>-i<Space>
nnoremap <bs>gcss :CDProjectRoot<cr>:Ack!<Space>--css<Space>-i<Space>
nnoremap <bs>gjson :CDProjectRoot<cr>:Ack!<Space>--json<Space>-i<Space>
nnoremap <bs>gjs :CDProjectRoot<cr>:Ack!<Space>--js<Space>-i<Space>
nnoremap <bs>gmd :CDProjectRoot<cr>:Ack!<Space>--md<Space>-i<Space>
nnoremap <bs>gml :CDProjectRoot<cr>:Ack!<Space>--css<Space>-i<Space>
nnoremap <bs>gre :CDProjectRoot<cr>:Ack!<Space>--reason<Space>-i<Space>
nnoremap <bs>g :CDProjectRoot<cr>:Ack!<Space>-i<Space>

let g:ack_mappings={
              \ 'v':  '<c-W><cr><c-W>L<c-W>p<c-W>J<c-W>p<c-W>=',
              \ 'gv': '<c-W><cr><c-W>L<c-W>p<c-W>J<c-W>='
              \ }

" }}}

" Plugin - Lightline {{{

set laststatus=2

let g:lightline={
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
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
let g:NERDTreeIgnore = ['.bs.js$']

let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeChDirMode=2

" e stands for explorer
nnoremap <bs>et :NERDTreeToggle<cr><c-w>=
nnoremap <bs>ee :NERDTree<cr><c-w>=
nnoremap <bs>ep :CDProjectRoot<cr>:NERDTree<cr><c-w>=
nnoremap <bs>eg :NERDTreeVCS<cr><c-w>=

" }}}

" Plugin - Vim-Slime {{{

let g:slime_no_mappings = 1
let g:slime_target = "tmux"
let g:slime_paste_file = "$HOME/.slime_paste"

" Token		Meaning
" {last}	!	The last (previously active) pane
" {next}	+	The next pane by number
" {previous}	-	The previous pane by number
" {top}		The top pane
" {bottom}		The bottom pane
" {left}		The leftmost pane
" {right}		The rightmost pane
" {top-left}		The top-left pane
" {top-right}		The top-right pane
" {bottom-left}		The bottom-left pane
" {bottom-right}		The bottom-right pane
" {up-of}		The pane above the active pane
" {down-of}		The pane below the active pane
" {left-of}		The pane to the left of the active pane
" {right-of}		The pane to the right of the active pane

let g:slime_default_config = {"socket_name": "default", "target_pane": "{down-of}"}

xmap <c-c><c-c> <Plug>SlimeRegionSend
nmap <c-c><c-c> <Plug>SlimeParagraphSend
nmap <c-c>v     <Plug>SlimeConfig

" }}}

" Plugin - Taboo.vim {{{

set guioptions-=e
set sessionoptions+=tabpages,globals

nnoremap <bs>tn :TabooRename 
nnoremap <bs>to :TabooOpen 
nnoremap <bs>tr :TabooReset<cr>

let g:taboo_tab_format=" |> %N %f%m (%W) "
let g:taboo_renamed_tab_format=" |> %N %l%m (%W) "
let g:taboo_tabline=1

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
nmap <leader>corcw <Plug>(coc-rename)

augroup coc_format_expr
  autocmd!

  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>coar <Plug>(coc-codeaction-selected)
nmap <leader>coar <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>coac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>cofc  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
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
nnoremap <silent> <leader>cold  :<c-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <leader>cole  :<c-u>CocList extensions<cr>
" B
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
nnoremap <leader>w :Format<cr>:w<cr>
nnoremap <leader>W :w<cr>

" }}}

" Ocaml {{{


" Quick setup for VIM
" -------------------
" Append this to your .vimrc to add merlin to vim's runtime-path:
" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"
" 
" Also run the following line in vim to index the documentation:
" :execute "helptags " . g:opamshare . "/merlin/vim/doc"

" }}}

