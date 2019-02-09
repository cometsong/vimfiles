function! ShowCmdMsg(cmd)
  " get cmd resulting mesg, subst all newlines, echo to screen
  " if only one line of messages, does not give "Press Enter..." message
  let statusmsg = ''
  redir => statusmsg
  silent execute(a:cmd)
  redir END
  if !empty(statusmsg)
    echo substitute(statusmsg, '\n', ' ', 'g')
  endif
endfunction
