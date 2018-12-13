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
  
  "--- filetype specs  {{{

  "detect filetype
  augroup FT_Detective
    autocmd!
    autocmd BufNewFile,BufReadPre *.uml,*.plantuml,*.puml setf plantuml
    autocmd BufNewFile,BufReadPre *.gmt,*.mgi             setf csv # GO terms, lists, etc
    autocmd BufNewFile,BufRead .tmux.conf*,tmux.conf*     setf tmux
    autocmd BufNewFile,BufRead iptables.*,*.iptables      setf iptables
    autocmd BufNewFile,BufRead ferm.conf*,*.ferm          setf ferm
  augroup END

  " all filetypes
  augroup filetypes
    autocmd FileType * setl fo-=cro " disable auto-commenting

    " tabs/spaces based on Syntax of languages
    autocmd FileType make         setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml         setlocal ts=2 sts=2 sw=2 expandtab fdm=indent tw=100 wrap linebreak
    autocmd FileType json         setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType python       setlocal ts=4 sts=4 sw=4 expandtab tw=99
    autocmd FileType html,xml     setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css          setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript   setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType vim          setlocal ts=2 sts=2 sw=2 expandtab fdm=marker
    autocmd FileType uml          setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType csv          setlocal cursorcolumn cursorline
  augroup END
  "}}} 

  "--- pretty stuff for programming {{{
  "augroup Parenthetcial
  "  autocmd FileType * RainbowToggle " show all parentheses in color
  "augroup END
  "augroup Indentured
  "  au! FileType * IndentLinesEnable
  "augroup END
  "}}} 

  "--- for all 'grep' commands, open in QuickFix window {{{
  autocmd QuickFixCmdPost *grep* cwindow
  "}}} 

  "--- NeoNeoNeovim {{{
  if v:version > 801
    augroup TermsConditions
      autocmd!
      au TermOpen * startinsert
      au TermOpen * setlocal nonumber norelativenumber
      highlight TermCursor ctermfg=yellow guifg=yellow
    augroup END
    let g:terminal_scrollback_buffer_size = 50000
  endif
  "}}}

endif " has("autocmd")
