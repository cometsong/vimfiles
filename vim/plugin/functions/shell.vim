"--- Shell command
command! -nargs=*
  \ -complete=shellcmd
  \ ShellRead new
  \ | setlocal buftype=nofile bufhidden=hide noswapfile
  \ | read !<args>
cabbrev Sh ShellRead
