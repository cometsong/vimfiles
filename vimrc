"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"    Cometsong's composed and composited vimrc file.     "
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

"""--- Vim Options
source ~/.vim/config/vim_options.vim

"""--- Cometsong Menu Init!
source ~/.vim/config/menu_cometsong.vim

"""--- Here Be Functions!
" (need to be sourced before stuff that uses 'em)
runtime! functions/*.vim

"""--- Tabs/Indents Functions
call Tabspaces()

"""--- Key Mapping
source ~/.vim/config/key_mapping.vim

"""--- Folding
source ~/.vim/config/folding.vim

"""--- Autocmds
source ~/.vim/config/autocmds.vim

"""--- Save My Sessions
"source ~/.vim/config/sessions.vim
" test using session manager plugin

"""--- We Are Plugged In!
source ~/.vim/config/plugins.vim

"""--- Set Colors
"colorscheme jellybeans
"colorscheme gruvbox
"colorscheme hybrid
"colorscheme one
colorscheme solarized
if (has('termguicolors'))
  colorscheme solarized8_dark_high
endif
set background=dark

""" vim:fdm=expr:fdl=1:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
