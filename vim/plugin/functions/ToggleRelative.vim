" TOGGLE RELATIVE OR ABSOLUTE NUMBERS
" snagged, modified from: https://github.com/trusktr/.vimrc/blob/master/.vimrc#L1694-L1737
if exists('+relativenumber')
  "set relativenumber " start with relative numbers

  func! RelativeOK()
    if(&buftype == 'terminal') ||
    \ (&filetype == 'netranger')
      return 0
    else
      return 1 " truthy
    endif
  endfunc

  function! RelativeNumberToggle()
    set relativenumber!
  endfunc

  function! NumberToggle()
    set number!
  endfunc

  function! SetRelativeNumber()
    if RelativeOK() && &number
      set relativenumber
    endif
  endfunc

  function! SetNoRelativeNumber()
    if RelativeOK() && &number
      set norelativenumber
    endif
  endfunc

  nnoremap <leader>rt :call RelativeNumberToggle()<cr>

  "augroup Relatives
  "  au!
  "  autocmd FocusLost   * :call SetNoRelativeNumber()
  "  autocmd FocusGained * :call SetRelativeNumber()
  "  autocmd InsertEnter * :call SetNoRelativeNumber()
  "  autocmd InsertLeave * :call SetRelativeNumber()
  "  autocmd CursorMoved * :call SetRelativeNumber()
  "augroup END
  " TODO: use Relative numbers for certain files automatically?

endif
