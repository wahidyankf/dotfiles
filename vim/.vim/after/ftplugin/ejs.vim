autocmd BufNewFile,BufRead *.ejs set filetype=html
autocmd BufNewFile,BufRead *._ejs set filetype=html

function! s:DetectEjs()
    if getline(1) =~ '^#!.*\<ejs\>'
        set filetype=html
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectEjs()

