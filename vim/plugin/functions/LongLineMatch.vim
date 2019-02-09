"--- LongLineMatch function
" Toggle display lines longer than &textwidth characters (default column 80+).

function! s:LongLineMatch()
  highlight OverLength ctermbg=darkred guibg=darkred
  let s:twidth = 79

  if exists('w:long_line_match')
    call matchdelete(w:long_line_match)
    unlet w:long_line_match
  endif
  if &textwidth > 0
    let s:twidth = &tw
  endif
  let w:long_line_match = matchadd('OverLength', '\%>'.s:twidth.'v.\+', -1)
endfunction

noremap <Leader>8 :call <SID>LongLineMatch()<CR>
