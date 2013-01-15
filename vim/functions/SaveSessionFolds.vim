"---- SaveSessionFolds ----
" Created by cometsong <benjamin at cometsong dot net>
" as accompanying function to session.vim  ( http://github.com/xolox/vim-session )
function! SaveSessionFolds()
  " write viminfo file alongside sessions to also save marks
  let s:sessname = "untitled"
  if strlen(v:this_session)
    setlocal viminfo='1000,f1,<1000,:25,@25,/25,s50
    exe "SaveSession"
  else
    :SaveSession s:sessname
  endif
  exe "wviminfo! ".v:this_session.".viminfo"
  "echo "Saved session info as: ". expand(v:this_session)
endfunction

