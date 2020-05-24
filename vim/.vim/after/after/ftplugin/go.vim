let g:go_auto_type_info = 1
let g:go_def_mode='gopls'
let g:go_diagnostics_enabled = 1
let g:go_doc_popup_window = 1
let g:go_fmt_experimental = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_info_mode='gopls'
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = "5s"

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
augroup END

nmap <buffer> <localleader>bq  <bs>qq
nmap <buffer> <localleader>rr  <Plug>(go-run)
nmap <buffer> <localleader>r  <Plug>(go-run-split)
nmap <buffer> <localleader>rt  <Plug>(go-run-tab)
nmap <buffer> <localleader>rs  <Plug>(go-run-split)
nmap <buffer> <localleader>rv  <Plug>(go-run-vertical)
nmap <buffer> <localleader>rq  <bs>bqj
nmap <buffer> <localleader>rvq  <bs>bql
nmap <buffer> <localleader>rsq  <bs>bqj
nmap <buffer> <localleader>b :<C-u>call <SID>build_go_files()<CR>
nmap <buffer> <localleader>tr  <Plug>(go-test)
nmap <buffer> <localleader>tt  <Plug>(go-alternate-edit)
nmap <buffer> <localleader>ts  <Plug>(go-alternate-split)
nmap <buffer> <localleader>tv  <Plug>(go-alternate-vertical)
nmap <buffer> <localleader>tc <Plug>(go-coverage-toggle)
nmap <buffer> <localleader>l <Plug>(go-metalinter)
nmap <buffer> <localleader>i <Plug>(go-info)
nnoremap <buffer> <localleader>s :GoPlay<cr>
