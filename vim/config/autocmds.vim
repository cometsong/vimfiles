"--- Autocmds
if has("autocmd")
  augroup filetypes
    autocmd FileType * setl fo-=cro " disable auto-commenting
  augroup END

  "--- for all 'grep' commands, open in QuickFix window
  autocmd QuickFixCmdPost *grep* cwindow

  if v:version > 801
    augroup TermsConditions
      autocmd!
      au TerminalOpen * if &buftype == 'terminal'
        \ | setlocal nonumber
        \ | setlocal norelativenumber
        \ | startinsert
        \ | endif
      highlight TermCursor ctermfg=yellow guifg=yellow
    augroup END
    let g:termwinscroll = 50000
  endif

endif " has("autocmd")
