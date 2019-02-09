"--- Autocmds
if has("autocmd")
  augroup filetypes
    autocmd FileType * setl fo-=cro " disable auto-commenting
  augroup END

  "--- for all 'grep' commands, open in QuickFix window
  autocmd QuickFixCmdPost *grep* cwindow


endif " has("autocmd")
