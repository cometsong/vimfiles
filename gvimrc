"-------------------------------------------------------------------------------
"-------------------------------------------------------------------------------
" GUI VIM Settings
"-------------------------------------------------------------------------------


"-------------------------------------------------------------------------------
"--- OS Specific {{{1
if has("gui_macvim")
    "set fuoptions=maxvert,maxhorz   " fullscreen options (MacVim only), resized window when changed to fullscreen
    "set guifont=Monaco\ 8           " set font and size
    set guifont=Menlo\ for\ Powerline

elseif has("gui_gtk2")
    set guifont=Monospace\ 8        " set font and size

elseif has("x11")
elseif has("gui_win32")
end
"}}}1
"--------------------------------------------------------------------------------
"--- General {{{1

syntax on
set hlsearch                        " Highlight search terms
colorscheme metacosm                " dark and stylin colors
set guioptions+=mT                  " show menu and toolbar
set guioptions-=e                   " never show tabline
set showtabline=0                   " never show tabline
set anti                            " Antialias font

" Default Starting size of window
set columns=120 
set lines=60
"}}}1

"---- Plugins {{{1
" these settings are gui-specific (clearly)

"}}}1
