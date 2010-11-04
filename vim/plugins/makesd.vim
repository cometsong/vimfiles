" ========================================================================== "
" makesd/makecsd by Chase Venters <chase.venters@chaseventers.com>           "
" Public Domain.                                                             "
" ========================================================================== "

function _makesd(start_line, end_line, line_width, linechar, str)
	let middle_sz=a:line_width - len(a:start_line . a:end_line)
	let mkr=a:start_line . repeat(a:linechar, middle_sz) . a:end_line
	let slen=len(a:str)
	let title_left_sz=((middle_sz / 2) - (slen / 2))
	let title_line=a:start_line . repeat(a:linechar, title_left_sz) . a:str
	let title_right_sz=a:line_width - len(title_line) - len(a:end_line)
	let title_line=title_line . repeat(a:linechar,title_right_sz) . a:end_line

	call append(line('.'), mkr)
	call append(line('.'), title_line)
	call append(line('.'), mkr)
endfunction

function _cmd_makecsd(str)
	call _makesd('/* ', ' */', 78, '=', ' ' . a:str . ' ')
endfunction

function _cmd_makesd(str)
	call _makesd('# ', ' #', 78, '=', ' ' . a:str . ' ')
endfunction

command! -nargs=+ Makecsd :call _cmd_makecsd(<args>)
command! -nargs=+ Makesd :call _cmd_makesd(<args>)

