" TOGGLE RELATIVE OR ABSOLUTE NUMBERS
" snagged, modified from: https://github.com/trusktr/.vimrc/blob/master/.vimrc#L1694-L1737
if exists('+relativenumber')
  set relativenumber " start with relative numbers

  function! NumberToggle()
    if(&relativenumber == 1)
      set norelativenumber
    else
      set relativenumber
    endif
  endfunc

  function! SetRelativeNumber()
    if(&buftype == 'terminal')
      return
    endif

    if(&number)
      set relativenumber
    endif
  endfunc

  function! SetNoRelativeNumber()
    if(&buftype == 'terminal')
      return
    endif

    if(&number)
      set norelativenumber
    endif
  endfunc

  nnoremap <leader>nt :call NumberToggle()<cr>
  " TODO: Use a function to detect NeoVim terminal buffers and
  " not do anything in those buffers.
  autocmd FocusLost   * :call SetNoRelativeNumber()
  autocmd FocusGained * :call SetRelativeNumber()
  autocmd InsertEnter * :call SetNoRelativeNumber()

  " doesn't work in NeoVim 0.1.2
  autocmd InsertLeave * :call SetRelativeNumber()
  " workaround:
  autocmd CursorMoved * :call SetRelativeNumber()

endif

