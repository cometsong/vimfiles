"-------------------------------------------------------------------------------
" GUI VIM Settings
"-------------------------------------------------------------------------------


"-------------------------------------------------------------------------------
"--- OS Specific
if has("gui_macvim")
"    set fuoptions=maxvert,maxhorz " fullscreen options (MacVim only), resized window when changed to fullscreen
    set guifont=Monaco\ 8           " set font and size

elseif has("gui_gtk2")
    set guifont=Monospace\ 8        " set font and size

elseif has("x11")
elseif has("gui_win32")
end

"--------------------------------------------------------------------------------
"--- General

syntax on
set nohlsearch                      " Don't highlight search terms
colorscheme metacosm                " dark and stylin colors
set guioptions+=mT                  " show menu and toolbar
set showtabline=1                   " show tabline only if there are 2 or more.
set anti                            " Antialias font

" Default Starting size of window
set columns=150 
set lines=75

"--- bufstat ---"
let g:bufstat_debug = 1
highlight InactiveBuffer guifg=#444444 guibg=#FFFFFF
let g:bufstat_inactive_hl_group = "InactiveBuffer"
highlight ActiveBuffer   guifg=#FFFFFF guibg=#000044
let g:bufstat_active_hl_group = "ActiveBuffer"
let g:bufstat_alternate_list_char = '^'
let g:bufstat_modified_list_char  = '+'
let g:bufstat_bracket_around_bufname  = 1
let g:bufstat_number_before_bufname   = 1
noremap <c-left>  <plug>bufstat_scroll_left
noremap <c-right> <plug>bufstat_scroll_right

