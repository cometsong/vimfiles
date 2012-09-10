""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    Jamin's composed and composited vimrc file.         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
"--- Vim Options  {{{
" This must be first, because it changes other options as a side effect.
set nocompatible      " Use Vim settings, rather then Vi settings (much better!).

"set term=xterm        " xterm allows mouse, home/end/pgup/pgdown, etc.
set viminfo='1000,f1,<1000,:25,@25,/25,s50 " default string to determine what viminfo file stores
set history=50        " keep 50 lines of command line history
set backspace=2       " allow backspacing over everything in insert mode (=indent,eol,start)
set whichwrap=<,>,[,],h,l    " Allows for left/right keys to wrap across lines

set autoindent        " Automatically set the indent of a new line (local to buffer))
set smartindent       " Indent settings (really only the cindent matters)
set cindent
set cinkeys=0{,0},:,!^F,o,O,e  " See 'cinkeys'; this stops '#' from indenting

set ruler             " show the cursor position all the time
set fileformat=unix   " No crazy CR/LF
set mouse=a           " the mouse in VIM in a=all modes
set nojoinspaces      " One space after a '.' rather than 2
set scrolloff=1       " Minimum lines between cursor and window edge
set showcmd           " Show partially typed commands
set nobackup          " Don't use a backup file (also see writebackup)
"set writebackup       " Write temporary backup files in case we crash

set nowrap            " do not wrap lines; see also |Wrap Setup|
set textwidth=100     " max width of line of text
set formatoptions=crqnl " how Vim auto-formats text
set encoding=utf-8    " Necessary to show unicode glyphs
set t_Co=256          " Explicitly tell vim that the terminal supports 256 colors
set hidden            " keep buffer mods hidden, allow switching buffers without saving
set splitright        " set split default on the right
set equalalways       " all new windows equal size

set showmatch         " Show parentheses matching
set matchpairs+=<:>   " append pairable chars to the default set '(:),{:},[:]'
set matchtime=3       " Show matching brackets for only 0.3 seconds

set number            " line numbers
set numberwidth=1     " line numbers minimum gutter width
"if version >= 730
"    set relativenumber  " linenumber shows num of lines apart from current line
"endif
" for line number colors, see colorscheme.vim file, LineNr

set incsearch         " incremental searching as you type
set hlsearch          " highlight all search results

set wildmenu          " command-line completion operates in an enhanced mode
set laststatus=2      " always show status line

"--- Invisible characters   " If you ':set list', shows trailing spaces
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:⏎
set nolist                          " do not show trailinginsert mode characters

"-------------------------------------------------------------------------------
"--- Color specification files (in $HOME/.vim/colors)
"    -> colorscheme COLORSCHEME-File-Name
" colorscheme dante-mods
colorscheme darkdevel
"  }}}
"-------------------------------------------------------------------------------
"--- Cometsong Menu Init!  {{{
" TODO create menus for my schmancy plugins
aunmenu Cometsong
" all items in menu are coded with the corresponding keymaps
amenu 1114.1 &Cometsong.All\ My\ Shortcuts!  :echo "how do I show the maps specific to this menu?"<CR>

amenu .10 &Cometsong.-Views- :
" items 11-98 are view/buffer toggles
amenu .99 &Cometsong.-Submenus- :
" items 100-198 are submenus
amenu .199 &Cometsong.-Switches- :
" items 200+ are misc switches
"}}}
"-------------------------------------------------------------------------------
"--- List hotkey  {{{
noremap <Leader>i :set list!<CR> " Toggle invisible chars
amenu <silent> .900 &Cometsong.Show\ &invisible\ chars\ <Tab>i   <Leader>i   " Cometsong Menu!
"  }}}
"-------------------------------------------------------------------------------
"--- Syntax highlighting  {{{
syntax enable

" Switch syntax highlighting on, when the terminal has colors
if has("syntax") && &t_Co > 2
  syntax on
  set nohlsearch      " Don't highlight search terms
endif
"  }}}
"-------------------------------------------------------------------------------
"--- Folding  {{{
set foldenable
" don't autofold anything
set foldlevel=100
"(This is set within Simplefold.vim)  map <unique> <silent> <Leader>f <Plug>SimpleFold_Foldsearch

" key map to toggle and create/delete folds
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <C-F9> zf
"  }}}
"-------------------------------------------------------------------------------
"--- File Typing  {{{
filetype on
filetype plugin indent on
let b:did_ftplugin = 1

" On CGI files, determine type by reading in a line.
fun! CGICheck()
  let l = getline(nextnonblank(1))
  if l =~ 'php'
    set syn=php
  elseif l =~ 'perl'
    set syn=perl
  endif
endfun
au BufRead *.cgi    call CGICheck()
"  }}}
"-------------------------------------------------------------------------------
"--- Cursor column and line show/hide  {{{
if v:version > 700
  set nocursorline
  set nocursorcolumn
  hi  CursorLine   cterm=underline ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=undercurl
  hi  CursorColumn cterm=underline ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=undercurl
   noremap <silent> <Leader>curt      :set   cursorcolumn!  cursorline! <CR>
  inoremap <silent> <Leader>curt <Esc>:set   cursorcolumn!  cursorline! <CR>a
  amenu <silent> .500 &Cometsong.&Cursor\ position\ toggle<Tab>curt     <Leader>curt
endif
"  }}}
"-------------------------------------------------------------------------------
"--- Autocmds  {{{
if has("autocmd")
  " The current directory is the directory of the file in the current window.
  autocmd BufEnter * :lchdir %:p:h

  " When vimrc is edited, reload it
  function! Reload_vimrc()
    source ~/.vimrc
    source ~/.gvimrc
  endfunction
  "autocmd! Bufwritepost  vimrc  :call Reload_vimrc()
  "autocmd! Bufwritepost  gvimrc :call Reload_vimrc()
  autocmd! Bufwritepost  vimrc  :source ~/.vimrc | :source ~/.gvimrc
  autocmd! Bufwritepost  gvimrc :source ~/.vimrc | :source ~/.gvimrc

  " On plain text files, no keyword chars, because we don't want tab completion
  " commented out because we DO want word boundaries to actual word boundaries
  "  au BufNewFile,BufRead *.txt,*.log set iskeyword=
  autocmd FileType * setl fo-=cro " disable auto-commenting

  " tabs/spaces based on Syntax of languages
  autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
  autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd FileType vim setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType vim Fold {{
  autocmd BufNewFile,BufRead *.rss setfiletype xml
  " }}

  " for all 'grep' commands, open in QuickFix window
  autocmd QuickFixCmdPost *grep* cwindow

endif " has("autocmd")

"-------------------------------------------------------------------------------
"--- Tabs/Indents  {{{
"function! Tabstyle(a)

function! Tabstyle_tabs()
  " Default to using 8 column tabs
  set softtabstop=8
  set shiftwidth=8
  set tabstop=8
  set noexpandtab
endfunction
amenu <silent> .300 &Cometsong.&Tab\ style\ (tabwidth\ 8)  :call Tabstyle_tabs()<CR>

function! Tabstyle_spaces()
  " Default to using 4 column indents
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set expandtab
endfunction
amenu <silent> .300 &Cometsong.&Tab\ style\ (spaces\ 4)  :call Tabstyle_spaces()<CR>

function! Tabstyle_set(ts)
  if exists("a:ts")
    let tsize = a:ts
  else
    let tsize = 4
  endif

  let &softtabstop = tsize
  let &shiftwidth  = tsize
  let &tabstop     = tsize
  set expandtab
endfunction
"amenu .300 &Cometsong.&Tab\ style\.\.\.\ (custom)  :call Tabstyle_set(

call Tabstyle_spaces()
"  }}}
"-------------------------------------------------------------------------------
"--- Sessions - Sets what is saved when you save a session  {{{
set sessionoptions=blank,buffers,curdir,folds,resize,localoptions,winsize
set sessionoptions-=help,options,tabpages
" see vim-session plugin options below
"  }}}
"-------------------------------------------------------------------------------
"--- Key Mapping  {{{

"--- if Leader=\ then set 2xLeader=\ (to allow fast typing of the <Leader>
"---    instead of waiting for vim to catch up with you.)
inoremap <Leader><Leader> <Leader>

"--- Fast editing of vimrc
nnoremap <leader>vi   :vsplit $MYVIMRC<cr>

"--- Edit hotkey command appends current dir to :e, :sp, :vsp
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%

"--- set capital Y to do same as D&C, yank to end of line
nnoremap Y  y$

"--- for regex matching with 'very magic' to match other:wa
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap / /\v
vnoremap / /\v

"--- autocomplete (parentheses), [brackets] and {braces}
"--+ surround visual content with additional spaces
"--+ See also plugin AutoComplete toggle below.
inoremap  <Leader>(   (  )<Esc>hi
nnoremap  <Leader>(  i(  )<Esc>hi
inoremap  <Leader>)   ()<Esc>i
nnoremap  <Leader>)  i()<Esc>i
imenu <silent> .130 &Cometsong.&Delimiters.&Parentheses:\ (\ \ )<Tab>(  <Leader>(
nmenu <silent> .130 &Cometsong.&Delimiters.&Parentheses:\ (\ \ )<Tab>(  <Leader>(
imenu <silent> .130 &Cometsong.&Delimiters.&Parentheses:\ ()<Tab>)      <Leader>)
nmenu <silent> .130 &Cometsong.&Delimiters.&Parentheses:\ ()<Tab>)      <Leader>)

inoremap  <Leader>[   [  ]<Esc>hi
nnoremap  <Leader>[  i[  ]<Esc>hi
inoremap  <Leader>]   []<Esc>i
nnoremap  <Leader>]  i[]<Esc>i
imenu <silent> .130 &Cometsong.&Delimiters.&Brackets:\ [\ \ ]<Tab>[     <Leader>[
nmenu <silent> .130 &Cometsong.&Delimiters.&Brackets:\ [\ \ ]<Tab>[     <Leader>[
imenu <silent> .130 &Cometsong.&Delimiters.&Brackets:\ []<Tab>]         <Leader>]
nmenu <silent> .130 &Cometsong.&Delimiters.&Brackets:\ []<Tab>]         <Leader>]

inoremap  <Leader>{  { }<Esc>hi
nnoremap  <Leader>{ i{ }<Esc>hi
inoremap  <Leader>}  {}<Esc>i
nnoremap  <Leader>} i{}<Esc>i
imenu <silent> .130 &Cometsong.&Delimiters.&Braces:\ {\ \ }<Tab>{       <Leader>{
nmenu <silent> .130 &Cometsong.&Delimiters.&Braces:\ {\ \ }<Tab>{       <Leader>{
imenu <silent> .130 &Cometsong.&Delimiters.&Braces:\ {}<Tab>}           <Leader>}
nmenu <silent> .130 &Cometsong.&Delimiters.&Braces:\ {}<Tab>}           <Leader>}

"---  Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

"--- automatic tab completion of keywords
let g:SuperTabMappingForward  = '<s-tab>'
let g:SuperTabMappingBackward = '<s-c-tab>'

"--- Wrap Setup
set showbreak=\ …   " shows at beginning of each wrapped line
set cpoptions+=n    " sets the showbreak in between the line numbers
command! -nargs=* Wrap set wrap linebreak nolist
command! -nargs=* WrapOff set nowrap nolinebreak
 noremap <Leader>w       :set wrap!<CR>
inoremap <Leader>w  <C-C>:set wrap!<CR>a
amenu .110 &Cometsong.&Wraps.Wrap<Tab>w  :set wrap!<CR>
 noremap <Leader>l       :set linebreak!<CR>
inoremap <Leader>l  <C-C>:set linebreak!<CR>a
amenu .110 &Cometsong.&Wraps.&Linebreak<Tab>l :set linebreak!<CR>
 noremap <Leader>wl      :set wrap!<CR> :set linebreak!<CR>
inoremap <Leader>wl <C-C>:set wrap!<CR> :set linebreak!<CR>a
amenu .110 &Cometsong.&Wraps.&Wrap\ \&\ Linebreak<Tab>wl  :set wrap!<CR> :set linebreak!<CR>

"---Pastin' Setup
 noremap <Leader>p       :set paste!<CR>
inoremap <Leader>p  <C-C>:set paste!<CR>
amenu <silent> .210 &Cometsong.&Paste\ mode<Tab>p  <Leader>p

"--- Buffer Access Setup
 noremap <C-PageUp>        :bprev<CR>
inoremap <C-PageUp>   <C-C>:bprev<CR>
 noremap <C-PageDown>      :bnext<CR>
inoremap <C-PageDown> <C-C>:bnext<CR>

 noremap <C-Up>        :bprev<CR>
inoremap <C-Up>   <C-C>:bprev<CR>
 noremap <C-Down>      :bnext<CR>
inoremap <C-Down> <C-C>:bnext<CR>

 noremap <C-k>      :bprev<CR>
inoremap <C-k> <C-C>:bprev<CR>
 noremap <C-j>      :bnext<CR>
inoremap <C-j> <C-C>:bnext<CR>

"--- datetime stamps
 noremap <Leader>dts       "=strftime("%Y%m%d_%H%M%S")<CR>p
inoremap <Leader>dts   <C-R>=strftime("%Y%m%d_%H%M%S")<CR>
amenu <silent> .110 &Cometsong.&Dating.&Datetime:\ ccyymmdd_hhmiss<Tab>dts          <Leader>dts
 noremap <Leader>dtz       "=strftime("%F %T%z")<CR>p
inoremap <Leader>dtz   <C-R>=strftime("%F %T%z")<CR>
amenu <silent> .110 &Cometsong.&Dating.&Datetime:\ ccyy-mm-dd\ hh:mi:ss+tz<Tab>dtz  <Leader>dtz

"--- date stamps
 noremap <Leader>ymd       "=strftime("%Y%m%d")<CR>p
inoremap <Leader>ymd   <C-R>=strftime("%Y%m%d")<CR>
amenu <silent> .110 &Cometsong.&Dating.Date:\ ccyy-mm-dd<Tab>ymd                    <Leader>ymd
 noremap <Leader>dny       "=strftime("%d-%b-%Y")<CR>p
inoremap <Leader>dny   <C-R>=strftime("%d-%b-%Y")<CR>
amenu <silent> .110 &Cometsong.&Dating.Date:\ dd-mon-ccyy<Tab>dny                   <Leader>dny

"--- time stamps
 noremap <Leader>tz        "=strftime("%T%z")<CR>p
inoremap <Leader>tz    <C-R>=strftime("%T%z")<CR>
amenu <silent> .110 &Cometsong.&Dating.Time:\ hh:mi:ss+tz<Tab>tz                    <Leader>tz
 noremap <Leader>ts        "=strftime("%H%M%S")<CR>p
inoremap <Leader>ts    <C-R>=strftime("%T")<CR>
amenu <silent> .110 &Cometsong.&Dating.Time:\ hhmiss<Tab>ts                         <Leader>ts

"--- ignorecase
 noremap <Leader>ic      :set ignorecase!<CR>
inoremap <Leader>ic <C-C>:set ignorecase!<CR>
amenu .350 &Cometsong.&Ignore\ Case<Tab>ic  <Leader>ic

"--- operating system clipboard
" cut
noremap <Leader>,x "+x
" copy
noremap <Leader>,c "+y
" paste
noremap <Leader>,v "+p

"--- delete whole line (cf. eclipse) in insert-mode or normal
inoremap <C-d> <C-C>ddi
 noremap <C-d> dd

"--- Q=quit-all instead of going to Ex mod
noremap Q :qa<CR>

"  }}}
"-------------------------------------------------------------------------------
"--- Plugged In  {{{

"---- Define invalid plugins ---- {{

" headlights
if has("gui_running")
  let g:loaded_headlights = 0
else
  let g:loaded_headlights = 1
endif

"}}

"---- Load all Plugins using the Pathogen plugin ---- {{
call pathogen#infect()
call pathogen#helptags()
"}}

"---- Headlights ---- {{
let g:headlights_debug_mode = 1
if has("python")
python << endpython
import vim, sys
if (sys.version_info[0:2]) < (2, 6):
  vim.command("let g:loaded_headlights = 1")
else:
  vim.command("let g:headlights_use_plugin_menu = 1")
  vim.command("let g:headlights_show_commands = 1")
endpython
endif
"}}


"---- Yankring ---- {{
" custom mappings (don't screw with my Y=y$ and my ctrl-P plugin!)
function! YRRunAfterMaps()
  nnoremap Y      :<C-U>YRYankCount 'y$'<CR>
  nnoremap <c-p>  :CtrlP<CR>
endfunction
"}}

"---- NERDTreeOptions ---- {{
 noremap <Leader>nt       :NERDTreeToggle<Esc>
inoremap <Leader>nt <C-C> :NERDTreeToggle<Esc>
amenu <silent> .10 &Cometsong.&NERDTree\ Toggle<Tab>nt  <Leader>nt
" let loaded_nerd_tree            = 0 " set to 1 to turn off plugin
let NERDTreeHijackNetrw         = 1 " opening a dir will use Nerd Tree, not built-in
let NERDChristmasTree           = 1 " make more colourful
let NERDTreeAutoCenter          = 1 " center around the cursor if it moves:\ {}
let NERDTreeAutoCenterThreshold = 4 " sensitivity of auto centering
let NERDTreeCaseSensitiveSort   = 0 " 0=case-INsensitive sort
let NERDTreeChDirMode           = 1 " [0,1,2] 0=never, 1=startup, 2=always
let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore              = ['\~$'] " a list of regular expressions
" let NERDTreeBookmarksFile       = $HOME/.NERDTreeBookmarks
let NERDTreeShowBookmarks       = 1
let NERDTreeQuitOnOpen          = 1 " if NERDTree will close after opening a file
let NERDTreeShowLineNumbers     = 0 " no line numbers in the tree window
"}}

"---- TagBar ---- {{
let g:tagbar_left = 1
let g:tagbar_width = 50
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
 noremap <Leader>tt       :TagbarToggle<Esc>
inoremap <Leader>tt <C-C> :TagbarToggle<Esc>
amenu <silent> .20 &Cometsong.&Tagbar\ Toggle<Tab>tt  <Leader>tt
"let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD'
"}}

"---- Pymode ---- {{
let g:pymode_lint_hold = 0
let g:pymode_lint_onfly = 0
let g:pymode_lint_write = 0
let g:pymode_folding = 1

let g:pymode_rope_goto_def_newwin = "new"
let g:pymode_rope_vim_completion = 1
let g:pymode_rope_extended_complete = 1

let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 1
let g:pymode_syntax_print_as_function = 1

let g:pymode_utils_whitespaces = 0
"}}

"---- Perl-Support ---- {{
let g:Perl_GlobalTemplateFile     = $HOME.'/.vim/bundle/perl-support.vim/perl-support/templates/Templates'
let g:Perl_LocalTemplateFile      = $HOME.'/.vim/misc/perl-support/Templates'
let g:Perl_CodeSnippets           = $HOME.'/.vim/misc/perl-support/codesnippets'
let g:Perl_Ctrl_j                 = 'on'
let g:Perl_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
let g:Perl_MenuHeader             = 'off'
let g:Perl_TemplateOverwrittenMsg = 'no'
let g:Perl_XtermDefaults          = '-fa courier -fs 12 -geometry 80x24'
"}}

"---- Bash-Support ---- {{
let g:BASH_GlobalTemplateFile     = $HOME.'/.vim/bundle/bash-support.vim/bash-support/templates/Templates'
let g:BASH_LocalTemplateFile      = $HOME.'/.vim/misc/bash-support/Templates'
let g:BASH_CodeSnippets           = $HOME.'/.vim/misc/bash-support/codesnippets'
let g:BASH_Ctrl_j                 = 'on'
let g:BASH_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
let g:BASH_MenuHeader             = 'off'
let g:BASH_TemplateOverwrittenMsg = 'no'
let g:BASH_XtermDefaults          = '-fa courier -fs 12 -geometry 80x24'
"}}

"---- indexer ---- {{
let g:easytags_cmd = $HOME.'/bin/ctags'
let g:indexer_indexerListFilename = '~/.indexer_files'
"let g:indexer_ctagsCommandLineOptions = ''   "default: --c++-kinds=+p+l --fields=+iaS --extra=+q
let g:indexer_ctagsJustAppendTagsAtFileSave = 1
"}}

"---- MRU ---- {{
let MRU_Max_Entries = 400
map <Leader>r :MRU<CR>
amenu <silent> .40 &Cometsong.&Most\ Recently\ Used\ (MRU)<Tab>r   <Leader>r
"}}

"---- netrw ---- {{
if v:version > 702
  let g:netrw_home = "~"
  let g:netrw_ctags =$HOME.'/bin/ctags'
  let g:netrw_dirhistmax = 10
  let g:netrw_special_syntax = 1
  let g:netrw_timefmt = "%Y-%m-%d %H-%M-%S"
else " do not load netrw if ver < 7.2
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1
endif
"}}

"---- delimitMate ---- {{
let delimitMate_autoclose = 1
inoremap <Leader>dc <C-C>:DelimitMateSwitch<CR>a
 noremap <Leader>dc      :DelimitMateSwitch<CR>
amenu <silent> .100.1 &Cometsong.&Delimiters.&DelimitMateSwitch<Tab>dc   :DelimitMateSwitch<CR>
"}}

"---- vim-session plugin settings ---- {{
let g:session_directory = $HOME . '/.vimsessions/'
let g:session_autosave  = 'yes'
let g:session_autoload  = 'no'
let g:session_command_aliases = 1
"}}

"---- SaveSessionFolds ---- {{
" write viminfo file alongside sessions to also save marks
function! SaveSessionFolds()
  let g:sessname = "untitled"
  if strlen(v:this_session)
    setlocal viminfo='1000,f1,<1000,:25,@25,/25,s50
    exe "SaveSession"
  else
    :SaveSession g:sessname
  endif
  exe "wviminfo! ".v:this_session.".viminfo"
  "echo "Saved session as: ". expand(v:this_session)
endfunction
 noremap <Leader>sv       :SaveSession
 noremap <Leader>ss       :call SaveSessionFolds()<CR>
 noremap <Leader>so       :OpenSession
 noremap <Leader>rv       :exe "rviminfo! ".v:this_session.".viminfo"<CR>
 noremap <Leader>wv       :exe "wviminfo! ".v:this_session.".viminfo"<CR>

amenu <silent> .190 &Cometsong.&Sessions.&Save\ Session\ with\ Folds<Tab>ss  <Leader>ss
amenu <silent> .190 &Cometsong.&Sessions.&Open\ Session<Tab>so  <Leader>so
amenu <silent> .190 &Cometsong.&Sessions.&Save\ Session<Tab>sv  <Leader>sv
amenu <silent> .190 &Cometsong.&Sessions.&Write\ viminfo<Tab>wv  <Leader>wv
amenu <silent> .190 &Cometsong.&Sessions.&Read\ viminfo<Tab>rv  <Leader>rv

 "noremap <Leader>ms       :mksession! ~/.vimsessions/untitled.vim<CR>
"inoremap <Leader>ms  <C-C>:mksession! ~/.vimsessions/untitled.vim<CR>

"--- if v:this_session, also save marks to the same folder (for use with 'bin/vims')
"au VimLeave * exe 'if strlen(v:this_session) | exe "wviminfo!  " . v:this_session . ".viminfo" | endif '
"au VimLeave * exe 'if strlen(v:this_session) | exe "mksession! " . v:this_session | endif '
"}}

"---- CtrlP ---- {{
let b:ctrlp_working_path_mode = 1
let g:ctrlp_regexp = 1
let g:ctrlp_map = '<c-p>'
"}}

"---- Powerline ---- {{
"let g:Powerline_symbols = 'fancy'
"" PL#Theme... mod default to change order and add 'new' segments!
"call Pl#Theme#Create(
"    \ Pl#Theme#Buffer(''
"        \ , 'paste_indicator'
"        \ , 'mode_indicator'
"        \ , 'fileinfo'
"        \ , 'fugitive:branch'
"        \ , 'hgrev:branch'
"        \ , 'syntastic:errors'
"        \ , Pl#Segment#Truncate()
"        \ , 'cfi:current_function'
"        \ , Pl#Segment#Split()
"        \ , 'fileformat'
"        \ , 'fileencoding'
"        \ , 'filetype'
"        \ , 'scrollpercent'
"        \ , 'lineinfo'
"        \)
"    \)
"}}

"---- IndentGuides ---- {{
" this mapping (ig) is also the default
nnoremap <Leader>ig      :IndentGuidesToggle<CR>
inoremap <Leader>ig <C-C>:IndentGuidesToggle<CR>i
amenu .350 &Cometsong.Indent\ &Guides<Tab>ig  <Leader>ig
"}}

"---- XPTemplate ---- {{
let g:xptemplate_vars=
    \  '$author=B.Leopold (cometsong)'
    \. '&$email=benjamin (at) cometsong (dot) net'
    \. '&$author_head=AUTHOR:  '. $author
    \. '&$email_head=EMAIL:  '. $email
    "\. '&$foo=bar'
    "!! Vars other than 'author' and 'email' do not get set.
"amenu .142 &Cometsong.&XPTemplate.&Keymaps<Tab>XPT  <C-r>
"}}

"---- Menu entries for HotKeys listed... TODO bother to fix this, just for fun :)  {{
function! ListMenuItems ()
  let menu_name = "&Cometsong"
  let file_name = "~/.vimrc"
  let theleader = exists('mapleader') ? mapleader : '<ldr>'
  echo "leader: " theleader

  let menu_list = 'grep -h "' . menu_name . '" ' . file_name . '| grep -v "'. menu_name .'^\.-"'
  let menu_show = '!'. menu_list .' | sed -E "s/^.*(\' . menu_name . '\.)//" '
"  .
"     \ '| sed -e "s/^.*(\' . menu_name . ')//"' .
"     \ '| sed -e "s/\\//"'

  echo menu_list
  echo menu_show
  execute menu_show
endfunction

"}}


"}}}
"-------------------------------------------------------------------------------
