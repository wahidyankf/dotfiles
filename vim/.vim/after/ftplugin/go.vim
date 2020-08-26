let g:go_auto_type_info = 1
let g:go_def_mode='gopls'
let g:go_diagnostics_enabled = 1
let g:go_doc_popup_window = 1
let g:go_fmt_experimental = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls =1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_info_mode='gopls'
let g:go_metalinter_deadline = "5s"

let g:go_metalinter_autosave = 0
let g:go_metalinter_autosave_enabled = ['vet', 'errcheck']
let g:go_metalinter_enabled = ['vet', 'errcheck']
" to also enable lint
" let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
" let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

augroup goLang
  autocmd!

  function! SetGoIndentation()
    setlocal noexpandtab tabstop=4 shiftwidth=4
  endfunction

  " make newly opened buffer not folded when first opened
  " the folding is kinda meh if we use it with fold
  autocmd BufNewFile,BufRead *.go call SetGoIndentation()

  " The editor.action.organizeImport code action will auto-format code and add missing imports.
  " The code below used to run this automatically on save
  autocmd! BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
augroup END

nmap <buffer> <localleader>gK  :GoDocBrowser<cr>

nmap <buffer> <localleader>cc :<C-u>call <SID>build_go_files()<cr>
nmap <buffer> <localleader>crr  <Plug>(go-run)
nmap <buffer> <localleader>crt  <Plug>(go-run-tab)
nmap <buffer> <localleader>crx  <Plug>(go-run-split)
nmap <buffer> <localleader>crv  <Plug>(go-run-vertical)

nmap <buffer> <localleader>ctr  <Plug>(go-test)
nmap <buffer> <localleader>ctt  <Plug>(go-alternate-edit)
nmap <buffer> <localleader>ctx  <Plug>(go-alternate-split)
nmap <buffer> <localleader>ctv  <Plug>(go-alternate-vertical)
nmap <buffer> <localleader>ctc <Plug>(go-coverage-toggle)

nmap <buffer> <localleader>dr :GoRename 
nmap <buffer> <localleader>di :GoImport 
nmap <buffer> <localleader>dI :GoInstall 

nmap <buffer> <localleader>w :w<cr>:<C-u>call <SID>build_go_files()<cr>

nmap <buffer> <localleader>l <Plug>(go-metalinter)
nmap <buffer> <localleader>i <Plug>(go-info)

nnoremap <buffer> <localleader>p :GoPlay<cr>
