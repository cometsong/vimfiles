"-------------------------------------------------------------------------------
" GUI VIM Settings
"-------------------------------------------------------------------------------


"-------------------------------------------------------------------------------
"--- OS Specific {{{
if has("gui_macvim")
"    set fuoptions=maxvert,maxhorz " fullscreen options (MacVim only), resized window when changed to fullscreen
    "set guifont=Monaco\ 8           " set font and size
    set guifont=Menlo\ for\ Powerline

elseif has("gui_gtk2")
    set guifont=Monospace\ 8        " set font and size

elseif has("x11")
elseif has("gui_win32")
end
"}}}
"--------------------------------------------------------------------------------
"--- General {{{

syntax on
set nohlsearch                      " Don't highlight search terms
colorscheme metacosm                " dark and stylin colors
set guioptions+=mT                  " show menu and toolbar
set showtabline=1                   " show tabline only if there are 2 or more.
set anti                            " Antialias font

" Default Starting size of window
set columns=150 
set lines=60
"}}}

"---- Plugins {{{
" these settings are gui-specific (clearly)

"---- Headlights ---- {{
let g:loaded_headlights = 0
let g:headlights_use_plugin_menu = 1
let g:headlights_show_commands = 1
"}}

"}}}

