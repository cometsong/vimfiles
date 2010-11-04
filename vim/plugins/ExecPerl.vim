" Plugin Information {{{
"=============================================================================
" File:		ExecPerl.vim
" Author:	Scott D. Barker (scott@redrubberball.net)
" Last Change:	2002 Apr 26
" Version:	1.0
" Purpose:	Provides the following commands:
"
" 			:ExecPerl script_name
" 				This will execute script_name using the perl
" 				interpreter.
"
" 			:ExecPerlMore
" 				This will execute script_name using the perl
" 				interpreter.  If the output would scroll past the end
" 				of the screen, execution pauses and waits for a
" 				keystroke before continuing.
"
" 			:ExecPerlDump
" 				This will ask you for an output file and then
" 				execute script_name using the perl interpreter.  The
" 				output from the script is dumped to the file that you
" 				entered when you were prompted.  You may press enter
" 				instead of entering a file name to accept the default
" 				filename.
"
"
"
" Comments:	You'll probably want to set g:ExecPerl_df to the name of the file
"           	that you want to be the default for ExecPerlDump, and you'll
"           	definitely want to set g:ExecPerl_perlpath to the path of your
"           	perl interpreter.  But you most likely knew that anyway.
"
"           	Also, The following keys are mapped by default.  You'll have to
"           	comment them if you don't want this behavior:
"
"	    	<F5>:    ExecPerl the current file being edited
"	    	<C-F5>:  ExecPerlMore the current file being edited
"	    	<S-F5>:  ExecPerlDump the current file being edited
"
"           	Questions/Comments, feel free to e-mail me, or IM one of the
"           	following:
"           			AIM:  The5ETank
"           			ICQ:  1034986
"           			MSN:  sdbarker99@hotmail.com
"           			Y!:   sdbarker_99
"           			IRC:  [Del]@irc.dal.net/#perl
"
"		Thanks,
"
"		-Scott
"
"=============================================================================
"}}}

" Init Plugin & Set Var Defaults {{{
if exists("loaded_ExecPerl")
	finish
endif

let loaded_ExecPerl=1

if !exists("g:ExecPerl_df")
	" Default filename used for ExecPerlDump
	let g:ExecPerl_df = 'output.txt'
endif

if !exists("g:ExecPerl_perlpath")
	" Path to Perl
	let g:ExecPerl_perlpath = '/usr/bin/perl'
endif
" }}}

" Setup Commands {{{
if !exists(':ExecPerl')
	command! -n=? -complete=file ExecPerl :call s:ExecPerl('<args>')
	command! -n=? -complete=file ExecPerlMore :call s:ExecPerlMore('<args>')
	command! -n=? -complete=file ExecPerlDump :call s:ExecPerlDump('<args>')
endif " }}}

" Setup Key Mappings {{{
map <F5> :ExecPerl "%"<CR>
map <C-F5> :ExecPerlMore "%"<CR> 
map <S-F5> :ExecPerlDump "%"<CR>  " }}}

" ExecPerl Function {{{
function! s:ExecPerl(script)
	if a:script != ""
		let perl_script = a:script
	else
		let perl_script = "%"
	endif

	execute '!'.g:ExecPerl_perlpath.' '.perl_script
endfunction
" }}}

" ExecPerlMore Function{{{
function! s:ExecPerlMore(script)
	if a:script != ""
		let perl_script = a:script
	else
		let perl_script = "%"
	endif
	execute '!'.g:ExecPerl_perlpath.' '.perl_script.' | more'
endfunction
" }}}

" {{{ ExecPerlDump Function
function! s:ExecPerlDump(script)
	if a:script != ""
		let perl_script = a:script
	else
		let perl_script = "%"
	endif

	let filename = input('Enter the filename to capture output to: ','')
	if filename == ""
		let filename = g:ExecPerl_df
	endif
	silent execute '!'.g:ExecPerl_perlpath.' '.perl_script.' > ' . filename
	unlet filename
endfunction
" }}}
