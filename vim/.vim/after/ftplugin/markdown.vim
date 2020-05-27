nnoremap <silent> <buffer> <localleader>f :MarkdownFormat<cr>
nnoremap <silent> <buffer> <localleader>w :w<cr>:MarkdownFormat<cr>

augroup vim_markdown
  autocmd!
" Use formatprg when available
  autocmd FileType markdown setlocal shiftwidth=2
  autocmd FileType markdown setlocal tabstop=2
  autocmd FileType markdown setlocal softtabstop=2
  autocmd FileType markdown set autoread
  autocmd FocusGained,BufEnter *.md :silent! !
  autocmd FocusLost,WinLeave *.md :silent! w
augroup END
