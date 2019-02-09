"--- map#Keys function

" Create keymaps to targets for specified modes. {{{
"
" By Benjamin Leopold <cometsong> (grown from orig in NERDcommenter)
"
" usage:
"   Basic call
"    call map#Keys('n', 'w', ':set wrap!<cr>')
"   Call with leader = arg:1 (''=None)
"    call map#Keys('n', 'keys', 'target', ',')
"   Call with no leader and not silent
"    call map#Keys('n', 'keys', 'target', '', '')
"   Call with 'B' in modes for buffer-specific mapping
"    call map#Keys('nvB', 'keys', 'target', '', '')
"
" map#Keys Option Defaults :
"    g:map_keys_leader = '<Leader>'
"    g:map_keys_silent = '<silent>'
"    g:map_keys_options = ''
"       Set to other mapping options, e.g. <nowait> or <buffer>
"       For single map Buffer-specific, include 'B' in the mode initials arg.
"    g:map_keys_noremap = 'nore' " set to '' if only 'map' desired
" }}}

" Set Default values of global options{{{
let s:map_keys_defaults = [
  \ ['leader',  '<Leader>'],
  \ ['silent',  '<silent>'],
  \ ['options', ''],
  \ ['noremap', 'nore'],
  \ ]
"}}}

""" generate script variables from global options if set, else 'default' "{{{
fun! s:set_map_option_vals()
  for [opt, default] in s:map_keys_defaults
    "silent unlet s:map_{opt}
    let s:map_{opt} = get(g:, 'map_keys_'.opt, default)
  endfor
endf "}}}

" map keys in specified modes to target, using g: map options "{{{
" e.g.  '[mode]noremap [silent] <leader>keys target'
fun! map#Keys(modes, keys, target, ...) abort
  call s:set_map_option_vals() " create s:vars with defaults if no g:opts set
  "echo s:list_vars('s:',s:)

  " convert a:modes string -> list(modes)
  let l:modes = (a:modes == '') ? [''] : split(a:modes, '\zs')

  " check for extra args: a:1=leader, a:2=not-silent
  let l:leader = a:0 >= 1  ?  a:1  :  s:map_leader
  let l:silent = a:0 >= 2  ?  a:2  :  s:map_silent

  let l:buffer = ''
  if index(l:modes, 'B') >= 0
    let l:buffer = '<buffer>'
    call filter(l:modes, 'v:val != "B"')
  endif

  "TODO: Test duplicate words in map_options:
  let l:map_options = ' '.s:map_options.' '.l:silent.' '.l:buffer.' '
  "echo s:list_vars('l:',l:)

  " begin map construction
  for mode in l:modes
    let l:target = a:target
    " if insert mode:
    if mode == 'i'
      let l:target = '<C-C>' . a:target . 'a'
    endif

    exec mode.s:map_noremap.'map'
      \. l:map_options
      \. l:leader
      \. a:keys
      \. ' '
      \. l:target
  endfor
endf "}}}

fun! s:list_vars(dictname, dct)
  echo 'List of "'.a:dictname.'" vars:'
  for [k,v] in items(a:dct)
    echo printf("  %s%-18s : '%s'\n", a:dictname, k, v)
  endfor
endf

"call map#Keys('nv', 'so', ':sort', ',')
call map#Keys('nvB', 'so', ':sort', ',')

" vim:tw=78:fdm=marker:
