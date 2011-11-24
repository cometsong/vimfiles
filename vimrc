""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Jamin's composited vimrc file.                        "
"                                                        "
"  Maintainer : Jamin Leopold <jl@jaminleopold.com>      "
"  Last change: 2011 Oct 19                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"-------------------------------------------------------------------------------
"--- Vim Options.
" This must be first, because it changes other options as a side effect.
set nocompatible      " Use Vim settings, rather then Vi settings (much better!).

set term=xterm        " xterm allows mouse, home/end/pgup/pgdown, etc.
set viminfo='0,\"100, " Stay at the start of a file when opening it
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
if has("syntax") && &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch      " Don't highlight search terms
endif

"-------------------------------------------------------------------------------
"--- gvim ---"
if has("gui_running")
    set guioptions=m   " menu
    set guioptions+=T   " toolbar
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
  au BufNewFile,BufRead *.txt,*.log set iskeyword=

  " On HTML files don't use indenting.
  au BufNewFile,BufRead *.html set noautoindent nosmartindent nocindent

  " In text files, always limit the width of text
  "autocmd BufRead *.txt,*.log set tw=100

endif " has("autocmd")

"-------------------------------------------------------------------------------
"--- Moves in Insert mode
inoremap <C-b> <C-o>0
inoremap <C-e> <C-o>$

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

" Attempted to re-make function to accept argument of tabsize
"function! Tabstyle_set(ts)
"  if exists("a:ts")
"    let tsize = a:ts
"  else 
"    let tsize = 4
"  endif
"
"  let tsize = 4
"  let g:softtabstop = tsize
"  let g:shiftwidth  = tsize
"  let g:tabstop     = tsize
"  let s:tsize       = 4
"  set expandtab
"endfunction

call Tabstyle_spaces()

"-------------------------------------------------------------------------------
" Sessions - Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,help,options,resize,tabpages,winsize

"-------------------------------------------------------------------------------
" Key Mapping

"---  autocomplete parenthesis, (brackets) and braces
inoremap  <Leader>(  ()<Left>
vnoremap  <Leader>(  s()<Esc>P<Right>%
inoremap  <Leader>[  []<Left>
vnoremap  <Leader>[  s[]<Esc>P<Right>%
inoremap  <Leader>{  {}<Left>
vnoremap  <Leader>{  s{}<Esc>P<Right>%

"---  surround content with additional spaces
vnoremap  <Leader>)  s(  )<Esc><Left>P<Right><Right>%
vnoremap  <Leader>]  s[  ]<Esc><Left>P<Right><Right>%
vnoremap  <Leader>}  s{  }<Esc><Left>P<Right><Right>%

"---  autocomplete quotes (visual and select mode)
xnoremap  <Leader>'  s''<Esc>P<Right>
xnoremap  <Leader>"  s""<Esc>P<Right>
xnoremap  <Leader>`  s``<Esc>P<Right>

"---  Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

"---  automatic tab completion of keywords
"inoremap <s-tab>   <c-n>
"inoremap <s-c-tab> <c-p>
"set completeopt=longest,menuone
let g:SuperTabMappingForward  = '<s-tab>'
let g:SuperTabMappingBackward = '<s-c-tab>'

"--- Buffer Access Setup ---"
 noremap <F8>   :set paste!<CR>
inoremap <F8>   :set paste!<CR>

"--- Buffer Access Setup ---"
 noremap <C-PageUp>        :bprev<CR>
inoremap <C-PageUp>   <C-C>:bprev<CR>
 noremap <C-PageDown>      :bnext<CR>
inoremap <C-PageDown> <C-C>:bnext<CR>

"---datetime stamp---"
 noremap <Leader>dts      "=strftime("%F %T%z")<CR>p
inoremap <Leader>dts <C-R>"=strftime("%F %T%z")<CR>
 noremap <Leader>ts       "=strftime("%T%z")<CR>p
inoremap <Leader>ts  <C-R>"=strftime("%T%z")<CR>

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
let Tlist_Inc_Winwidth = 0
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
"let g:easytags_cmd = '/usr/local/bin/ctags'
let g:indexer_indexerListFilename = '~/.indexer_files'
"let g:indexer_ctagsCommandLineOptions = ''   "default: --c++-kinds=+p+l --fields=+iaS --extra=+q
let g:indexer_ctagsJustAppendTagsAtFileSave = 1

"--- MRU ---"
let MRU_Max_Entries = 400
map <leader>r :MRU<CR>

"--- netrw ---"
let g:netrw_home = "~"
let g:netrw_ctags ="/usr/local/bin/ctags"
let g:netrw_dirhistmax = 10
let g:netrw_special_syntax = 1
let g:netrw_timefmt = "%Y-%m-%d %H-%M-%S"

