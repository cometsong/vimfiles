"- Plugged In -"
""-- Disable Potentially Invalid Plugins --
"""--- python requirements ---
function! PyVeSPa()  "Py_add_virtualenv_sys_path()
" Add the python virtualenv's site-packages to vim path
Py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
  #project_base_dir = os.environ['VIRTUAL_ENV']
  #sys.path.insert(0, project_base_dir)
  #activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  #execfile(activate_this, dict(__file__=activate_this))

  def add_virtualenv_path():
      """Add virtualenv's site-packages to `sys.path`."""
      venv = os.getenv('VIRTUAL_ENV')
      #vim.cmd("echo VENV="+venv)
      if not venv:
          return
      venv = os.path.abspath(venv)
      path = os.path.join(
          venv, 'lib', 'python%d.%d' % sys.version_info[:2], 'site-packages')
      sys.path.insert(0, path)

  add_virtualenv_path()
EOF
endfunction

"""--- pythonic ---
if has('python3')
  command! -nargs=* Py python3 <args>
  let g:jedi#force_py_version = 3
  let g:ale_python_flake8_executable = 'python3'
  "let g:syntastic_python_python_exec = 'python3'
  "let g:pymode_python = 'python3'
  call PyVeSPa()
elseif has('python')
  command! -nargs=* Py python <args>
  let g:jedi#force_py_version = 2
  let g:ale_python_flake8_executable = 'python2'
  "let g:syntastic_python_python_exec = 'python2'
  "let g:pymode_python = 'python2'
  call PyVeSPa()
else
  let g:loaded_jedi = 1
  let g:loaded_youcompleteme = 1
endif

"""--- rubies ---
if !has("ruby")
  let g:find_yaml_key = 1
endif"



""-- Load all Plugins using plug.vim --
if has('nvim')
  let b:bundle_path = '~/.config/nvim/bundle'
  let b:autoloaddir = '~/.config/nvim/autoload'
else
  let b:bundle_path = '~/.vim/bundle'
  let b:autoloaddir = '~/.vim/autoload'
endif

"""--- Automatic plug.vim installation ---
if empty(glob(b:autoloaddir.'/plug.vim'))
    let auld = system("mkdir -p ".b:autoloaddir)
    let purl = system("curl -fLo ".b:autoloaddir."/plug.vim ".
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    au VimEnter * PlugInstall
endif

call plug#begin(b:bundle_path)

"""--- the basics ---
  Plug 'vim-airline/vim-airline'            " status line definition
  Plug 'vim-airline/vim-airline-themes'     " status line colorschemes
  "Plug 'cometsong/statline.vim'             " status line definition
  Plug 'yegappan/mru'                       " most recently used files
  Plug 'cometsong/minibufexpl.vim'          " buffers listed in top window
  Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }  " replace 'bufkill' with more sanity
  Plug 'kshenoy/vim-signature'              " place, toggle and display marks
  Plug 'vim-scripts/camelcasemotion'        " TraverseCamelStrings
  Plug 'cometsong/simplefold.vim'           " custom folding for some syntaxes
  Plug 'tpope/vim-surround'                 " surround strings with things
  Plug 'tpope/vim-repeat'                   " repeat many many tasks
  Plug 'vim-scripts/visualrepeat'           " cf. vim-repeat, but in visual mode
  Plug 'mbbill/undotree'                    " shows window with all previous undos
  Plug 'vim-scripts/TaskList.vim'           " list all TODOs
  Plug 'tpope/vim-abolish'                  " Abbreviation, Subvert, Coercion
  Plug 'cometsong/scratch.vim'              " create a temporary scratch buffer while running vim
  Plug 'ervandew/archive'                   " browse contents of archive files
  Plug 'Yggdroot/indentline'                " marks each indent level with vertical line instead of colors!
  Plug 'terryma/vim-multiple-cursors'       " multiple cursors within vim, for quick refactoring, correcting, amazing, etc.
  Plug 'luochen1990/rainbow'                " colors diff levels of parens
  Plug 'wesQ3/vim-windowswap'               " swap window locations
  Plug 'terryma/vim-expand-region'          " expand/contract visual selection using + and _
  "Plug 'ervandew/maximize'                  " max/minimize windows in multi-window layout

"""--- well, Search me! ---
  Plug 'haya14busa/is.vim'                  " incremental search improved - successor of incsearch.vim
  let g:is#do_default_mappings = 1

  Plug 'osyo-manga/vim-anzu'                " display search position like (2/10) for n/N commands
  map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)zz<Plug>(anzu-update-search-status-with-echo)
  map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)zz<Plug>(anzu-update-search-status-with-echo)

  Plug 'haya14busa/vim-asterisk'            " Start a * or # search from a visual block
  map *  <Plug>(asterisk-z*)zz<Plug>(is-nohl-1)
  map g* <Plug>(asterisk-gz*)zz<Plug>(is-nohl-1)
  map #  <Plug>(asterisk-z#)zz<Plug>(is-nohl-1)
  map g# <Plug>(asterisk-gz#)zz<Plug>(is-nohl-1)
  let g:asterisk#keeppos = 1

"""--- Alignment ---
  Plug 'cometsong/AlignChips.vim'           " from Dr Chip's Align plugin (vimscript #294)

"""--- commentary ---
  Plug 'scrooloose/nerdcommenter'           " comments smartly by filetype
  Plug 'cometsong/CommentFrame.vim'         " frame and full line comment styles

"""--- compilation ---
  Plug 'sheerun/vim-polyglot'               " A collection of language packs for Vim.
    "let g:polyglot_disabled = ['css']      " e.g. of disabling

  Plug 'tpope/vim-dispatch'                 " multi-lingual asynchronous make
  if has('nvim')
    Plug 'radenling/vim-dispatch-neovim'    " Adds neovim support to vim-dispatch
  endif

  Plug 'thinca/vim-quickrun'                " quick make, many filetypes
  Plug 'JarrodCTaylor/vim-shell-executor'   " execute all or selected with any shell command
  if has('nvim') || v:version > 8
    Plug 'w0rp/ale'                           " Asynchronous Lint Engine
  else
    Plug 'benekastah/neomake'
  endif

"""--- unix/shell/utils ---
  Plug 'tpope/vim-eunuch'                   " unix
  Plug 'artnez/vim-writepath'               " e some/new/path/file.foo
  Plug 'vim-utils/vim-man'                  " View man pages in vim. Grep for the man pages
  Plug 'mhinz/vim-grepper'                  " grepping flexibility
  "Plug 'benmills/vimux'                     " interact with tmux
  "Plug 'ervandew/screen'                    " simulate a split shell in vim using either gnu screen or tmux
  if has('nvim')
    Plug 'kassio/neoterm'                   " Use the same terminal for everything.
    let g:neoterm_position = 'horizontal'
    let g:neoterm_automap_keys = '<Leader>tt'
    call MapKeys('nv', 'th', ':call neoterm#close()<cr>') " hide/close terminal
    call MapKeys('nv', 'tc', ':call neoterm#kill()<cr>')  " kill current job (send <c-c>)
    " Git commands
    command! -nargs=+ Tg :T git <args>
  endif

"""--- Colorrific ---
  "Plug 'flazz/vim-colorschemes'             " plethora of colorschemes to choose from
  Plug 'junegunn/limelight.vim'             " highlights each paragraph/section of the file (puts it in the limelight)
    " Background Color name (:help cterm-colors)
    let g:limelight_conceal_ctermg = 'DarkGrey'
    let g:limelight_conceal_guifg = 'DarkGrey'
    call MapKeys('nvx', 'lm', ':Limelight!!<CR>')  " LimeLight Toggle
  "Plug 'Lokaltog/vim-distinguished'         " distinguished colors
  "Plug 'nanotech/jellybeans.vim'            " jellybeans colors
  "Plug 'mkarmona/colorsbox'                 " colorsbox color set
  "Plug 'andrwb/vim-lapis256'
  "Plug 'sickill/vim-monokai'
  Plug 'romainl/flattened'
  Plug 'altercation/vim-colors-solarized'   " solarized colorscheme
  Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'               " theme w/ airline as well
  Plug 'w0ng/vim-hybrid'                    " mix of Tomorrow-Night, Codecademy, Jellybeans, Solarized, iTerm
  Plug 'lifepillar/vim-solarized8'          " True Colors, halfway between Solarized and Flattened
  "Plug 'rakr/vim-one'                       " light and dark scheme w/ truecolors!
  "Plug 'rakr/vim-two-firewatch'             " light and dark duotone scheme that works with only 256 colors!

"""--- matches ---
  Plug 'Raimondi/delimitMate'               " autoclose {([, etc
  Plug 'vim-scripts/matchit.zip'            " show matches of words, not just chars
  Plug 'Valloric/MatchTagAlways'            " show matching x[ht]ml tags

"""--- omnicompletions galore ---
  if has('nvim') || v:version > 8 && has('python3') && has('timers')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup = 1
  else
    Plug 'Shougo/neocomplete.vim'
    let g:neocomplete#enable_at_startup = 1
  endif

"""--- snip it! ---
  if has('python') || has('python3')
      Plug 'SirVer/UltiSnips'               " preferred
  else
      Plug 'MarcWeber/vim-addon-mw-utils'
      \| Plug 'tomtom/tlib_vim'
        \| Plug 'garbas/vim-snipmate'       " backup if no python enabled
  endif
    \| Plug 'cometsong/vim-snippets'
    \| Plug 'tlavi/SnipMgr'

"""--- template files ---
  Plug 'cometsong/vim-template'             " forked set of template files

"""--- unite: search and display information from sources: files, buffers, recently used or registers ---
  if has('nvim') || v:version > 8 && has('python3')
    Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
  else
    Plug 'Shougo/unite.vim'
  endif
    "\| Plug 'Shougo/vimproc.vim'
    "\| Plug 'kopischke/unite-spell-suggest'
    "\| Plug 'Shougo/neomru.vim'
    "\| Plug 'Shougo/neoyank.vim'
    "\| Plug 'Shougo/unite-outline'
    "\| Plug 'tacroe/unite-mark'
    "\| Plug 'tsukkee/unite-tag'

"""--- File Explorer ---
  Plug 'scrooloose/nerdtree'                " Nerdy Directories
  let g:NERDTreeHijackNetrw = 1
  let g:NERDTreeSortHiddenFirst = 1
  let g:NERDTreeHighlightCursorline = 1
  let g:NERDTreeQuitOnOpen = 0
  let g:NERDTreeShowFiles = 1
  let g:NERDTreeShowBookmarks = 1
  let g:NERDTreeNaturalSort = 1
  call MapKeys('ni', '<F2>', ':NERDTreeToggle<CR>', '')

  Plug 'vim-ctrlspace/vim-ctrlspace'  " lists of stuff:  Buffer List, File List, Tab List, Workspace List, Bookmark List
  if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
  endif
  let g:CtrlSpaceUseTabline = 1
  "let g:CtrlSpaceDefaultMappingKey = "<C-space>"
  call MapKeys('n', 'cw', ':CtrlSpaceNewWorkspace <name?>') " keymap for new workspace with name (don't kill all buffers/tabs!)

"""--- versionizing ---
  Plug 'inkarkat/vcscommand.vim'            " all version controllers
  "Plug 'tpope/vim-fugitive'                 " gutsy gitsiness
  "Plug 'gregsexton/gitv'                    " git visuals
  Plug 'vim-scripts/thermometer'            " mercurial
  "Plug 'airblade/vim-gitgutter'             " show git diffs in signs column
  "Plug 'cohama/agit.vim'                    " Yet another gitk clone for Vim!

"""--- tag sale! ---
  Plug 'xolox/vim-misc'
  \| Plug 'xolox/vim-easytags'              " UpdateTags! HighlightTags
  Plug 'majutsushi/tagbar'                  " shows all tags in sidebar window

"""--- misc ---
  Plug 'arecarn/selection.vim'
  \| Plug 'arecarn/crunch.vim'              " calculator

  "--- Encryption ---
  Plug 'jamessan/vim-gnupg'                 " use gpg for file encrpytion

  "Plug 'justinmk/vim-sneak'                 " minimalist, versatile Vim motion plugin
  "Plug 'hauleth/sad.vim'                    " Search And Destroy, takes over 's' and 'S' keymaps
  "Plug 'vim-scripts/dbext.vim'              " database connections
  "Plug 'vim-scripts/QuickFixCurrentNumber'  " navigation extension on quickfix items
  "Plug 'jmcantrell/numbered.vim'             " number or renumber lines

  Plug 'vim-scripts/L9'                     " utils
  \| Plug 'cometsong/VisIncr.vim'           " Dr. Chip's Visual Increasing number,date,octal,etc columns

  "Plug 'romainl/vim-qf'                     " make the quickfix and location list windows nicer
  Plug 'wellle/targets.vim'                 " add various text objects to operate on
  Plug 'junegunn/vim-peekaboo'              " peek at all registers when starting to use one


  " debug my stuff!
  "Plug 'dahu/bisectly'                      " plugin-manager-agnostic fault-localisation tool

""-- FileTypes --
"""--- bash ---
  "Plug 'vim-scripts/bash-support.vim', {'for': 'sh'}   " WolfgangMehner bash stuff

"""--- unicode ---
  Plug 'chrisbra/unicode.vim'   " show code values, allows insertion and completion of unicode chars

"""--- python[2/3] ---
  if has('nvim') && has('python3')
    Plug 'zchee/deoplete-jedi', {'for': ['python']}
  else
    Plug 'davidhalter/jedi-vim', {'for': ['python']}  " python awesomeness
  endif
  Plug 'tmhedberg/SimpylFold', {'for': ['python']}    " python folding
  Plug 'xolox/vim-misc'
  \ | Plug 'xolox/vim-pyref',  {'for': ['python']}    " python docs
  "Plug 'jmcantrell/vim-virtualenv, {'for': ['python']}'

"""--- markdown ---
  Plug 'tpope/vim-markdown', {'for': 'md'}            " syntax highlighting, force .md = markdown
  Plug 'nelstrom/vim-markdown-folding', {'for': 'md'} " fold those markdowns!

"""--- yaml ---
  Plug 'ingydotnet/yaml-vim', {'for': 'yaml'}
  Plug 'munen/find_yaml_key', {'for': 'yaml'}

"""--- toml ---
  Plug 'cespare/vim-toml', {'for': 'toml'}

"""--- xml ---
  Plug 'othree/xml.vim', {'for': ['xml','html','xhtml','sgml']}

"""--- csv ---
  Plug 'chrisbra/csv.vim', {'for': 'csv'}             " csv display and functions

"""--- lesscss ---
  Plug 'groenewege/vim-less', {'for': 'less'}         " syntax for lesscss files
  Plug 'vitalk/vim-lesscss', {'for': 'less'}          " lessc compilation

"""--- vim ---
  Plug 'Shougo/neco-vim'                              " neocomplete for 'vim'

"""--- perl ---
  Plug 'c9s/perlomni.vim', {'for': 'perl'}            " perl omnicomplete

"""--- UML ---
  Plug 'aklt/plantuml-syntax',    {'for': ['uml','plantuml']}      " app for PlantUML !!

"""--- Sample of Unmanaged plugin (manually installed and updated) ---
  "Plug '~/my-prototype-plugin'

"""--- Add plugins to &runtimepath ---
call plug#end()

""-- Config for all Plugs --
"""--- statline ---
"let g:statline_scmfrontend = 1
"let g:statline_no_encoding_string = 'NoEnc'

"""--- Colorrific Options---
" for terminal vim:
"let g:jellybeans_use_lowcolor_black = 0
"let g:jellybeans_use_term_italics = 0
"let g:jellybeans_overrides = {
"\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
"\}
"other jellybeans_overrides... {
"\    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
"\              'ctermfg': 'Black', 'ctermbg': 'Yellow',
"\              'attr': 'italics' },
"\    'Comment': { 'guifg': 'cccccc' },
"\}
"let g:gruvbox_italic = 1 "for terminal improvement
"let g:gruvbox_number_column = 'gray'
"let g:gruvbox_italicize_strings = 1

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
let s:tmux_ver = system('%r! tmux -V | cut -d\  -f2')
if (empty($TMUX) || s:tmux_ver > 2.1)
  if has('nvim') || v:version > 74
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has('termguicolors'))
  set termguicolors
endif

" hyrbidized
"let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.

" solarized
let g:solarized_termcolors = 16
let g:solarized_contrast = 'high'
let g:solarized_visibility = 'normal'
let g:solarized_underline = 0
let g:solarized_bold = 1


"""--- vim-airline ---
let g:airline_extensions = ['branch', 'ale', 'tagbar', 'windowswap', 'ctrlspace']
let g:airline#extensions#branch#use_vcscommand = 1
let g:airline#extensions#csv#enabled = 1
let g:airline_exclude_preview = 1
let g:airline_theme = 'onedark'
let g:airline_skip_empty_sections = 1
let g:airline_powerline_fonts=0
let g:airline_left_sep=''
let g:airline_right_sep=''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
else
  let g:airline_symbols.branch = '⎇'
endif
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'NORM',
  \ 'i'  : 'INST',
  \ 'R'  : 'RPLC',
  \ 'c'  : 'CMDL',
  \ 'v'  : 'VISL',
  \ 'V'  : 'VLIN',
  \ '' : 'VBLK',
  \ 's'  : 'SLCT',
  \ 'S'  : 'SLIN',
  \ '' : 'SBLK',
  \ }

"""--- MRU --
let MRU_Max_Entries = 400
call MapKeys('n', 'mr', ':MRU<CR>')
call MapKeys('ni', '<S-F2>', ':MRU<CR>', '')
amenu <silent> .40 &Cometsong.&Most\ Recently\ Used\ (MRU)<Tab>r/S-F2   <S-F2>

"""--- NERDcommenter ---
let g:NERDCustomDelimiters = {
  \ 'vim':      { 'left': '"' },
  \ 'iptables': { 'left': '# ' },
  \ 'ferm':     { 'left': '# ' }
  \ }

"""--- TagBar ---
let g:tagbar_left = 1
let g:tagbar_width = 50
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
call MapKeys('ni', 'tb', ':TagbarToggle<CR>')
call MapKeys('ni', '<F6>', ':TagbarToggle<CR>', '')
amenu <silent> .20 &Cometsong.&Tagbar\ Toggle<Tab>tb/F6  <Leader>tb
"let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD'

"""--- EasyTags ---
let g:easytags_async = 1
"set tags=./tags;
"let g:easytags_dynamic_files = 1
let g:easytags_events = ['BufWritePost']


"""--- Python Jedi Completion ---
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 1
let g:jedi#rename_command = "<leader>pr"
let g:jedi#squelch_py_warning = 1
"let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 1
let g:jedi#show_call_signatures = 0

"""--- Python Folding ---
let g:SimpylFold_docstring_preview = 1

"""--- Perl-Support ---
"let g:Perl_GlobalTemplateFile     = $HOME.'/.vim/bundle/perl-support.vim/perl-support/templates/Templates'
"let g:Perl_LocalTemplateFile      = $HOME.'/.vim/misc/perl-support/Templates.local'
"let g:Perl_CodeSnippets           = $HOME.'/.vim/misc/perl-support/codesnippets'
"let g:Perl_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
"let g:Perl_TemplateOverwrittenMsg = 'no'
"let g:Perl_PerlTags               = 'on'
"let g:Perl_XtermDefaults          = "-fa courier -fs 10 -geometry 90x50"

"""--- Bash-Support ---
"let g:BASH_GlobalTemplateFile     = $HOME.'/.vim/bundle/bash-support.vim/bash-support/templates/Templates'
"let g:BASH_LocalTemplateFile      = $HOME.'/.vim/misc/bash-support/Templates.local'
"let g:BASH_CodeSnippets           = $HOME.'/.vim/misc/bash-support/codesnippets'
"let g:BASH_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
"let g:BASH_MenuHeader             = 'off'
"let g:BASH_TemplateOverwrittenMsg = 'no'
"let g:BASH_XtermDefaults          = '-fa courier -fs 10 -geometry 90x50'
"let g:BASH_Debugger               = 'bashdb'

"""--- Templates ---
"let g:templates_user_variables = [ ['', ''] ]
let g:templates_no_autocmd = 1
let g:username = 'Benjamin (cometsong)'
let g:email = 'benjamin(at)cometsong(dot)net'
let g:license = 'GPL v3 http://www.gnu.org/licenses/gpl-3.0.txt'

"""--- snippets, completions ---
let g:snips_author = "Benjamin Leopold (cometsong)"
let g:snips_email = g:email
let g:snips_username = g:username

let g:snippets_dir = '~/.vim/snippets'
let g:snippet_dirs = ['~/.vim/bundle/vim-snippets/snippets', '~/.vim/bundle/vim-snippets/UltiSnips']

let g:UltiSnipsEditSplit           = 'vertical'
let g:UltiSnipsSnippetsDir         = g:snippets_dir
let g:UltiSnipsSnippetDirectories  = g:snippet_dirs
let g:UltiSnipsEnableSnipMate      = '1'
"let g:UltiSnipsExpandTrigger       = '<tab>'
"let g:UltiSnipsListSnippets        = '<c-tab>'
"let g:UltiSnipsJumpForwardTrigger  = '<c-j>'
"let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

" Plugin key-mappings.
call MapKeys('ni', 'ss', '<C-c>:UltiSnipsEdit<CR>')
amenu <silent> .200 &Cometsong.&OpenSnippet\ File<Tab>ss ss

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"""--- filing ---
let g:loaded_netrwPlugin = 1
"abbr vex Vex
"call MapKeys('ni', '<F2>', ':Vex<CR>')
"amenu <silent> .10 &Cometsong.&VExplore\ Files<Tab><F2> F2

"""--- delimitMate ---
let delimitMate_autoclose = 1
call MapKeys('ni', 'dc', ':DelimitMateSwitch<CR>')
amenu <silent> .910 &Cometsong.&DelimitMateSwitch<Tab>dc   :DelimitMateSwitch<CR>


"""--- IndentGuides ---
call MapKeys('ni', 'ig', ':IndentLinesToggle<CR>')
call MapKeys('ni', 'il', ':LeadingSpaceToggle<CR>')
let g:indentLine_char = '┊'
let g:indentLine_leadingSpaceChar = '˽'
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_fileTypeExclude = ['text','sql','help','config','viminfo']

"""--- TaskList ---
" this mapping (tl) is also the default
"call MapKeys('ni', 'tl', ':TaskList<CR>')
call MapKeys('ni', '<S-F4>', ':TaskList<CR>', '')
amenu .60 &Cometsong.TaskList<Tab>tl/S-F4  <Leader>tl

"""--- UndoTree ---
call MapKeys('ni', 'ut', ':UndotreeToggle<CR>')
call MapKeys('ni', '<F4>', ':UndotreeToggle<CR>', '')
amenu <silent> .12 &Cometsong.&UndoTree\ Toggle<Tab>ut/F4  <Leader>ut

"""--- Better Rainbow Parentheses ---
call MapKeys('ni', 'rpt', ':RainbowToggle<CR>')
amenu <silent> .80 &Cometsong.&RainbowParentheses\ Toggle<Tab>rpt  <Leader>rpt

let g:rainbow_active = 1
let g:rainbow_conf = {
  \ 'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
  \ 'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
  \ 'operators': '_,_',
  \ 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
  \ 'separately': {
  \     '*': {},
  \     'tex': { 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'], },
  \     'vim': { 'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'], },
  \     'html': { 'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'], },
  \     'css': 0,
  \ }
\}

"""--- Git it to Me! ---
" agit
" TODO: agit config

" gitv
let g:Gitv_CommitStep = 20
let g:Gitv_OpenHorizontal = 1
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_OpenPreviewOnLaunch = 1
let g:Gitv_DoNotMapCtrlKey = 1
call MapKeys('nv', 'gv', ':Gitv --all<CR>')
amenu <silent> .192 &Cometsong.&Git.&Git\ Repo\ Log\ Toggle<Tab>gv  <Leader>gv
call MapKeys('nv', 'gV', ':Gitv! --all<CR>')
amenu <silent> .192 &Cometsong.&Git.&Git\ Repo\ File\ Log\ Toggle<Tab>gV  <Leader>gV

" fugitive
call MapKeys('ni', 'gs', ':Gstatus<CR>')
amenu <silent> .192 &Cometsong.&Git.&Git\ Status<Tab>gs  <Leader>gs
call MapKeys('ni', 'gd', ':Gdiff<CR>')
amenu <silent> .192 &Cometsong.&Git.&Git\ Diff<Tab>gd  <Leader>gd

" GitGutter
"let g:gitgutter_enabled = 0
"let g:gitgutter_realtime = 0
"let g:gitgutter_eager = 0
"let g:gitgutter_highlight_lines = 1

"""--- Crunch Calc ---
let g:util_debug = 0

"""--- ScratchToggle ---
call MapKeys('ni', 'sct', ':ScratchToggle<CR>')
amenu <silent> .61 &Cometsong.ScratchToggle<Tab>sct  <Leader>sct  " Cometsong Menu!

"""--- unite ---
let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 40

call MapKeys('ni', 'ub', ':UniteWithBufferDir file<CR>')
call MapKeys('ni', '<S-F3>', ':UniteWithBufferDir file<CR>', '')
call MapKeys('ni', 'uf', ':Unite file<CR>')
call MapKeys('ni', 'ur', ':Unite register<CR>')
call MapKeys('ni', '<F3>', ':Unite register<CR>', '')

amenu <silent> .13 &Cometsong.&Unite:\ registers<Tab>F3  <F3>
amenu <silent> .13 &Cometsong.&Unite:\ Files\ BufferDir<Tab>S-F3  <S-F3>
amenu <silent> .40 &Cometsong.&Unite:\ Most\ Recently\ Used<Tab>um  um

let g:deoplete#enable_at_startup = 1

"""--- peekaboo registers QuickFixes ---
let g:peekaboo_delay = 5
let g:peekaboo_compact = 0
let g:peekaboo_window	= "vert bo 50new"

"""--- qf QuickFixes ---
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0

"""--- QuickRun ---
call MapKeys('niv', 'qr', ':QuickRun<CR>')
amenu <silent> .66 &Cometsong.QuickRun\ file<Tab>qr   <Leader>qr   " Cometsong Menu!

"""--- Dispatch ---
call MapKeys('nv', 'ds', ':Dispatch<CR>')
call MapKeys('nv', 'dm', ':Make<CR>')
amenu <silent> .66 &Cometsong.Dispatch\ file<Tab>dm   <Leader>dm   " Cometsong Menu!

"""--- NeoMake ---
let g:neomake_open_list = 0
let g:neomake_list_height = 15

let g:neomake_yaml_yamllint_maker = {
\ 'exe':  'yamllint',
\ 'args': '-c $HOME/.yamllint',
\ 'cwd':  '%:p:h'
\ }

let g:neomake_sh_maker = {
\ 'exe':  'shellcheck',
\ 'args': '-x -f gcc',
\ 'cwd':  '%:p:h'
\ }

call MapKeys('ni', '<F5>', ':Neomake<CR>', '')
amenu <silent> .66 &Cometsong.&Neomake<Tab>F5  <F5>

"""--- ALE ---
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_sign_error = 'E>'
let g:ale_sign_warning = 'w>'

let g:ale_python_flake8_args = '--max-line-length=100'
let g:ale_yaml_yamllint_args = '-c $HOME/.yamllint'

nmap <silent> ]N <Plug>(ale_previous_wrap)
nmap <silent> ]n <Plug>(ale_next_wrap)


"""--- CSV ---
let g:csv_table_leftalign = 1
"""--- LessCss ---
let g:lesscss_toggle_key = "<leader>lc"
"""--- Signature Marks ---
let g:SignatureMarkLineHL = "'Exception'"


"""--- MiniBufExplorer ---
" Maintain MBE window position when moving other windows (from:weynhamz/vim-plugin-minibufexpl/issues/31)
let g:miniBufExplorerAutoStart = 1
map <C-w>H <C-w>H:MBEOpen!<CR>
map <C-w>J <C-w>J:MBEOpen!<CR>
map <C-w>K <C-w>K:MBEOpen!<CR>
map <C-w>L <C-w>L:MBEOpen!<CR>

"""--- Sayonara ---
call MapKeys('nv', 'bd', ':Sayonara!<CR>')
call MapKeys('nv', 'bD', ':Sayonara<CR>')
cabbr BD Sayonara!


""" vim:fdm=expr:fdl=1:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
