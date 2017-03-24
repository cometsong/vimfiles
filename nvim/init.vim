"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"     Cometsong's composed and composited nvim init      "
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

"--- Source Vim basic modules, append nvim-esques ---
set runtimepath+=~/.vim/
"""--- Vim Options ---
source ~/.vim/config/vim_options.vim

"""--- Here Be Functions! ---
" (need to be sourced before stuff that uses 'em)
runtime! functions/*.vim

"""--- Tabs/Indents Functions ---
call Tabspaces()

"""--- Key Mapping ---
source ~/.vim/config/key_mapping.vim

"""--- Folding ---
source ~/.vim/config/folding.vim

"""--- Autocmds ---
source ~/.vim/config/autocmds.vim

"""--- We Are Plugged In! ---
source ~/.vim/config/plugins.vim

"""--- Set Colors ---
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors
colorscheme onedark

"""--- Pythonic! ---
" let g:python_host_prog = '/usr/local/bin/python'
" let g:loaded_python_provider = 1    " To disable Python 2 support
" let g:python3_host_prog = '/usr/local/bin/python3'
" let g:loaded_python3_provider = 1   " To disable Python 3 support


"""--- Nvim Specifics ---

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1  " switch cursor to line when in insert mode, and block when not

set shada=!,'100,<100,s20,h
set shortmess=filmnrwxtToO
set history=10000
set infercase


""" vim:fdm=expr:fdl=10:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
