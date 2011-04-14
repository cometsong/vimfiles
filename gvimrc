" -----------------------------------------------------------------------------  
" GUI VIM Settings
" -----------------------------------------------------------------------------  


" -----------------------------------------------------------------------------  
" OS Specific
if has("gui_macvim")
    set fuoptions=maxvert,maxhorz " fullscreen options (MacVim only), resized window when changed to fullscreen
    set guifont=Monaco\ 8         " set font and size
    set showtabline=1             " show tabline only if there are 2 or more.

elseif has("gui_gtk2")
    set guifont=Monaco\ 8         " set font and size

elseif has("x11")
elseif has("gui_win32")
end

" -----------------------------------------------------------------------------  
" General

set guioptions-=T             " remove toolbar
set anti " Antialias font

" Default Starting size of window
set columns=170 
set lines=65

