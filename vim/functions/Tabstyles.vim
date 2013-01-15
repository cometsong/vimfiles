"--- Tabs/Indents Functions

function! Tabstyle_tabs()    "{{{
  " Default to using 8 column tabs
  set softtabstop=8
  set shiftwidth=8
  set tabstop=8
  set noexpandtab
endfunction
amenu <silent> .300 &Cometsong.&Tab\ style\ (tabwidth\ 8)  :call Tabstyle_tabs()<CR>
"}}}

function! Tabstyle_spaces()    "{{{
  " Default to using 4 column indents
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set expandtab
endfunction
amenu <silent> .300 &Cometsong.&Tab\ style\ (spaces\ 4)  :call Tabstyle_spaces()<CR>
"}}}

" TODO Make this function work with args
function! Tabstyle_set(ts, ...)    "{{{
  if exists("a:ts")
    let tsize = a:ts
  else
    let tsize = 4
  endif

  let &softtabstop = tsize
  let &shiftwidth  = tsize
  let &tabstop     = tsize
  set expandtab
endfunction
"amenu .300 &Cometsong.&Tab\ style\.\.\.\ (custom)  :call Tabstyle_set(
"}}}

