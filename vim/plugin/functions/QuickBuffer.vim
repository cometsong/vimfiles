" found at: https://github.com/igemnace/vim-config/blob/master/cfg/plugin/quick-buffer.vim

function! QuickBuffer(pattern) abort
  if empty(a:pattern)
    call feedkeys(":B \<C-d>")
  endif
  let l:globbed = '*' . join(split(a:pattern, ' '), '*') . '*'
  try
    execute 'buffer' l:globbed
  catch
    call feedkeys(':B ' . l:globbed . "\<C-d>\<C-u>B "
      \ . a:pattern)
  endtry
endfunction

command! -nargs=* -complete=buffer B call QuickBuffer(<q-args>)
