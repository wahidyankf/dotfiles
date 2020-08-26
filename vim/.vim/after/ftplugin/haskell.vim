" to enable highlighting of `forall`1=
let g:haskell_enable_quantification
" to enable highlighting of `mdo` and `rec`
let g:haskell_enable_recursivedo = 1
" to enable highlighting of `proc`
let g:haskell_enable_arrowsyntax = 1
" to enable highlighting of `pattern`
let g:haskell_enable_pattern_synonyms = 1
" to enable highlighting of type roles
let g:haskell_enable_typeroles = 1
" to enable highlighting of `static`
let g:haskell_enable_static_pointers = 1
" to enable highlighting of backpack keywords
let g:haskell_backpack = 1

nnoremap <buffer> <localleader>l :Dispatch ghc -fwarn-incomplete-patterns % -e 'return ()'<cr>
nnoremap <buffer> <localleader>w :Format<cr>:w<cr>:Make<cr>

set makeprg=ghc\ -fwarn-incomplete-patterns\ %\ -e\ 'return()'

" New format taken from haskellmode.vim
setl errorformat=
                 \%-Z\ %#,
                 \%W%f:%l:%c:\ Warning:\ %m,
                 \%E%f:%l:%c:\ %m,
                 \%E%>%f:%l:%c:,
                 \%+C\ \ %#%m,
                 \%W%>%f:%l:%c:,
                 \%+C\ \ %#%tarning:\ %m,
