" found on: https://vim.fandom.com/wiki/Disable_F1_built-in_help_key

noremap <F1> :call MapF1()<CR>

function! MapF1()
  if &buftype == "help"
    exec 'quit'
  else
    exec 'help'
  endif
endfunction

