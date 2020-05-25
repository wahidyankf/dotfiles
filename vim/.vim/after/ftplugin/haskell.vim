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
