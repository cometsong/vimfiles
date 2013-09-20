"--- Vim Options
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
set mousemodel=popup_setpos "extend, popup or popup_setpos; what the right mouse button is used for

set nojoinspaces      " One space after a '.' rather than 2
set scrolloff=1       " Minimum lines between cursor and window edge
set showcmd           " Show partially typed commands
set nobackup          " Don't use a backup file (also see writebackup)
"set writebackup       " Write temporary backup files in case we crash

set shortmess=atoOT   " shortmessage options

set nowrap            " do not wrap lines; see also |Wrap Setup|
set textwidth=100     " max width of line of text
set formatoptions=crqnl " how Vim auto-formats text
set encoding=utf-8    " Necessary to show unicode glyphs
set t_Co=256          " Explicitly tell vim that the terminal supports 256 colors
set hidden            " keep buffer mods hidden, allow switching buffers without saving
set splitright        " set split default on the right
set equalalways       " all new windows equal size

set modeline          " Enable check for modeline
"set modelines=5       " set number of lines checked for modeline (default 5)

set showmatch         " Show parentheses matching
set matchpairs+=<:>   " append pairable chars to the default set '(:),{:},[:]'
set matchtime=3       " Show matching brackets for only 0.3 seconds

set number            " line numbers
set numberwidth=1     " line numbers minimum gutter width
"if version >= 730
"    set relativenumber  " linenumber shows num of lines apart from current line
"endif
" for line number colors, see colorscheme.vim file, LineNr

"set clipboard+=unnamed " all unnamed Yanks/dels go to clipboard, and try to come from it only!

set incsearch         " incremental searching as you type
set hlsearch          " highlight all search results

set wildmenu          " command-line completion operates in an enhanced mode
set wildmode=longest:full,list:full "Complete longest common string, then list alternatives.

set visualbell        " any bell transmogrifies to a blink

set laststatus=2      " always show status line
 
"--- Invisible characters   " If you ':set list', shows trailing spaces, etc
set listchars=tab:⇥\ ,trail:·,extends:⋯,precedes:⋯,eol:⏎
set nolist            " do not show trailinginsert mode characters

"--- persistent undo storage for files after they are closed
if has("persistent_undo")
  set undofile          " Maintain undo history between sessions
  set undodir=$HOME/.vimundos   " dir to store undo files in
endif

"--- Spell Checking  {{{
set spelllang=en_us   " default spell checker language
set spellsuggest=10   " number of spelling suggestions listed (from z= )
set nospell           " start with spell checking off (see keymap for spell! below)
"}}}

"--- Syntax highlighting  {{{
syntax enable

" Switch syntax highlighting on, when the terminal has colors
if has("syntax") && &t_Co > 2
  syntax on
  set nohlsearch      " Don't highlight search terms
endif
"}}}

"--- File Typing  {{{
filetype on
filetype plugin indent on
"}}}

"--- Color specification files (in $HOME/.vim/colors)  {{{
"    -> colorscheme COLORSCHEME-File-Name
" colorscheme dante-mods
colorscheme darkdevel
"}}}

