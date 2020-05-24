nnoremap <buffer> <localleader>l :Dispatch ghc -fwarn-incomplete-patterns % -e 'return 0'<cr>
nnoremap <buffer> <localleader>w :Format<cr>:w<cr>:Dispatch ghc -fwarn-incomplete-patterns % -e 'return 0'<cr>
