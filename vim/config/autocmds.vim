"--- Autocmds
if has("autocmd")

  " When vimrc is edited, reload it  {{{
  autocmd! Bufwritepost vimrc  source $MYVIMRC
  if has("gui_running")
    autocmd! Bufwritepost vimrc  source $MYGVIMRC
    autocmd! Bufwritepost gvimrc source $MYGVIMRC
  endif
  "}}} 
  
  " filetype specs  {{{

  "detect filetype
  augroup filetypedetect
    au BufNewFile,BufRead .tmux.conf*,tmux.conf*  setf tmux
    au BufNewFile,BufRead iptables.*,*.iptables   setf iptables
    au BufNewFile,BufRead ferm.conf*,*.ferm       setf ferm
  augroup END

  " all filetypes
  autocmd FileType * setl fo-=cro " disable auto-commenting

  " RainbowParentheses
  autocmd VimEnter * RainbowParenthesesToggleAll
  autocmd Syntax   * RainbowParenthesesLoadRound
  autocmd Syntax   * RainbowParenthesesLoadSquare
  autocmd Syntax   * RainbowParenthesesLoadBraces
  " off for text files
  autocmd VimEnter text RainbowParenthesesToggleAll

  " tabs/spaces based on Syntax of languages
  autocmd FileType make         setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml         setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python       setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType html         setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css          setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript   setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType vim          setlocal ts=2 sts=2 sw=2 expandtab fdm=marker
  "}}} 

  "--- for all 'grep' commands, open in QuickFix window {{{
  autocmd QuickFixCmdPost *grep* cwindow
  "}}} 

endif " has("autocmd")

