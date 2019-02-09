if v:version > 801
  augroup TermsConditions
    autocmd!
    au BufNew * 
      \ if &buftype == 'terminal'
      \   | setlocal nonumber
      \   | setlocal norelativenumber
      \   | startinsert
      \ | endif
    highlight TermCursor ctermfg=yellow guifg=yellow
  augroup END
  let g:termwinscroll = 50000
endif
