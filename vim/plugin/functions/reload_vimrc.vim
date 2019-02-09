" When vimrc is edited, reload it
autocmd! BufWritePost $MYVIMRC so $MYVIMRC
if has("gui_running")
  autocmd! Bufwritepost $MYVIMRC  :source $MYGVIMRC
  autocmd! Bufwritepost $MYGVIMRC :source $MYVIMRC
  autocmd! Bufwritepost $MYGVIMRC :source $MYGVIMRC
endif
