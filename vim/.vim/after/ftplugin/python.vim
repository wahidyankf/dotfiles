nnoremap <buffer> <localleader>crr :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
nnoremap <buffer> <localleader>cri :CocCommand python.execInTerminal<cr>
