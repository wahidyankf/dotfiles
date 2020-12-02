  " https://stackoverflow.com/questions/2490227/how-does-vims-autoread-work
augroup vim_autoread_reason
  autocmd!
  autocmd FileType reason set autoread

  if !has("gui_running")
      "silent! necessary otherwise throws errors when using command
      "line window.
      autocmd BufEnter        * silent! checktime
      autocmd CursorHold      * silent! checktime
      autocmd CursorHoldI     * silent! checktime
      "these two _may_ slow things down. Remove if they do.
      autocmd CursorMoved     * silent! checktime
      autocmd CursorMovedI    * silent! checktime
  endif
augroup END

" nnoremap <buffer> <localleader>w :w<cr>:BsReFormat<cr>:CocRestart<cr>
