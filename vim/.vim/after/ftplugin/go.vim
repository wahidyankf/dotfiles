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

  function! SetGoMapping()
    nmap <localleader>bq  <bs>qq
    nmap <localleader>rr  <Plug>(go-run)
    nmap <localleader>r  <Plug>(go-run-split)
    nmap <localleader>rt  <Plug>(go-run-tab)
    nmap <localleader>rs  <Plug>(go-run-split)
    nmap <localleader>rv  <Plug>(go-run-vertical)
    nmap <localleader>rq  <bs>bqj
    nmap <localleader>rvq  <bs>bql
    nmap <localleader>rsq  <bs>bqj
    nmap <localleader>b :<C-u>call <SID>build_go_files()<CR>
    nmap <localleader>tr  <Plug>(go-test)
    nmap <localleader>tt  <Plug>(go-alternate-edit)
    nmap <localleader>ts  <Plug>(go-alternate-split)
    nmap <localleader>tv  <Plug>(go-alternate-vertical)
    nmap <localleader>tc <Plug>(go-coverage-toggle)
    nmap <localleader>l <Plug>(go-metalinter)
    nmap <localleader>i <Plug>(go-info)
    nnoremap <localleader>s :GoPlay<cr>
  endfunction


  " make newly opened buffer not folded when first opened
  " the folding is kinda meh if we use it with fold
  autocmd BufNewFile,BufRead *.go call SetGoIndentation()
  autocmd FileType go call SetGoMapping()
augroup END

