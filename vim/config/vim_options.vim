"--- Vim Options
" This must be first, because it changes other options as a side effect.
set nocompatible      " Use Vim settings, rather then Vi settings (much better!).

"set term=xterm        " xterm allows mouse, home/end/pgup/pgdown, etc.
set viminfo='1000,f1,<1000,:500,@25,/25,s50 " default string to determine what viminfo file stores
set history=500       " keep 500 lines of command line history
set backspace=2       " allow backspacing over everything in insert mode (=indent,eol,start)
set whichwrap=<,>,[,],h,l    " Allows for left/right keys to wrap across lines

set autoindent        " Automatically set the indent of a new line (local to buffer))
set smartindent       " Indent settings (really only the cindent matters)
set cindent
set cinkeys=0{,0},:,!^F,o,O,e  " See 'cinkeys'; this stops '#' from indenting

set ruler             " show the cursor position all the time
set fileformat=unix   " No crazy CR/LF

"--- mousey   {{{
set mouse=a           " the mouse in VIM in a=all modes
set mousemodel=popup_setpos "extend, popup or popup_setpos; what the right mouse button is used for
if has('mouse_sgr')
	set ttymouse=sgr		" accepts mouse activity past 223 columns
else
	set ttymouse=xterm2
end
"}}}

set nojoinspaces      " One space after a '.' rather than 2
set scrolloff=1       " Minimum lines between cursor and window edge
set showcmd           " Show partially typed commands
set nobackup          " Don't use a backup file (also see writebackup)
"set writebackup       " Write temporary backup files in case we crash
set shortmess=atoOT   " shortmessage options
set nowrap            " do not wrap lines; see also |Wrap Setup|
set textwidth=100     " max width of line of text
set encoding=utf-8    " Necessary to show unicode glyphs
set t_Co=256          " Explicitly tell vim that the terminal supports 256 colors
set hidden            " keep buffer mods hidden, allow switching buffers without saving
set splitright        " set split default on the right
"set equalalways       " all new windows equal size
"set verbose=1         " all cmds default to verbose output
set modeline          " Enable check for modeline
set modelineexpr      " allow expressions in modeline
"set modelines=5       " set number of lines checked for modeline (default 5)

"--- formatoptions!   {{{
set formatoptions=q   " allow gq to work on comment
set formatoptions+=n  " format numbered lists using 'formatlistpat'
set formatoptions+=1  " don't break after one letter word
set formatoptions+=j  " try to remove comment when joining lines
set formatoptions+=b  " only auto-wrap if enter a blank <= &tw
"set formatoptions+=c  " auto-wrap comments
"set formatoptions+=r  " enter extends comments
"set formatoptions+=o  " 'o' and 'O' extends comments
"}}}

set showmatch         " Show parentheses matching
set matchpairs+=<:>   " append pairable chars to the default set '(:),{:},[:]'
set matchtime=5       " Show matching brackets for only 0.3 seconds

set number            " line numbers
set numberwidth=2     " line numbers minimum gutter width
"if version >= 730
"    set relativenumber  " linenumber shows num of lines apart from current line
"endif
" for line number colors, see colorscheme.vim file, LineNr

set clipboard^=unnamed,unnamedplus  " have yanks appear in system clipboard first in list

set incsearch         " incremental searching as you type
set hlsearch          " highlight all search results

set wildmenu          " command-line completion operates in an enhanced mode
set wildmode=longest:full,list:full "Complete longest common string, then list alternatives.

set visualbell        " any bell transmogrifies to a blink

set laststatus=2      " always show status line

"--- DiffOptions {{{
set diffopt=vertical,context:2,filler
"}}}

"--- Invisible characters   " If you ':set list', shows trailing spaces, etc   {{{
set listchars=tab:⊢∽,trail:⎵,extends:⋯,precedes:⋯,eol:$
if v:version > 8
  set listchars+=space:⎵,nbsp:·
  set showbreak=\ ↪\ 
endif
set nolist            " do not show special mode characters   
"}}}

"--- persistent undo storage for files after they are closed  {{{
if has('persistent_undo')
  set undofile          " Maintain undo history between sessions
  set undodir=$HOME/.vimundos   " dir to store undo files in
endif
"}}}

"--- foldoptions {{{
set foldenable
set foldlevel=0     " levels to show unfolded
set foldcolumn=1    " show folds in left column
"}}}

"--- popup completion opts  {{{
set completeopt=menu,menuone,preview
set completeopt+=noinsert,noselect
"}}}

"--- Spell Checking  {{{
set spelllang=en_us   " default spell checker language
set spellsuggest=10   " number of spelling suggestions listed (from z= )
set nospell           " start with spell checking off (see keymap for spell! below)
"}}}

"--- Syntax highlighting  {{{
syntax enable

" Switch syntax highlighting on, when the terminal has colors
if has('syntax') && &t_Co > 2
  syntax on
endif
"}}}

"--- File Typing  {{{
filetype on
filetype plugin indent on
"}}}
