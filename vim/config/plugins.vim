"- Plugged In -"

"""--- Load all Plugins using plug.vim ---
let b:bundle_path = '~/.vim/bundle'
let b:autoloaddir = '~/.vim/autoload'

"""--- Automatic plug.vim installation ---
if empty(glob(b:autoloaddir.'/plug.vim'))
    let auld = system("mkdir -p ".b:autoloaddir)
    let purl = system("curl -fLo ".b:autoloaddir."/plug.vim ".
      \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim")
    au VimEnter * PlugInstall
endif

call plug#begin(b:bundle_path)


"""--- vim-airline ---
  Plug 'vim-airline/vim-airline'            " status line definition
  Plug 'vim-airline/vim-airline-themes'     " status line colorschemes
  let g:airline_extensions = ['branch', 'ale', 'tagbar', 'windowswap', 'ctrlspace']
  let g:airline#extensions#branch#use_vcscommand = 1
  let g:airline#extensions#csv#enabled = 1
  let g:airline#extensions#ale#enabled = 1
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
  Plug 'yegappan/mru'                       " most recently used files
  let MRU_Max_Entries = 400
  call MapKeys('n', 'mr', ':MRU<CR>')
  call MapKeys('ni', '<S-F2>', ':MRU<CR>', '')
  amenu <silent> .40 &Cometsong.&Most\ Recently\ Used\ (MRU)<Tab>r/S-F2   <S-F2>

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
  "let g:NERDAltDelims_vim = 1
  let g:NERDCustomDelimiters = {
    \ 'vim':      { 'left': '"', 'leftAlt': '"""' },
    \ 'iptables': { 'left': '# ' },
    \ 'ferm':     { 'left': '# ' }
    \ }
  map ,dontmap <plug>NERDCommenterSexy " used by VCSStatus

"""--- compilation ---
  Plug 'sheerun/vim-polyglot'               " A collection of language packs for Vim.
    "let g:polyglot_disabled = ['css']      " e.g. of disabling

  Plug 'tpope/vim-dispatch'                 " multi-lingual asynchronous make
    call MapKeys('nv', 'ds', ':Dispatch<CR>')
    call MapKeys('nv', 'dm', ':Make<CR>')
    amenu <silent> .66 &Cometsong.Dispatch\ file<Tab>dm   <Leader>dm   " Cometsong Menu!

  Plug 'thinca/vim-quickrun'                " quick make, many filetypes
    call MapKeys('niv', 'qr', ':QuickRun<CR>')
    amenu <silent> .66 &Cometsong.QuickRun\ file<Tab>qr   <Leader>qr   " Cometsong Menu!

  Plug 'JarrodCTaylor/vim-shell-executor'   " execute all or selected with any shell command

  if v:version > 8
    Plug 'w0rp/ale'                           " Asynchronous Lint Engine
    let g:ale_completion_enabled = 0
    let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
    let g:ale_sign_error = 'E>'
    let g:ale_sign_warning = 'w>'
    nmap <silent> ]N <Plug>(ale_previous_wrap)
    nmap <silent> ]n <Plug>(ale_next_wrap)

    "" keep linters from running when opening a file
    "let g:ale_lint_on_enter = 0
    let g:ale_linters_explicit = 1 " enable limited set
    let g:ale_linters = {
    \   'awk':        ['all'],
    \   'dockerfile': ['all'],
    \   'git':        ['all'],
    \   'go':         ['gofmt', 'golint'],
    \   'javascript': ['all'],
    \   'json':       ['all'],
    \   'lua':        ['all'],
    \   'markdownn':  ['all'],
    \   'python':     ['prospector', 'pyflakes', 'flake8'],
    \   'sql':        ['all'],
    \   'sh':         ['shell', 'shellcheck'],
    \   'typescript': ['all'],
    \   'vim':        ['all'],
    \}
    let g:ale_python_flake8_options = '--max-line-length=100'
    let g:ale_yaml_yamllint_options = '-c $HOME/.yamllint'
    let g:ale_sh_shellcheck_options = '-x -a -s bash'
    let g:ale_typescript_tslint_config_path = '$HOME/.tslint.json'

    " Do not lint or fix minified files.
    let g:ale_pattern_options = {
    \ '\.min\.js$': {'ale_linters': [], 'ale_fixers': []},
    \ '\.min\.css$': {'ale_linters': [], 'ale_fixers': []},
    \}

  else
    Plug 'benekastah/neomake'
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
  endif

"""--- unix/shell/utils ---
  Plug 'tpope/vim-eunuch'                   " unix
  Plug 'artnez/vim-writepath'               " e some/new/path/file.foo
  Plug 'vim-utils/vim-man'                  " View man pages in vim. Grep for the man pages
  Plug 'mhinz/vim-grepper'                  " grepping flexibility
  "Plug 'benmills/vimux'                     " interact with tmux
  "Plug 'ervandew/screen'                    " simulate a split shell in vim using either gnu screen or tmux

"""--- Colorrific ---
  Plug 'junegunn/limelight.vim'             " highlights each paragraph/section of the file (puts it in the limelight)
    " Background Color name (:help cterm-colors)
    let g:limelight_conceal_ctermg = 'DarkGrey'
    let g:limelight_conceal_guifg = 'DarkGrey'
    call MapKeys('nvx', 'lm', ':Limelight!!<CR>')  " LimeLight Toggle
  "Plug 'Lokaltog/vim-distinguished'         " distinguished colors
  "Plug 'nanotech/jellybeans.vim'            " jellybeans colors
  "Plug 'mkarmona/colorsbox'                 " colorsbox color set
  Plug 'romainl/flattened'
  Plug 'altercation/vim-colors-solarized'   " solarized colorscheme
  Plug 'morhetz/gruvbox'
  Plug 'joshdick/onedark.vim'               " theme w/ airline as well
  Plug 'w0ng/vim-hybrid'                    " mix of Tomorrow-Night, Codecademy, Jellybeans, Solarized, iTerm
  Plug 'lifepillar/vim-solarized8'          " True Colors, halfway between Solarized and Flattened
  Plug 'chrisbra/Colorizer'                 " Show colors by code, name, etc
    let g:colorizer_auto_filetype='css,html'

"""--- matches ---
  Plug 'Raimondi/delimitMate'               " autoclose {([, etc
  Plug 'andymass/vim-matchup'               " show matches of words, not just chars
  Plug 'Valloric/MatchTagAlways'            " show matching x[ht]ml tags
  let delimitMate_autoclose = 1
  call MapKeys('ni', 'dc', ':DelimitMateSwitch<CR>')
  amenu <silent> .910 &Cometsong.&DelimitMateSwitch<Tab>dc   :DelimitMateSwitch<CR>

"""--- omnicompletions galore ---
  Plug 'maralla/completor.vim'
  "let g:completor_{filetype}_omni_trigger = '<python regex>'  "e.g.
  let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'
  let g:completor_blacklist = ['tagbar', 'qf', 'netrw', 'unite', 'vimwiki'] " default
  let g:completor_blacklist = 
    \ g:completor_blacklist + ['diff', 'netranger'] " add new vals to list var
    call uniq(sort(g:completor_blacklist)) " remove dupes if exist, when `so %`

  "if v:version > 8 && has('python3') && has('timers')
  "  Plug 'Shougo/deoplete.nvim'
  "  Plug 'roxma/nvim-yarp'
  "  Plug 'roxma/vim-hug-neovim-rpc'
  "  Plug 'zchee/deoplete-go', {'for': 'go'}  " deoplete: 'go'
  "  let g:deoplete#enable_at_startup = 1
  "  "let g:deoplete#sources._ = ['buffer', 'tag']
  "  call MapKeys('vni', 'ct', ':call deoplete#toggle()')
  "elseif has('lua') " v:version < 8, 
  "  Plug 'Shougo/neocomplete.vim'
  "  let g:neocomplete#enable_at_startup = 1
  "  call MapKeys('vni', 'ct', ':NeoCompleteToggle')
  "elseif v:version > 747 && has('insert_expand') && has('menu') " v:version < 8, 
    "Plug 'lifepillar/vim-mucomplete'
    "let g:mucomplete#enable_auto_at_startup = 1
  "endif
  " lang-packs
  "Plug 'Shougo/neco-vim'                   " complete: 'vim'
  Plug 'wellle/tmux-complete.vim'          " complete: 'tmux'
  Plug 'c9s/perlomni.vim', {'for': 'perl'} " perl omnicomplete

"""--- File Explorer ---
  Plug 'ipod825/vim-netranger'  "ranger style file tree, supporting remotes e.g. Mega, dropbox
    call MapKeys('ni', '<F2>', ':leftabove 50vsplit %:p:h<CR>', '')  " explore cur buf's folder

"  Plug 'scrooloose/nerdtree'                " Nerdy Directories
"  let g:NERDTreeHijackNetrw = 1
"  let g:NERDTreeSortHiddenFirst = 1
"  let g:NERDTreeHighlightCursorline = 1
"  let g:NERDTreeQuitOnOpen = 0
"  let g:NERDTreeShowFiles = 1
"  let g:NERDTreeShowBookmarks = 1
"  let g:NERDTreeNaturalSort = 1
"  call MapKeys('ni', '<F2>', ':NERDTreeToggle<CR>', '')

  Plug 'vim-ctrlspace/vim-ctrlspace'  " lists of stuff:  Buffer List, File List, Tab List, Workspace List, Bookmark List
  let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
  if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
  endif
  let g:CtrlSpaceUseTabline = 1
  let g:CtrlSpaceUseMouseAndArrowsInTerm = 1  " enable arrow keys in lists
  call MapKeys('n', 'cwn', ':CtrlSpaceNewWorkspace<CR>') " keymap for new workspace with name (don't kill all buffers/tabs!)
  call MapKeys('n', 'cws', ':CtrlSpaceSaveWorkspace<CR>') " keymap for saving workspace

  let g:loaded_netrwPlugin = 1

"""--- versionizing ---
  Plug 'inkarkat/vcscommand.vim'            " all version controllers
  "Plug 'tpope/vim-fugitive'                 " gutsy gitsiness
  Plug 'vim-scripts/thermometer'            " mercurial

"""--- tag sale! ---
  Plug 'ludovicchabant/vim-gutentags'       " background management of tags files
  let g:gutentags_ctags_tagfile = 'tags'    " default tags file name in each project
  "let g:gutentags_ctags_exclude = []        " see each project's '.gutctags' file for these options

  Plug 'majutsushi/tagbar'                  " shows all tags in sidebar window
  let g:tagbar_left = 1
  let g:tagbar_width = 50
  let g:tagbar_autoclose = 1
  let g:tagbar_autofocus = 1
  call MapKeys('ni', 'tb', ':TagbarToggle<CR>')
  call MapKeys('ni', '<F6>', ':TagbarToggle<CR>', '')
  amenu <silent> .20 &Cometsong.&Tagbar\ Toggle<Tab>tb/F6  <Leader>tb
  "let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD'

"""--- Crunch Calc ---
  Plug 'arecarn/selection.vim'
  \| Plug 'arecarn/crunch.vim'              " calculator
  let g:util_debug = 0

"""--- Encryption ---
  Plug 'jamessan/vim-gnupg'                 " use gpg for file encrpytion

"""--- Numeric ---
  "Plug 'jmcantrell/numbered.vim'             " number or renumber lines
  Plug 'vim-scripts/L9'                     " utils
  \| Plug 'cometsong/VisIncr.vim'           " Dr. Chip's Visual Increasing number,date,octal,etc columns

"""--- Sample of Unmanaged plugin (manually installed and updated) ---
  "Plug '~/my-prototype-plugin'

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

  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has('termguicolors'))
    set termguicolors
  endif

  " hybridized
  "let g:hybrid_custom_term_colors = 1
  "let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.

  " solarized
  let g:solarized_termcolors = 16
  let g:solarized_contrast = 'high'
  let g:solarized_visibility = 'normal'
  let g:solarized_underline = 0
  let g:solarized_bold = 1

"""--- Templates ---
  Plug 'cometsong/vim-template'             " forked set of template files
  "let g:templates_user_variables = [ ['', ''] ]
  let g:templates_no_autocmd = 1
  let g:username = 'Benjamin (cometsong)'
  let g:email = 'benjamin(at)cometsong(dot)net'
  let g:license = 'GPL v3 http://www.gnu.org/licenses/gpl-3.0.txt'

"""--- snippets, completions ---
  if has('python') || has('python3')
      Plug 'SirVer/UltiSnips'               " preferred
  else
      Plug 'MarcWeber/vim-addon-mw-utils'
      \| Plug 'tomtom/tlib_vim'
        \| Plug 'garbas/vim-snipmate'       " backup if no python enabled
  endif
    \| Plug 'cometsong/vim-snippets'
    \| Plug 'tlavi/SnipMgr'

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

"""--- IndentLines ---
  Plug 'Yggdroot/indentline'                " marks each indent level with vertical line instead of colors!
  call MapKeys('ni', 'ig', ':IndentLinesToggle<CR>')
  call MapKeys('ni', 'il', ':LeadingSpaceToggle<CR>')
  let g:indentLine_char = '┊'
  let g:indentLine_leadingSpaceChar = '˽'
  let g:indentLine_showFirstIndentLevel = 0
  let g:indentLine_fileTypeExclude = ['text','sql','help','config','viminfo']

"""--- TaskList ---
  Plug 'vim-scripts/TaskList.vim'           " list all TODOs
  " this mapping (tl) is also the default
  "call MapKeys('ni', 'tl', ':TaskList<CR>')
  call MapKeys('ni', '<S-F4>', ':TaskList<CR>', '')
  amenu .60 &Cometsong.TaskList<Tab>tl/S-F4  <Leader>tl

"""--- UndoTree ---
  Plug 'mbbill/undotree'                    " shows window with all previous undos
  call MapKeys('ni', 'ut', ':UndotreeToggle<CR>')
  call MapKeys('ni', '<F4>', ':UndotreeToggle<CR>', '')
  amenu <silent> .12 &Cometsong.&UndoTree\ Toggle<Tab>ut/F4  <Leader>ut

"""--- Better Rainbow Parentheses ---
  Plug 'luochen1990/rainbow'                " colors diff levels of parens
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

"""--- ScratchToggle ---
  Plug 'cometsong/scratch.vim'              " create a temporary scratch buffer while running vim
  call MapKeys('ni', 'sct', ':ScratchToggle<CR>')
  amenu <silent> .61 &Cometsong.ScratchToggle<Tab>sct  <Leader>sct  " Cometsong Menu!

"""--- peekaboo registers QuickFixes ---
  Plug 'junegunn/vim-peekaboo'              " peek at all registers when starting to use one
  let g:peekaboo_delay = 5
  let g:peekaboo_compact = 0
  let g:peekaboo_window	= "vert bo 50new"

"""--- Signature Marks ---
  Plug 'kshenoy/vim-signature'              " place, toggle and display marks
  let g:SignatureMarkLineHL = "'Exception'"

"""--- Sayonara ---
  Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }  " replace 'bufkill' with more sanity
  call MapKeys('nv', 'bd', ':Sayonara!<CR>')
  call MapKeys('nv', 'bD', ':Sayonara<CR>')
  cabbr BD Sayonara!

"""--- debug my stuff!
  "Plug 'dahu/bisectly'                      " plugin-manager-agnostic fault-localisation tool

"""-- FileTypes --
""""--- unicode ---
  Plug 'chrisbra/unicode.vim'   " show code values, allows insertion and completion of unicode chars

""""--- python[2/3] ---
"""""--- PyVeSPa ---
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

"""""--- pythonic ---
  if has('python3')
    command! -nargs=* Py python3 <args>
    let g:jedi#force_py_version = 3
    let g:ale_python_flake8_executable = 'python3'
    call PyVeSPa()
  elseif has('python')
    command! -nargs=* Py python <args>
    let g:jedi#force_py_version = 2
    let g:ale_python_flake8_executable = 'python2'
    call PyVeSPa()
  else
    let g:loaded_jedi = 1
    let g:loaded_youcompleteme = 1
  endif

  "--- Python Jedi Completion ---
  Plug 'davidhalter/jedi-vim', {'for': ['python']}  " python awesomeness
    let g:jedi#use_tabs_not_buffers = 0
    let g:jedi#popup_on_dot = 1
    let g:jedi#rename_command = "<leader>pr"
    let g:jedi#squelch_py_warning = 1
    "let g:jedi#auto_vim_configuration = 0
    let g:jedi#completions_enabled = 1
    let g:jedi#show_call_signatures = 0

  Plug 'tmhedberg/SimpylFold', {'for': ['python']}    " python folding
    let g:SimpylFold_docstring_preview = 1
  Plug 'xolox/vim-misc'
  \ | Plug 'xolox/vim-pyref',  {'for': ['python']}    " python docs

""""--- markdown ---
  Plug 'tpope/vim-markdown', {'for': 'md'}            " syntax highlighting, force .md = markdown
  Plug 'nelstrom/vim-markdown-folding', {'for': 'md'} " fold those markdowns!

""""--- yaml ---
  Plug 'ingydotnet/yaml-vim', {'for': 'yaml'}
  if has("ruby")
    Plug 'munen/find_yaml_key', {'for': 'yaml'}
  else
    let g:find_yaml_key = 1
  endif

""""--- html/jinja2r, /(java|type)script ---
  Plug 'Glench/Vim-Jinja2-Syntax', {'for': ['jinja2','jinja2.html','jinja.html','html']}
  Plug 'leafgarland/typescript-vim', {'for': ['javascript', 'typescript']}

""""--- toml ---
  Plug 'cespare/vim-toml', {'for': 'toml'}

""""--- xml ---
  Plug 'othree/xml.vim', {'for': ['xml','html','xhtml','sgml']}

""""--- csv ---
  Plug 'chrisbra/csv.vim', {'for': 'csv'}             " csv display and functions
  let g:csv_table_leftalign = 1

""""--- lesscss ---
  Plug 'groenewege/vim-less', {'for': 'less'}         " syntax for lesscss files
  Plug 'vitalk/vim-lesscss', {'for': 'less'}          " lessc compilation
  let g:lesscss_toggle_key = "<leader>lc"

""""--- UML ---
  Plug 'aklt/plantuml-syntax',    {'for': ['uml','plantuml']}      " app for PlantUML !!

""""--- BioColors ---
  Plug 'bioSyntax/bioSyntax-vim',    {'for': ['fasta', 'fastq', 'sam', 'gtf', 'bed', 'clustal', 'vcf']}
    au BufRead,BufNewFile *.fsa set filetype=fasta  " add other extension to the possible fasta files

"""-- Other Stuff  ---
  Plug 'vim-scripts/camelcasemotion'        " TraverseCamelStrings
  Plug 'cometsong/simplefold.vim'           " custom folding for some syntaxes
  Plug 'tpope/vim-surround'                 " surround strings with things
  Plug 'tpope/vim-repeat'                   " repeat many many tasks
  Plug 'vim-scripts/visualrepeat'           " cf. vim-repeat, but in visual mode
  Plug 'tpope/vim-abolish'                  " Abbreviation, Subvert, Coercion
  Plug 'ervandew/archive'                   " browse contents of archive files
  Plug 'terryma/vim-multiple-cursors'       " multiple cursors within vim, for quick refactoring, correcting, amazing, etc.
  Plug 'wesQ3/vim-windowswap'               " swap window locations
  Plug 'terryma/vim-expand-region'          " expand/contract visual selection using + and _
  Plug 'wellle/targets.vim'                 " add various text objects to operate on

  " 'must be last'
  Plug 'ryanoasis/vim-devicons'             " Adds file type glyphs/icons to popular plugins

"""--- Add plugins to &runtimepath ---
call plug#end()

""" vim:fdm=expr:fdl=1:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
