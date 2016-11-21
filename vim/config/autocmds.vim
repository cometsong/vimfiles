"--- Autocmds
if has("autocmd")

  " When vimrc is edited, reload it  {{{
  augroup AutoReloadVimRC
    au!
    " automatically reload vimrc when it's saved
    au BufWritePost $MYVIMRC so $MYVIMRC
    if has("gui_running")
      autocmd! Bufwritepost $MYVIMRC  :source $MYGVIMRC
      autocmd! Bufwritepost $MYGVIMRC :source $MYVIMRC
      autocmd! Bufwritepost $MYGVIMRC :source $MYGVIMRC
    endif
  augroup END
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
  "autocmd VimEnter * RainbowParenthesesToggleAll
  "autocmd Syntax   * RainbowParenthesesLoadRound
  "autocmd Syntax   * RainbowParenthesesLoadSquare
  "autocmd Syntax   * RainbowParenthesesLoadBraces
  " off for text files
  "autocmd VimEnter text RainbowParenthesesToggleAll
  "autocmd VimEnter yaml RainbowParenthesesToggleAll

  " tabs/spaces based on Syntax of languages
  autocmd FileType make         setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml         setlocal ts=2 sts=2 sw=2 expandtab fdm=indent tw=100 wrap linebreak
  autocmd FileType json         setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python       setlocal ts=4 sts=4 sw=4 expandtab tw=99
  autocmd FileType html,xml     setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css          setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript   setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType vim          setlocal ts=2 sts=2 sw=2 expandtab fdm=marker
  autocmd FileType *            RainbowParenthesesActivate
  "}}} 


  "--- pretty stuff for programming
  augroup Indentured
        "\ yaml,python,html,xml,java,javascript,markdown,perl,sh
    au! FileType *
        \ IndentGuidesEnable
    au! FileType
        \ text,css,sql,help,config,viminfo
        \ IndentGuidesDisable
  augroup END

  "--- for all 'grep' commands, open in QuickFix window {{{
  autocmd QuickFixCmdPost *grep* cwindow
  "}}} 

endif " has("autocmd")

