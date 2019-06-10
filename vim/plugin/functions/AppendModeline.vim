" Inspired by http://vim.wikia.com/wiki/Modeline_magic#Adding_a_modeline

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:sw = &shiftwidth
  if &shiftwidth == &tabstop
    let l:sw=0
  endif
  let l:modeline = printf(" vim: set ft=%s ts=%d sw=%d tw=%d %set fdm=%s:",
      \ &filetype, &tabstop, l:sw, &textwidth, &expandtab ? '' : 'no', &foldmethod)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction

nnoremap <silent> <Leader>ml :call AppendModeline()<CR>
