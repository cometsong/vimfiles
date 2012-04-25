""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    Jamin's composed and composited vimrc file.         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
"--- Vim Options.
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
set nowrap            " do not wrap lines
set encoding=utf-8
set hidden            " keep buffer mods hidden, allow switching buffers without saving
set splitright        " set split default on the right
set equalalways       " all new windows equal size

set showmatch         " Show parentheses matching
set matchpairs+=<:>   " append pairable chars to the default set '(:),{:},[:]'
set matchtime=3       " Show matching brackets for only 0.3 seconds

set number            " line numbers
set numberwidth=1     " line numbers minimum gutter width
" for line number colors, see colorscheme.vim file, LineNr

"-------------------------------------------------------------------------------
" StatusLine : 
set laststatus=2      " always show status line

" function! Set_Status_Line()
"     let CurDir = getcwd() 
"     if filereadable(CurDir.'.git') " Check for .git folder to include fugitive bits
"        set statusline=%{fugitive#statusline()}\ \ (%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})\ \ %-9.(%l,%c%V%)\ \ %<%P
"     else
"        set statusline=(%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})\ \ %-9.(%l,%c%V%)\ \ %<%P
"     endif
" endfunction 
" call Set_Status_Line()

" TODO : function remains to be repaired, debugged, implemented
set statusline=%{fugitive#statusline()}\ \ (%{strlen(&ft)?&ft:'?'},%{&fenc},%{&ff})\ \ %-9.(%l,%c%V%)\ \ %<%P

"-------------------------------------------------------------------------------
"--- Invisible characters   " If you ':set list', shows trailing spaces
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:⏎
set nolist                          " do not show trailinginsert mode characters
:noremap <Leader>i :set list!<CR> " Toggle invisible chars

"-------------------------------------------------------------------------------
"--- Color specification files (in $HOME/.vim/colors)
"    -> colorscheme COLORSCHEME-File-Name
" colorscheme dante-mods
colorscheme darkdevel
set incsearch         " incremental searching as you type
set hlsearch          " highlight all search results

"-------------------------------------------------------------------------------
"--- Syntax highlighting.
syntax enable

" Switch syntax highlighting on, when the terminal has colors
if has("syntax") && &t_Co > 2
  syntax on
  set nohlsearch      " Don't highlight search terms
endif

"-------------------------------------------------------------------------------
"--- Folding ---"
set foldenable
" don't autofold anything
set foldlevel=100
"(This is set within Simplefold.vim)  map <unique> <silent> <Leader>f <Plug>SimpleFold_Foldsearch

" key map to toggle and create/delete folds
inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <C-F9> zf

"-------------------------------------------------------------------------------
"--- File Typing
filetype on
filetype plugin on
let b:did_ftplugin = 1
au FileType * setl fo-=cro " disable auto-commenting

" On CGI files, determine type by reading in a line.
fun! CGICheck()
  let l = getline(nextnonblank(1))
  if l =~ 'php'
    set syn=php
  elseif l =~ 'perl'
    set syn=perl
  endif
endfun
au BufRead *.cgi	call CGICheck()

"-------------------------------------------------------------------------------
"---  Cursor column and line show/hide
if v:version > 700
  set nocursorline
  set nocursorcolumn
  hi  CursorLine   cterm=underline ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=underline 
  hi  CursorColumn cterm=bold      ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=bold 
   map <silent> <Leader>curt      :set   cursorcolumn!  cursorline! <CR>
  imap <silent> <Leader>curt <Esc>:set   cursorcolumn!  cursorline! <CR>a
endif

"-------------------------------------------------------------------------------
"  Autocmds
if has("autocmd")
  " The current directory is the directory of the file in the current window.
  autocmd BufEnter * :lchdir %:p:h
  "autocmd BufEnter * call Set_Status_Line()   " TODO : function remains to be implemented

  " When vimrc is edited, reload it
  autocmd! Bufwritepost vimrc source ~/.vimrc

  " On plain text files, no keyword chars, because we don't want tab completion
" commented out because we DO want word boundaries to actual word boundaries
"  au BufNewFile,BufRead *.txt,*.log set iskeyword=

  " On HTML files don't use indenting.
  au BufNewFile,BufRead *.html set noautoindent nosmartindent nocindent

  " In text files, always limit the width of text
  "autocmd BufRead *.txt,*.log set tw=100

endif " has("autocmd")

"-------------------------------------------------------------------------------
"--- Moves in Insert mode
inoremap <C-b> <C-o>0
inoremap <C-e> <C-o>$

"--- set capital Y to do same as D&C, yank to end of line ---"
nnoremap Y  y$

"-------------------------------------------------------------------------------
"--- Tabs
"function! Tabstyle(a)

function! Tabstyle_tabs()
  " Default to using 8 column tabs
  set softtabstop=8
  set shiftwidth=8
  set tabstop=8
  set noexpandtab
endfunction

function! Tabstyle_spaces()
  " Default to using 4 column indents
  set softtabstop=4
  set shiftwidth=4
  set tabstop=4
  set expandtab
endfunction

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

call Tabstyle_spaces()

"-------------------------------------------------------------------------------
" Sessions - Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,resize,localoptions,winsize
set sessionoptions-=help,options,tabpages
" see vim-session plugin options below

"-------------------------------------------------------------------------------
" Key Mapping

"--- autocomplete parenthesis, (brackets) and braces ---"
"--- surround visual content with additional spaces ---"
inoremap  <Leader>(  (  )<Left><Left>
vnoremap  <Leader>)  s()<Esc>P<Right>%
vnoremap  <Leader>(  s(  )<Esc><Left>P<Right><Right>%

inoremap  <Leader>[  [  ]<Left><Left>
vnoremap  <Leader>]  s[]<Esc>P<Right>%
vnoremap  <Leader>[  s[  ]<Esc><Left>P<Right><Right>%

inoremap  <Leader>{  {  }<Left><Left>
vnoremap  <Leader>}  s{}<Esc>P<Right>%
vnoremap  <Leader>{  s{  }<Esc><Left>P<Right><Right>%

""---  autocomplete quotes (visual and select mode) ---"
"xnoremap  <Leader>'  s''<Esc>P<Right>
"xnoremap  <Leader>"  s""<Esc>P<Right>
"xnoremap  <Leader>`  s``<Esc>P<Right>

"
"---  Make p in Visual mode replace the selected text with the "" register. ---"
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

"--- automatic tab completion of keywords ---"
"inoremap <s-tab>   <c-n>
"inoremap <s-c-tab> <c-p>
"set completeopt=longest,menuone
let g:SuperTabMappingForward  = '<s-tab>'
let g:SuperTabMappingBackward = '<s-c-tab>'

"--- Wrap Setup ---"
 noremap <Leader>w       :set wrap!<CR>
inoremap <Leader>w  <C-C>:set wrap!<CR>
 noremap <Leader>wl      :set wrap!<CR> :set linebreak!<CR>
inoremap <Leader>wl <C-C>:set wrap!<CR> :set linebreak!<CR>

"--- Pastin' Setup ---"
 noremap <Leader>p       :set paste!<CR>
inoremap <Leader>p  <C-C>:set paste!<CR>

"--- Buffer Access Setup ---"
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

"--- datetime stamps ---"
 noremap <Leader>dts       "=strftime("%F %T%z")<CR>p
inoremap <Leader>dts  <C-R>"=strftime("%F %T%z")<CR>
 noremap <Leader>ymd       "=strftime("%Y%m%d")<CR>p
inoremap <Leader>ymd  <C-R>"=strftime("%Y%m%d")<CR>
 noremap <Leader>dny       "=strftime("%d-%b-%Y")<CR>p
inoremap <Leader>dny  <C-R>"=strftime("%d-%b-%Y")<CR>

"--- time stamps ---"
 noremap <Leader>tz        "=strftime("%T%z")<CR>p
inoremap <Leader>tz   <C-R>"=strftime("%T%z")<CR>
 noremap <Leader>ts        "=strftime("%T")<CR>p
inoremap <Leader>ts   <C-R>"=strftime("%T")<CR>

"--- ignorecase ---"
 noremap <Leader>ic      :set ignorecase!<CR>
inoremap <Leader>ic <C-C>:set ignorecase!<CR>

"-------------------------------------------------------------------------------
"--- Load all Plugins using the Pathogen plugin
call pathogen#runtime_append_all_bundles()

"--- NERDTreeOptions ---"
 noremap <C-F12>          :NERDTreeToggle<CR>
inoremap <C-F12>    <C-C> :NERDTreeToggle<CR>
 noremap <Leader>nt       :NERDTreeToggle<Esc>
inoremap <Leader>nt <C-C> :NERDTreeToggle<Esc>
" let loaded_nerd_tree            = 0 " set to 1 to turn off plugin
let NERDTreeHijackNetrw         = 1 " opening a dir will use Nerd Tree, not built-in
let NERDChristmasTree           = 1 " make more colourful
let NERDTreeAutoCenter          = 1 " center around the cursor if it moves
let NERDTreeAutoCenterThreshold = 4 " sensitivity of auto centering
let NERDTreeCaseSensitiveSort   = 0 " 0=case-INsensitive sort
let NERDTreeChDirMode           = 1 " [0,1,2] 0=never, 1=startup, 2=always
let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore              = ['\~$'] " a list of regular expressions
" let NERDTreeBookmarksFile       = $HOME/.NERDTreeBookmarks
let NERDTreeShowBookmarks       = 1
let NERDTreeQuitOnOpen          = 1 " if NERDTree will close after opening a file
let NERDTreeShowLineNumbers     = 0 " no line numbers in the tree window

"--- TagList ---"
let Tlist_Inc_Winwidth = 40
 noremap <S-F11>          :TlistToggle<CR>
inoremap <S-F11> <C-C>    :TlistToggle<CR>
 noremap <Leader>tt       :TlistToggle<Esc>
inoremap <Leader>tt <C-C> :TlistToggle<Esc>
"let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD'

"--- Perl-Support ---"
let g:Perl_GlobalTemplateFile     = $HOME.'/.vim/bundle/perl-support.vim/perl-support/templates/Templates'
let g:Perl_LocalTemplateFile      = $HOME.'/.vim/misc/perl-support/Templates'
let g:Perl_CodeSnippets           = $HOME.'/.vim/misc/perl-support/codesnippets'
let g:Perl_Ctrl_j                 = 'on'
let g:Perl_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
let g:Perl_MenuHeader             = 'off'
let g:Perl_TemplateOverwrittenMsg = 'no'
let g:Perl_XtermDefaults          = '-fa courier -fs 12 -geometry 80x24'

"--- Bash-Support ---"
let g:BASH_GlobalTemplateFile     = $HOME.'/.vim/bundle/bash-support.vim/bash-support/templates/Templates'
let g:BASH_LocalTemplateFile      = $HOME.'/.vim/misc/bash-support/Templates'
let g:BASH_CodeSnippets           = $HOME.'/.vim/misc/bash-support/codesnippets'
let g:BASH_Ctrl_j                 = 'on'
let g:BASH_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
let g:BASH_MenuHeader             = 'off'
let g:BASH_TemplateOverwrittenMsg = 'no'
let g:BASH_XtermDefaults          = '-fa courier -fs 12 -geometry 80x24'

"--- bufstat ---"
let g:bufstat_debug = 1
highlight InactiveBuffer ctermfg=DarkGray ctermbg=White
let g:bufstat_inactive_hl_group = "InactiveBuffer"
highlight ActiveBuffer ctermfg=White ctermbg=blue
let g:bufstat_active_hl_group = "ActiveBuffer"
let g:bufstat_alternate_list_char = '^'
let g:bufstat_modified_list_char  = '+'
let g:bufstat_number_before_bufname   = 1
let g:bufstat_surround_buffers = '[:]'
let g:bufstat_surround_flags = ':'
let g:bufstat_join_string = ' '
let g:bufstat_sort_function = "BufstatSortNumeric"
let g:bufstat_update_old_windows = 1
map <C-Left>  <plug>bufstat_scroll_left
map <C-Right> <plug>bufstat_scroll_right

"--- indexer ---"
let g:easytags_cmd = $HOME.'/bin/ctags'
let g:indexer_indexerListFilename = '~/.indexer_files'
"let g:indexer_ctagsCommandLineOptions = ''   "default: --c++-kinds=+p+l --fields=+iaS --extra=+q
let g:indexer_ctagsJustAppendTagsAtFileSave = 1

"--- MRU ---"
let MRU_Max_Entries = 400
map <leader>r :MRU<CR>

"--- netrw ---"
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

"--- vim-session plugin settings ---"
let g:session_directory = $HOME . '/.vimsessions/'
let g:session_autosave  = 'yes'
let g:session_autoload  = 'no'
let g:session_command_aliases = 1
"--- v:this_session var does not get expanded, just used as filename
 "noremap <Leader>sst      :SaveSession v:this_session<CR>
"inoremap <Leader>sst <C-C>:SaveSession v:this_session<CR>
 "noremap <F7>             :SaveSession v:this_session<CR>
"inoremap <F7>        <C-C>:SaveSession v:this_session<CR>
 noremap <Leader>sv       :SaveSession
inoremap <Leader>sv  <C-C>:SaveSession
 noremap <Leader>so       :OpenSession
inoremap <Leader>so  <C-C>:OpenSession
 noremap <Leader>ms       :mksession! ~/.vimsessions/untitled.vim<CR>
inoremap <Leader>ms  <C-C>:mksession! ~/.vimsessions/untitled.vim<CR>
 noremap <C-F7>           :mksession! ~/.vimsessions/untitled.vim<CR>
inoremap <C-F7>      <C-C>:mksession! ~/.vimsessions/untitled.vim<CR>

"--- if v:this_session, also save marks to the same folder ( for use with bin/vims ) ---"
au VimLeave * exe 'if strlen(v:this_session) | exe "wviminfo!  " . v:this_session . ".viminfo" | endif '
au VimLeave * exe 'if strlen(v:this_session) | exe "mksession! " . v:this_session | endif '

