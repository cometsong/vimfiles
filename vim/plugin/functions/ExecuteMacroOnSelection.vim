" Run macros in visual mode.
" From reddit user u/jdalbert
xnoremap @ :<C-u>call ExecuteMacroOnSelection()<cr>

function! ExecuteMacroOnSelection()
  exe ":'<,'>normal @" . nr2char(getchar())
endfunction
