""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    Cometsong's composed and composited vimrc file.     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--- Vim Options
source ~/.vim/config/vim_options.vim

"--- Cometsong Menu Init!
source ~/.vim/config/menu_cometsong.vim

"--- Here Be Functions!
" (need to be sourced before stuff that uses 'em)
runtime! functions/*.vim

"--- Tabs/Indents Functions
call Tabspaces()

"--- Key Mapping
source ~/.vim/config/key_mapping.vim

"--- Folding
source ~/.vim/config/folding.vim

"--- Autocmds
source ~/.vim/config/autocmds.vim

"--- Save My Sessions
"source ~/.vim/config/sessions.vim
" test using session manager plugin

"--- We Are Plugged In!
source ~/.vim/config/plugins.vim

" vim: ft=vim fdm=marker
