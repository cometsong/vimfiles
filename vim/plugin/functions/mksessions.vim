" mksession funcs and commands
func! MkSession(session_name, ...)
  
wa<Bar>
exe "mksession! " . v:this_session<CR>
endfunc
