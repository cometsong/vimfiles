"--- LongLineMatch function
" Toggle display lines longer than &textwidth characters (default column 80+).

function! s:LongLineMatch()
  highlight OverLength ctermbg=darkred guibg=darkred
  let s:tw_dflt = 79

  if exists('w:long_line_match')
    call matchdelete(w:long_line_match)
    unlet w:long_line_match
  elseif &textwidth > 0
    let w:long_line_match = matchadd('OverLength', '\%>'.&tw.'v.\+', -1)
  else
    let w:long_line_match = matchadd('OverLength', '\%>'.s:tw_dflt.'v.\+', -1)
  endif
endfunction

noremap <Leader>8 :call <SID>LongLineMatch()<CR>
