"--- MapKeys function
" Create keymaps for the specified modes.
" Mods by cometsong <benjamin at cometsong dot net>
" (based on the one from NERDcommenter)
function! MapKeys(modes, keys, target, ...)
  " Build up a map command like
  "   '[mode]noremap  <Leader>keys  target'
  " check for extra arg, work with leader as a:1, default to include preset <Leader>
  let l:leadstr = a:0 >= 1  ?  a:1  :  "<Leader>"
  " begin map construction
  let l:map_start = 'noremap ' . l:leadstr
  for l:mode in (a:modes == '') ? [''] : split(a:modes, '\zs')
    if l:mode == 'i'
      let l:target = '<C-C>' . a:target . 'a'
    else
      let l:target = a:target
    endif
    if strlen(a:keys)
      execute l:mode . l:map_start . a:keys  . ' ' . l:target
    endif
  endfor
endfunction
" usage:  call MapKeys('modeinitials', 'keys', 'target')        " for leader = <Leader>
" usage:  call MapKeys('modeinitials', 'keys', 'target', '')    " for leader = last arg (empty=none)

