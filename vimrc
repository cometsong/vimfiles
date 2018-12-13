"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"    Cometsong's composed and composited vimrc file.     "
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

"""--- (pythonx bug in some vim versions)
silent pyx 'print();'

"""--- Vim Options
runtime config/vim_options.vim

"""--- Cometsong Menu Init!
runtime config/menu_cometsong.vim

"""--- Here Be Functions!
" (need to be sourced before stuff that uses 'em)
runtime! functions/*.vim

"""--- Tabs/Indents Functions
call Tabspaces()

"""--- Key Mapping
runtime config/key_mapping.vim

"""--- Folding
runtime config/folding.vim

"""--- Autocmds
runtime config/autocmds.vim

"""--- We Are Plugged In!
runtime config/plugins.vim

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
