nnoremap <localleader>cri :CocCommand python.execInTerminal<cr>
map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
