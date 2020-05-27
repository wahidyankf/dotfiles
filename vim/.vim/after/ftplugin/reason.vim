" Use leader cof to format reason
nnoremap <silent> <buffer> <localleader>f :BsReFormat<cr>
nnoremap <silent> <buffer> <localleader>w :w<cr>:BsReFormat<cr>

augroup vim_autoread_reason
  " https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
  autocmd!
  autocmd FileType reason set autoread
  autocmd FocusGained,BufEnter *.re :silent! !
  autocmd FocusLost,WinLeave *.re :silent! w
augroup END