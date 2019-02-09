" make the foldtext pretty
" Mods by cometsong <benjamin at cometsong dot net>
" (based on func from simplefold)
function! FoldText()
  let l:prefix    = ''
  let l:spaces    = ' '
  let l:line      = getline(v:foldstart)
  let l:folddepth = repeat('+', len(v:folddashes))
  let l:numlines  = v:foldend - v:foldstart + 1
  let l:spacefill = repeat('-', winwidth(0))
  let l:numspaces = winwidth(0) - strlen(l:line) - strlen(l:prefix)
  if l:numspaces > 0
    let l:spaces = strpart(l:spacefill, 1, l:numspaces - len(v:folddashes))
  endif
    let l:numlinefiller = repeat(' ',60)
    let l:numlinechars  = 4
    let l:numline_disp  = strpart(l:numlinefiller, 1,
      \ l:numlinechars - strlen(l:numlines))
      \ . l:numlines
  "return l:prefix . '[' . l:numline_disp . ']' . l:folddepth . ' ' . l:line . l:spaces
  return l:prefix . l:folddepth . '[' . l:numline_disp . ']' . ' ' . l:line . l:spaces
endfunction

set foldtext=FoldText()

