"--- Tabs/Indents Functions
"TODO: combine these Tabstyle functions into one robust chooser

function! Tabspaces()    "{{{
  " Default to using 4 column indents
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
amenu <silent> .300 &Cometsong.&Tab\ spaces\ (4)  :call Tabspaces()<CR>
"}}}

function! Tabstyle(ts)    "{{{
  " Default to using 4 column indents
  if exists("a:ts")
    let tsize = a:ts
  else
    let tsize = 4
  endif

  let &softtabstop = tsize
  let &shiftwidth  = tsize
  let &tabstop     = tsize
  set noexpandtab
endfunction
amenu <silent> .300 &Cometsong.&Tab\ style\ (4)  :call Tabstyle()<CR>
"}}}
