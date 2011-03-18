""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Jamin's composited vimrc file.                        "
"                                                        "
"  Maintainer:	Jamin Leopold <jl@jaminleopold.com>      "
"  Last change:	2010 Nov 08                              "
"                                                        "
"  !Many add-ons are included in the $HOME/.vim folder!  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set term=xterm " xterm allows mouse, home/end/pgup/pgdown, etc. 

"""" Vim Options.
set backspace=2       " (bs) allow backspacing over everything in insert mode
"set viminfo='20,\"50	" (vi) read/write a .viminfo file, don't store more
                      " than 50 lines of registers
set viminfo='0,\"100, " Stay at the start of a file when opening it

set history=50    " (hi) keep 50 lines of command line history
set ruler         " (ru) show the cursor position all the time
set autoindent
set smartindent   " Indent settings (really only the cindent matters)
set cindent
set cinkeys=0{,0},:,!^F,o,O,e " See "cinkeys"; this stops "#" from indenting

set fileformat=unix " No crazy CR/LF
set listchars=tab:\ \ ,trail:� " If you do ":set list", shows trailing spaces
set mouse=a       " the mouse in VIM in a=all modes
set nojoinspaces  " One space after a "." rather than 2
set scrolloff=1   " Minimum lines between cursor and window edge
set tabstop=2     " tabs are 2 spaces
set shiftwidth=2  " Indent by 2 columns (for functions, etc).
set expandtab     " expand <Tab> to spaces in Insert mode
set showcmd       " Show partially typed commands
set showmatch     " Show parentheses matching
"set textwidth=100 " Maximum line width
set whichwrap=<,>,[,],h,l " Allows for left/right keys to wrap across lines
set nobackup      " Don't use a backup file (also see writebackup)
set writebackup   " Write temporary backup files in case we crash
set incsearch     "
set laststatus=2  " for obviousmode.vim plugin

set number        " line numbers
set numberwidth=3 " line numbers gutter width
" for line number colors, see colorscheme.vim file, LineNr

" Use color syntax highlighting.
syntax enable

" Switch syntax highlighting on, when the terminal has colors
" Also switch off highlighting the last used search pattern.
" Below is the contents of a .gvimrc file
if has("syntax") && &t_Co > 2 || has("gui_running")
  syntax on
  set nohlsearch    " Don't highlight search terms
  set guifont=Monospace\ 8
endif

" Color specification files (in $HOME/.vim/colors)
" -> colorscheme COLORSCHEME-File-Name
colorscheme dante
if v:version > 700
  set nocursorline
  set nocursorcolumn
  hi  CursorLine   cterm=underline ctermbg=NONE ctermfg=NONE guibg=NONE guifg=white
  hi  CursorColumn cterm=bold      ctermbg=NONE ctermfg=NONE guibg=NONE guifg=white
   map <silent> <Leader>curo      :set   cursorcolumn   cursorline  <CR>
  imap <silent> <Leader>curo <Esc>:set   cursorcolumn   cursorline  <CR>a
   map <silent> <Leader>curt      :set   cursorcolumn!  cursorline! <CR>
  imap <silent> <Leader>curt <Esc>:set   cursorcolumn!  cursorline! <CR>a
   map <silent> <Leader>curn      :set nocursorcolumn nocursorline  <CR>
  imap <silent> <Leader>curn <Esc>:set nocursorcolumn nocursorline  <CR>a
endif


set encoding=utf-8

" Most-Recently-Used file list:
"  !leave the default in $HOME so that diff systems have their own lists
let MRU_File = "$HOME/.vim_mru_files"


"CMD Alias plugin
"Alias bd SmartBd
"Alias mru MRU


""""""""""""""""""""""""""""""""""""""""""""""
"------- File Typing --------"
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

" On plain text files, no keyword chars, because we don't want tab completion
au BufNewFile,BufRead *.txt,*.log set iskeyword=

" On HTML files don't use indenting.
au BufNewFile,BufRead *.html set noautoindent nosmartindent nocindent


"------- Key Mapping --------"
map! <Esc>OM <c-m>
map  <Esc>OM <c-m>
map! <Esc>OP <nop>
map  <Esc>OP <nop>
map! <Esc>OQ /
map  <Esc>OQ /
map! <Esc>OR *
map  <Esc>OR *
map! <Esc>OS -
map  <Esc>OS -

" Numeric keypad setup
map! <Esc>Ol +
map! <Esc>Om -
map! <Esc>On ,
map! <Esc>Op 0
map! <Esc>Oq 1
map! <Esc>Or 2
map! <Esc>Os 3
map! <Esc>Ot 4
map! <Esc>Ou 5
map! <Esc>Ov 6
map! <Esc>Ow 7
map! <Esc>Ox 8
map! <Esc>Oy 9
map! <Esc>Oz 0

"""""""""""""""""""""""""""""""""""""""""""""""
" Options for cutting and pasting

  " CTRL-X and SHIFT-Del are Cut
  vnoremap <C-X> "+x
  vnoremap <S-Del> "+x
  " CTRL-C and CTRL-Insert are Copy
  vnoremap <C-C>      "+y
  vnoremap <C-Insert> "+y
  " CTRL-V and SHIFT-Insert are Paste
  "map <C-V>	     "+gP                    "<C-V> does Block-select!
  map <S-Insert> "+gP

  " Pasting blockwise and linewise selections is not possible in Insert and
  " Visual mode without the +virtualedit feature.  They are pasted as if they
  " were characterwise instead.  Uses the paste.vim autoload script.
  exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
  exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
  imap <S-Insert>		<C-V>
  vmap <S-Insert>		<C-V>

  " Use CTRL-Q to do what CTRL-V used to do
  noremap <C-Q>		<C-V>


"""""""""""""""""""""""""""""""""""""""""""""""
" Options for window size (gVim, console)

if has("gui_running")
  " GUI is running or is about to start.
  " Set size of gvim or macvim window.
  set lines=60 columns=150
else
  " This is console Vim.
  " let the terminal's size set the vim size
"  if exists("+lines")
"    set lines=50
"  endif
"  if exists("+columns")
"    set columns=100
"  endif
endif


"""""""""""""""""""""""""""""""""""""""""""""""
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Based on VIM tip 102: automatic tab completion of keywords
"    function InsertTabWrapper(dir)
"      let col = col('.') - 1
"      if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"      elseif "back" == a:dir
"        return "\<c-p>"
"      else
"        return "\<c-n>"
"      endif
"    endfunction
"
"    inoremap <tab> <c-r>=InsertTabWrapper("fwd")<cr>
"    inoremap <s-tab> <c-r>=InsertTabWrapper("back")<cr>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

 " In text files, always limit the width of text to 78 characters
 autocmd BufRead *.txt set tw=78

 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
"  autocmd FileType *      set formatoptions=tcql nocindent comments&
"  autocmd FileType c,cpp  set formatoptions=croql nocindent comments=sr:/*,mb:*,el:*/,://
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "   read: set binary mode before reading the file
  "   uncompress text in buffer after reading
  "  write: compress file after writing
  " append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre  *.gz set bin
  autocmd BufReadPost,FileReadPost  *.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost  *.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost  *.gz set nobin
  autocmd BufReadPost,FileReadPost  *.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost  *.gz execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost  *.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost  *.gz !gzip <afile>:r

  autocmd FileAppendPre     *.gz !gunzip <afile>
  autocmd FileAppendPre     *.gz !mv <afile>:r <afile>
  autocmd FileAppendPost    *.gz !mv <afile> <afile>:r
  autocmd FileAppendPost    *.gz !gzip <afile>:r
 augroup END

 augroup bz2
  " Remove all bz2 autocommands
  au!

  " Enable editing of bzipped files
  "   read: set binary mode before reading the file
  "   uncompress text in buffer after reading
  "  write: compress file after writing
  " append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre  *.bz2 set bin
  autocmd BufReadPost,FileReadPost  *.bz2 let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost  *.bz2 '[,']!bunzip2
  autocmd BufReadPost,FileReadPost  *.bz2 set nobin
  autocmd BufReadPost,FileReadPost  *.bz2 let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost  *.bz2 execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost  *.bz2 !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost  *.bz2 !bzip2 <afile>:r

  autocmd FileAppendPre     *.bz2 !bunzip2 <afile>
  autocmd FileAppendPre     *.bz2 !mv <afile>:r <afile>
  autocmd FileAppendPost    *.bz2 !mv <afile> <afile>:r
  autocmd FileAppendPost    *.bz2 !bzip2 <afile>:r
 augroup END

 " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
 " back to positions in previous files more than once.
 if 0
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
   autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
 endif

endif " has("autocmd")

"Toggle indenting for pasting pre-indented
nnoremap <F8> :Set invpaste paste?<CR>
set pastetoggle=<F8>
set showmode

"--- Ruby mappings ---"
map! habtm has_and_belongs_to_many :object, :join_table => "table_name", :foreign_key => "object_id"<ESC>13b

"--- Buffer Access Setup ---"
" noremap <C-left> :bprev<CR>
" noremap <C-right> :bnext<CR>
noremap <C-PageUp> :bprev<CR>
noremap <C-PageDown> :bnext<CR>

"--- NERDTreeOptions ---"
noremap <C-F12> :NERDTreeToggle<CR>
" let loaded_nerd_tree        = 0 "set to 1 to turn off plugin
let NERDTreeHijackNetrw     = 1 "opening a dir will use Nerd Tree, not built-in
let NERDChristmasTree       = 1 "make more colourful
let NERDTreeAutoCenter      = 1 "center around the cursor if it moves
let NERDTreeAutoCenterThreshold = 4 "sensitivity of auto centering
let NERDTreeCaseSensitiveSort = 0
let NERDTreeChDirMode       = 1 " [0,1,2] 0=never, 1=startup, 2=always
let NERDTreeHighlightCursorline = 1
let NERDTreeIgnore          = ['\~$'] " a list of regular expressions
" let NERDTreeBookmarksFile   = $HOME/.NERDTreeBookmarks
let NERDTreeShowBookmarks   = 1
let NERDTreeQuitOnOpen      = 0 " if NERDTree will close after opening a file
let NERDTreeShowLineNumbers = 0

"--- Git Branch Info ---"
" set statusline=%#ErrorMsg#%{GitBranchInfoString()}%#StatusLine#
" let g:git_branch_status_head_current=1
" let g:git_branch_status_ignore_remotes=1

" if has("gui_running")
"     if (v:version >= 600)
"         syntax enable
"     else
"         syntax on
"     endif
" " line numbers
"     set number
" " display invisibles
"     set list
" " search options
"     set hlsearch
"     set showmatch
"     if has("gui_win32")
" 			" windows font
"         set guifont=courier_new:h10
"     elseif has("gui_gtk2")
" 			" linux font
"         set guifont=Monospace\ 12
"     endif
"     colorscheme darkdevel
" " highlight cursor line
"     set cul
" endif


" Folding
set foldenable
" don't autofold anything
set foldlevel=100
"(This is set within Simplefold.vim)  map <unique> <silent> <Leader>f <Plug>SimpleFold_Foldsearch

