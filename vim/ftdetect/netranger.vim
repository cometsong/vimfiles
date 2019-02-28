au BufEnter,BufWinEnter,CursorMoved *
    \ if &filetype == 'netranger'
    \   | setlocal listchars-=extends:⋯
    \   | setlocal number
    \   | setlocal norelativenumber
    \ | endif
