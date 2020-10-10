" ============================================================
" NOTES
" ============================================================

" after plugin ./wkf-devbox/vim/.vim/after/ftplugin/reason.vim

" when to use regular mapping:
" - when we want to utilize existing mapping (e.g. <Plug>)

" ============================================================
" TODO
" ============================================================

" - grep/ripgrep from the nearest project root

" ============================================================
" BASIC SETTINGS 
" ============================================================

" LEADERS {{{

let mapleader="\<Space>"
let maplocalleader=","

" }}}

" AUTOCMD {{{

augroup vim_enter
    " Redraw screen after entering vim (there is a bugs that make it render only
    " half of the screen available on start up) we can also adjust zoom to make
    " vim recalculate its stuffs
    
    au!
    au VimEnter * :mode
augroup END

augroup vim_cd
    " automatically change current directory to be the same directory as current
    " buffer.

    au!
    set autochdir
    au BufEnter * silent! cd %:p:h
augroup END

" }}}

" VIM Plug {{{
call plug#begin()

Plug 'Twinside/vim-haskellFold'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'
Plug 'diepm/vim-rest-console'
Plug 'easymotion/vim-easymotion'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'figitaki/vim-dune'
Plug 'gcmt/taboo.vim'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'liuchengxu/vim-which-key'
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neovimhaskell/haskell-vim'
Plug 'plasticboy/vim-markdown'
Plug 'radenling/vim-dispatch-neovim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'roman/golden-ratio'
Plug 'ryanoasis/vim-devicons'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sotte/presenting.vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'wakatime/vim-wakatime'
Plug 'pseewald/vim-anyfold'

" color theme
Plug 'morhetz/gruvbox'
Plug 'romainl/vim-dichromatic'
Plug 'Jorengarenar/vim-darkness'
Plug 'fxn/vim-monochrome'
" another favourite for color-blindness friendly theme

call plug#end()

" }}}

" set timeout for success keystroke sequence
set timeoutlen=2000

set equalalways

" Settings - Theme {{{

" enable syntax highlighting
syntax on

" Gruvbox - active {{{

let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
colorscheme gruvbox
set bg=dark

" colorscheme monochrome
let g:monochrome_italic_comments = 1

nnoremap <bs>t1 :colorscheme gruvbox<cr>:set bg=dark<cr>
nnoremap <bs>t2 :colorscheme gruvbox<cr>:set bg=light<cr>
nnoremap <bs>t3 :colorscheme darkness<cr>
nnoremap <bs>t6 :colorscheme monochrome<cr>
nnoremap <bs>t5 :colorscheme dichromatic<cr>

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
    au!
    au SourcePost * silent call SetTablineTheme()
    au SessionLoadPost * silent call SetTablineTheme()
augroup END

" }}}

" number and characters
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<
" set listchars=tab:>·,trail:~,extends:>,precedes:<
set list

" enable text wrapping
set wrap

" enable linebreak
set linebreak

" make line break (wrap) shown as ...
set showbreak=....

" mark 81th column line
" set colorcolumn=81

" set hybrid line numbering
set number relativenumber

" TODO update the color theme
hi SignColumn ctermfg=none ctermbg=darkgray cterm=NONE

" that gutter
set signcolumn=no

set statusline^=%{coc#status()}

" }}}

" Settings - Editing & Navigation {{{

" writes the content of the file automatically if we call :make
au FileType go set autowrite

set encoding=UTF-8

filetype plugin on
" enable file type based indentation
filetype plugin indent on
" respect indentation when starting a new line
set autoindent
" expand tabs to spaces. essential in python
set expandtab
" number of spaces tab is counted for
set tabstop=2
" number of spaces to use for autoindent
set shiftwidth=2
" fix backspace behavior on most terminals
set backspace=2

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" make scroll happened at 15 from top/bottom
" set so=15

" copy text under visual to clipboard
vmap <bs>yv :w !pbcopy<cr><cr>
" copy all text
nnoremap <bs>ya ggvGy<c-o>
nnoremap <bs>yA ggvGy<c-o>:w !pbcopy<cr><cr>

" }}}

" File and buffers management {{{

" make all swap files to be centralized into .config/nvim/swap
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
    au!
    au FileType javascript AnyFoldActivate
    au FileType typescript AnyFoldActivate
    au FileType reason setlocal foldmethod=syntax
    au FileType elixir setlocal foldmethod=syntax
    au FileType go setlocal foldmethod=manual
    au FileType vim setlocal foldmethod=marker
    au BufRead *.md normal zR
    au BufRead *.re normal zR
augroup END

augroup elixirLang
  au!
  au BufNewFile,BufRead *.ex set filetype=elixir syntax=elixir
  au BufNewFile,BufRead *.exs set filetype=elixir syntax=elixir
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
    let l:project_root_marker = ["package.json", ".git", "dune-project",  "mix.exs",  ".projectile", ".wkf-root", "service.yaml"]
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

" Use `:CDProjectRoot` to cd Project root
command! -nargs=0 CDProjectRoot :execute 'cd' GetProjectRootPWD()

" }}}

" ============================================================
" KEY-BINDINGS - BASICS
" ============================================================

" Key-bindings - Navigation {{{

nnoremap <silent> n   n:call HLNext(0.025)<cr>
nnoremap <silent> N   N:call HLNext(0.025)<cr>

nnoremap <bs>1 1gt
nnoremap <bs>2 2gt
nnoremap <bs>3 3gt
nnoremap <bs>4 4gt
nnoremap <bs>5 5gt
nnoremap <bs>6 6gt
nnoremap <bs>7 7gt
nnoremap <bs>8 8gt
nnoremap <bs>9 9gt
nnoremap <bs>l gt
nnoremap <bs>h gT

nnoremap <localleader><localleader>1 1gt
nnoremap <localleader><localleader>2 2gt
nnoremap <localleader><localleader>3 3gt
nnoremap <localleader><localleader>4 4gt
nnoremap <localleader><localleader>5 5gt
nnoremap <localleader><localleader>6 6gt
nnoremap <localleader><localleader>7 7gt
nnoremap <localleader><localleader>8 8gt
nnoremap <localleader><localleader>9 9gt
nnoremap <localleader><localleader>l gt
nnoremap <localleader><localleader>h gT
nnoremap <localleader><localleader><localleader> :echom "ffs, this is not emacs!"<cr>

" }}}

" ============================================================
" KEY-BINDINGS - EDITING (ALT/META)
" ============================================================

" Key-Bindings - Editing {{{

" delete to the beginning of line in insert mode
inoremap <m-c> <esc>0C
inoremap <m-l> <esc>la
inoremap <m-h> <esc>i
inoremap <m-L> <esc>lcl
inoremap <m-H> <esc>cl
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

" Key-Bindings - Files {{{

" mnemonic: config-action-type
" vim-coc
nnoremap <bs>coc :CocConfig<cr>
nnoremap <bs>cr :CocRestart<cr>

" ack
nnoremap <bs>cat :tabnew ~/.ackrc<cr>
nnoremap <bs>cav :vsp ~/.ackrc<cr>p
nnoremap <bs>cax :sp ~/.ackrc<cr>

" tmux
nnoremap <bs>ctt :tabnew ~/.tmux.conf<cr>
nnoremap <bs>ctv :vsp ~/.tmux.conf<cr>
nnoremap <bs>ctx :sp ~/.tmux.conf<cr>

nnoremap <bs>ctwt :tabnew ~/.config/tmuxinator/work.yml<cr>
nnoremap <bs>ctwv :vsp ~/.config/tmuxinator/work.yml<cr>
nnoremap <bs>ctwx :sp ~/.config/tmuxinator/work.yml<cr>

nnoremap <bs>ctlt :tabnew ~/.config/tmuxinator/learn.yml<cr>
nnoremap <bs>ctlv :vsp ~/.config/tmuxinator/learn.yml<cr>
nnoremap <bs>ctlx :sp ~/.config/tmuxinator/learn.yml<cr>

nnoremap <bs>ctbt :tabnew ~/.config/tmuxinator/book.yml<cr>
nnoremap <bs>ctbv :vsp ~/.config/tmuxinator/book.yml<cr>
nnoremap <bs>ctbx :sp ~/.config/tmuxinator/book.yml<cr>

nnoremap <bs>ctpt :tabnew ~/.config/tmuxinator/prod.yml<cr>
nnoremap <bs>ctpv :vsp ~/.config/tmuxinator/prod.yml<cr>
nnoremap <bs>ctpx :sp ~/.config/tmuxinator/prod.yml<cr>

nnoremap <bs>ctmt :tabnew ~/.config/tmuxinator/main.yml<cr>
nnoremap <bs>ctmv :vsp ~/.config/tmuxinator/main.yml<cr>
nnoremap <bs>ctmx :sp ~/.config/tmuxinator/main.yml<cr>


" vim
nnoremap <bs>cvt :tabnew ~/.vimrc<cr>
nnoremap <bs>cvv :vsp ~/.vimrc<cr>
nnoremap <bs>cvx :sp ~/.vimrc<cr>
nnoremap <bs>cve :e ~/.vimrc<cr>

nnoremap <bs>cnvt :tabnew $MYVIMRC<cr>
nnoremap <bs>cnvv :vsp $MYVIMRC<cr>
nnoremap <bs>cnvx :sp $MYVIMRC<cr>
nnoremap <bs>cnve :e $MYVIMRC<cr>

nnoremap <bs>cvr :source ~/.vimrc<cr>:mode<cr><c-w>=

" work
nnoremap <bs>cwt :tabnew ~/wkf-repos/ruangguru/source/package.re.json<cr>
nnoremap <bs>cwv :vsp ~/wkf-repos/ruangguru/source/package.re.json<cr>
nnoremap <bs>cwx :sp ~/wkf-repos/ruangguru/source/package.re.json<cr>

" zsh
nnoremap <bs>czt :tabnew ~/.zshrc<cr>
nnoremap <bs>czv :vsp ~/.zshrc<cr>
nnoremap <bs>czx :sp ~/.zshrc<cr>

" ftplugin
nnoremap <bs>cct :tabnew ~/.vim/after/ftplugin/README.org<cr>
nnoremap <bs>ccv :vsp ~/.vim/after/ftplugin/README.org<cr>
nnoremap <bs>ccx :sp ~/.vim/after/ftplugin/README.org<cr>

" rest client
nnoremap <bs>apimain :tabnew ~/wkf-devbox/rest/main.rest<cr>
nnoremap <bs>apirgsa :tabnew ~/wkf-devbox/rest/skillacademy.rest<cr>

" nvim terminal
" set shell=/bin/bash\ -i
" set shell=/bin/zsh\ -i
nnoremap <localleader>tv :CDProjectRoot<cr>:vsp term://zsh<cr>
nnoremap <localleader>tx :CDProjectRoot<cr>:sp term://zsh<cr>
nnoremap <localleader>tT :CDProjectRoot<cr>:tabnew term://zsh<cr>
nnoremap <localleader>tt :CDProjectRoot<cr>:sp term://zsh<cr><c-w>J:resize10<cr>
nnoremap <localleader>tq :BDExt zsh<cr>
nnoremap <localleader>t= <c-w>=:resize10<cr>
nnoremap <bs>zs :resize10<cr>
tnoremap <C-[> <C-\><C-n>

" boo
nnoremap <bs>cbt :tabnew ~/wkf-book/README.md<cr>
nnoremap <bs>cbv :vsp ~/wkf-book/README.md<cr>
nnoremap <bs>cbx :sp ~/wkf-book/README.md<cr>

" }}}

" Key-Bindings - Buffer management {{{

function! s:BDExt(ext)
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && bufname(v:val) =~ "\.'.a:ext.'$"')
  if empty(buffers) |throw "no *.".a:ext." buffer" | endif
  exe 'bd! '.join(buffers, ' ')
endfunction

command! -nargs=1 BDExt :call s:BDExt(<f-args>)

" close all buffers except this one
nnoremap <bs>bca :w <bar> %bd <bar> e# <bar> bd# <cr>

" reload current buffer
nnoremap <bs>e :e<cr>
" reload current buffer
nnoremap <bs>bb :e!<cr>

" bufdo e
nnoremap <bs>bdoe :bufdo e<cr>

" print pwd
nnoremap <bs>i :echo expand('%:p')<cr>

" bdext
nnoremap <bs>bde :BDExt 

" buffer quit hjkl
nnoremap <localleader>qh <c-w>h:q<cr>
nnoremap <localleader>qj <c-w>j:q<cr>
nnoremap <localleader>qk <c-w>k:q<cr>
nnoremap <localleader>ql <c-w>l:q<cr>
nnoremap <localleader>qq <c-[>l:q<cr>
nnoremap <localleader>qT :BDExt zsh<cr>

nnoremap <bs>burc :bufdo set undoreload=0<cr>:bufdo e<cr>:bufdo set undoreload=1000<cr><C-o><cr>:windo e<cr>

" }}}

" Key-Bindings - Window management {{{

" windo e
nnoremap <bs>wde :windo e<cr>
nnoremap <localleader>= <c-w>=
nnoremap <localleader>x :sp<cr>
nnoremap <localleader>v :vsp<cr>
nnoremap <c-c><c-o> :vertical wincmd f<cr>

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
nnoremap <localleader>/ :noh<cr>
nnoremap <bs>yy :set number! relativenumber! list!<cr> :call ToggleSignColumn()<cr>

" }}}

" Key-Bindings - Visual {{{

function! VisualLengthCount()
  exe 'normal "xy'
  echo "Visual: " . strlen(@x) . "\n"
  exe 'normal gv'
endfunction

map <bs>vlc "xy:call VisualLengthCount()<cr>

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

" SessionSaveBook
nnoremap <bs>ssb :mks! ~/.vim/sessions/book-session.vim<cr>
" SessionLoadBook
nnoremap <bs>slb :source ~/.vim/sessions/book-session.vim<cr>
" SessionSaveBookQuit
nnoremap <bs>ssbq :mks! ~/.vim/sessions/book-session.vim<cr>:qa!<cr>

" }}}

" ===========================================================
" KEY-BINDINGS - LEADER
" ============================================================

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
nnoremap <c-w>t :tab split<cr>
nnoremap <bs>ts :tab split<cr>

" }}}

" ============================================================
" KEY-BINDINGS - LOCAL LEADER
" ============================================================

" Key-Bindings - Quick Fix  {{{

nnoremap <localleader>en :cnext<cr>
nnoremap <localleader>ep :cprevious<cr>
nnoremap <localleader>eq :cclose<cr>
" popup close
nnoremap <localleader>pq :call <SID>show_documentation()<cr>
nnoremap <localleader>pp <c-w>p
nnoremap <localleader>eo :copen<cr>

" }}}

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

set guifont=Fira\ Code:h10

" }}}

" Plugin - FZF and Ack.Vim {{{

nnoremap <bs>fb :Buffers<cr>
nnoremap <bs>fc :Commits<cr>
nnoremap <bs>ff :Files<cr>
nnoremap <bs>fg :GFiles<cr>
nnoremap <bs>fp :CDProjectRoot<cr>:Files<cr>
nnoremap <bs>frg :CDProjectRoot<cr>:Rg<cr>
nnoremap <bs>fl :Lines<cr>
nnoremap <bs>fbl :BLines<cr>
nnoremap <bs>fm :Marks<cr>
nnoremap <bs>fw :Windows<cr>
nnoremap <bs>fhh :History<cr>
nnoremap <bs>fh/ :History/<cr>
nnoremap <bs>fh: :History:<cr>

nnoremap <c-g> :GFiles<cr>
nnoremap <c-p> :CDProjectRoot<cr>:Files<cr>
nnoremap <leader><leader> :CDProjectRoot<cr>:Files<cr>

nnoremap <c-b> :Buffers<cr>
nnoremap <leader>bi :Buffers<cr>
nnoremap <leader>, :Buffers<cr>

nnoremap <localleader>sg :CDProjectRoot<cr>:Ack!<Space>-i<Space>
nnoremap <localleader>srg :CDProjectRoot<cr>:Rg<cr>
nnoremap <localleader>satd :CDProjectRoot<cr>:Ack!<Space>--atd<Space>-i<Space>
nnoremap <localleader>scss :CDProjectRoot<cr>:Ack!<Space>--css<Space>-i<Space>
nnoremap <localleader>sjson :CDProjectRoot<cr>:Ack!<Space>--json<Space>-i<Space>
nnoremap <localleader>sjs :CDProjectRoot<cr>:Ack!<Space>--js<Space>-i<Space>
nnoremap <localleader>smd :CDProjectRoot<cr>:Ack!<Space>--md<Space>-i<Space>
nnoremap <localleader>sml :CDProjectRoot<cr>:Ack!<Space>--css<Space>-i<Space>
nnoremap <localleader>sre :CDProjectRoot<cr>:Ack!<Space>--reason<Space>-i<Space>
nnoremap <localleader>s :CDProjectRoot<cr>:Ack!<Space>-i<Space>

let g:ack_mappings={
              \ 'v':  '<c-W><cr><c-W>L<c-W>p<c-W>J<c-W>p<c-W>=',
              \ 'gv': '<c-W><cr><c-W>L<c-W>p<c-W>J<c-W>='
              \ }

" FZF to checkout git branches, Usage: GCheckout
function! s:open_branch_fzf(line)
  let l:parser = split(a:line)
  let l:branch = l:parser[0]
  if l:branch ==? '*'
    let l:branch = l:parser[1]
  endif
  execute '!git checkout ' . l:branch
endfunction

command! -bang -nargs=0 GCheckout
  \ call fzf#vim#grep(
  \   'git branch -v', 0,
  \   {
  \     'sink': function('s:open_branch_fzf')
  \   },
  \   <bang>0
  \ )

" }}}

" Plugin - Git Ops {{{

nnoremap <leader>gg :Gstatus<cr>
nnoremap <bs>gwua :CDProjectRoot<cr>:tabnew term://zsh<cr>igit_wkf_update_all<cr>
nnoremap <bs>gcpc :CDProjectRoot<cr>:tabnew term://zsh<cr>igit_complom_clean<cr>

nnoremap <bs>gco :GCheckout<cr>
nnoremap <bs>gcm :Commits<cr>
nnoremap <bs>gs :Gstatus<cr>
nnoremap <bs>gvd :Gvdiff<cr>
nnoremap <bs>gbc :BCommits<cr>
nnoremap <bs>gbl :Gblame<cr>

" }}}

" Plugin - Lightline {{{

set laststatus=2


let g:lightline={
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" }}}

" Plugin - NERDTree {{{

augroup nerdtreeconcealbrackets
      au!
      au FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
      au FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
      au FileType nerdtree setlocal conceallevel=3
      au FileType nerdtree setlocal concealcursor=nvic
augroup END

" display bookmarks on startup
let NERDTreeShowBookmarks=1
" don't let nerdtree hijack netrw
let NERDTreeHijackNetrw=0
" show hidden files in nerdtree
let NERDTreeShowHidden=1
" let g:NERDTreeIgnore = ['.bs.js$']
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize=30

let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
let NERDTreeChDirMode=2

" e stands for explorer
nnoremap <bs>et :NERDTreeToggle<cr><c-w>=
nnoremap <bs>ee :NERDTree<cr><c-w>=
nnoremap <bs>ep :CDProjectRoot<cr>:NERDTree<cr><c-w>=
" nnoremap <leader>op :CDProjectRoot<cr>:NERDTree<cr><c-w>=
nnoremap <leader>op :NERDTreeToggle<cr><c-w>=
nnoremap <bs>ef :NERDTreeFocus<cr>
nnoremap <bs>eq :NERDTreeClose<cr>
nnoremap <bs>eg :NERDTreeVCS<cr><c-w>=
nnoremap <bs>er :NERDTreeRefreshRoot<cr>

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

nnoremap <bs>tr :TabooRename 
nnoremap <localleader><localleader>r :TabooRename 

nnoremap <bs>to :TabooOpen 
nnoremap <bs>te :TabooReset<cr>
nnoremap <bs>tm :tabmove 

let g:taboo_tab_format=" |> %N %f%m (%W) "
let g:taboo_renamed_tab_format=" |> %N %l%m (%W) "
let g:taboo_tabline=1

" }}}
"
" Plugin - Vim Rest Console {{{
let g:vrc_auto_format_response_patterns = {
  \ 'json': 'python3 -m json.tool',
  \ 'xml': 'xmllint --format -',
\}
let g:vrc_curl_opts = {
  \ '-sS': '',
  \ '--connect-timeout': 10,
  \ '-i': '',
  \ '--max-time': 60,
  \ '-k': '',
\}

" }}}

" Plugin - Presenting.vim {{{

nnoremap <localleader>op :PresentingStart<cr>

au FileType md let b:presenting_slide_separator = '\v(^|\n)\#'

" }}}

" Plugin - Golden Ratio{{{

" Don't resize automatically.
let g:golden_ratio_autocommand = 0

" Mnemonic: - is next to =, but instead of resizing equally, all windows are
" resized to focus on the current.
nmap <C-w>- <Plug>(golden_ratio_resize)
" Fill screen with current window.
nnoremap <C-w>+ <C-w><Bar><C-w>_

" }}}

" Plugin - Which Key {{{
 
nnoremap <silent> <leader> :WhichKey '<Space>'<cr>
nnoremap <silent> <localleader> :WhichKey ','<cr>

" By default timeoutlen is 1000 ms
set timeoutlen=500

" }}}

" ============================================================
" Languages
" ============================================================

" Language Server - CoC {{{

let g:coc_global_extensions=[
            \ 'coc-css',
            \ 'coc-flow',
            \ 'coc-git',
            \ 'coc-html', 
            \ 'coc-json', 
            \ 'coc-prettier',
            \ 'coc-reason',
            \ 'coc-svg',
            \ 'coc-tsserver',
            \ 'coc-vimlsp',
            \ 'coc-java',
            \ 'coc-elixir',
            \ 'coc-yaml', 
            \ 'coc-python',
            \ 'coc-rls', 
            \ ]

" setup prettier command
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=100

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<c-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<c-p>" : "\<c-h>"

function! s:check_back_space() abort
  let col=col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
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
nmap <silent> <localleader>gd :sp<cr><Plug>(coc-definition)
nmap <silent> gk <Plug>(coc-declaration)
nmap <silent> <localleader>gk :sp<cr><Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> <localleader>gy :sp<cr><Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <localleader>gi :sp<cr><Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> <localleader>gr :sp<cr><Plug>(coc-references)

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
    au!

    " Highlight symbol under cursor on CursorHold
    au CursorHold * silent call CocActionAsync('highlight')
augroup END

" Remap for rename current word
nmap <localleader>ncw <Plug>(coc-rename)

augroup coc_format_expr
  au!

  " Setup formatexpr specified filetype(s).
  au FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! Format()
    let cursorpos = getpos(".")
    call CocAction('format')
    call cursor(cursorpos[1], cursorpos[2])
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 Format :call Format()

" Use leader cof to format 
nnoremap <silent> <localleader>f :Format<cr>

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <localleader>dl :<c-u>CocList diagnostics<cr>
" Show commands
nnoremap <silent> <localleader>dc :<c-u>CocList commands<cr>
" Remap for do codeAction of current line
nmap <localleader>da <Plug>(coc-codeaction)
" Find symbol of current document
nnoremap <silent> <localleader>do :<c-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <localleader>dsl :<c-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <localleader>dn :<c-u>CocNext<cr>
" Do default action for previous item.
nnoremap <silent> <localleader>dp :<c-u>CocPrev<cr>
" Fix autofix problem of current line
nmap <localleader>dff <Plug>(coc-fix-current)

" Modify leader w to format and save
nnoremap <localleader>w :w<cr>
nnoremap <leader>w :w<cr>

" }}}

" Language - Markdown {{{

let g:vim_markdown_conceal_code_blocks = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_follow_anchor = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_fenced_languages = ['js=javascript', 'hs=haskell']

function! MarkdownFormat()
    let cursorpos = getpos(".")
    silent execute "!" . "prettier --write --parser markdown" . " " . bufname("%")
    silent execute "e"
    call cursor(cursorpos[1], cursorpos[2])
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 MarkdownFormat :call MarkdownFormat()
" 
" }}}

" Language - ReasonML {{{
function! BsReFormat()
    let cursorpos = getpos(".")
    silent execute "!" . "bsrefmt --in-place" . " " . bufname("%")
    silent execute "e"
    call cursor(cursorpos[1], cursorpos[2])
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 BsReFormat :call BsReFormat()
" }}}

" Language - ejs {{{
autocmd BufNewFile,BufRead *.ejs set filetype=ejs
autocmd BufNewFile,BufRead *._ejs set filetype=ejs

function! s:DetectEjs()
    if getline(1) =~ '^#!.*\<ejs\>'
        set filetype=ejs
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectEjs()

" }}}
