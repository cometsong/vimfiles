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

"""-- Basic Plugins ---
  Plug 'coderifous/textobj-word-column.vim' " visual select columns based on [wW]ord boundaries
  Plug 'machakann/vim-highlightedyank'      " highlight yanked text (word, block, etc) post yank
  Plug 'vim-scripts/camelcasemotion'        " TraverseCamelStrings
  Plug 'cometsong/simplefold.vim'           " custom folding for some syntaxes
  Plug 'vim-scripts/genutils'               " provides many useful utility functions for buffers, windows and other misc things
  \ Plug 'vim-scripts/foldutil.vim'         " FoldMatching for sections, FoldShowMarks, etc.
    let g:foldutilClearFolds = 0            " foldutil will not clear pre-existing folds (0) when making new ones
  Plug 'tpope/vim-surround'                 " surround strings with things
  Plug 'tpope/vim-repeat'                   " repeat many many tasks
  Plug 'inkarkat/vim-visualrepeat'          " cf. vim-repeat, but in visual mode
  Plug 'tpope/vim-abolish'                  " Abbreviation, Subvert, Coercion
  Plug 'ervandew/archive'                   " browse contents of archive files
  Plug 'terryma/vim-multiple-cursors'       " multiple cursors within vim, for quick refactoring, correcting, amazing, etc.
  Plug 'wesQ3/vim-windowswap'               " swap window locations
  Plug 'terryma/vim-expand-region'          " expand/contract visual selection using + and _
  Plug 'wellle/targets.vim'                 " add various text objects to operate on
  Plug 'romainl/vim-qlist'                  " make results of include- and definition-search easier and more persistent using quickfix list
  Plug 'szw/vim-dict'                       " fetch definitions via dict.org and local dict file
    set dictionary+=/usr/share/dict/words


"""--- vim-airline ---
  Plug 'vim-airline/vim-airline'            " status line definition
  Plug 'vim-airline/vim-airline-themes'     " status line colorschemes
  let g:airline_extensions = ['branch', 'ale', 'tagbar', 'windowswap', 'ctrlspace', 'gutentags', 'term', 'undotree']
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

  "Plug 'itchyny/lightline.vim'              " status line definition
  "let g:lightline = {
  "      \ 'colorscheme': 'wombat',
  "      \ 'active': {
  "      \   'left': [ [ 'mode', 'paste' ],
  "      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  "      \ },
  "      \ 'component_function': {
  "      \   'gitbranch': 'FugitiveHead'
  "      \ },
  "      \ }


"""--- MRU --
  Plug 'lambdalisue/mr.vim'
  \| Plug 'lambdalisue/mr-quickfix.vim'     " MRU (Most Recently Used) and MRW (Written) files to quickfix
  call map#Keys('n', 'mru', ':Mru \| copen<CR>')
  call map#Keys('n', 'mrw', ':Mrw \| copen<CR>')
  call map#Keys('n', 'mrq', ':cclose<CR>')
  let MRU_File = '~/.vim_mru_files'
  let g:mr#mru#filename = '~/.cache/mr/mru' " defaults
  let g:mr#mrw#filename = '~/.cache/mr/mrw'
  amenu <silent> .40 &Cometsong.&Most\ Recently\ Used\ (MRU)<Tab> <leader>mru

"""--- well, Search me! ---
  Plug 'haya14busa/is.vim'                  " incremental search improved - successor of incsearch.vim
  let g:is#do_default_mappings = 1

  Plug 'osyo-manga/vim-anzu'                " display search position like (2/10) for n/N commands
  map n <Plug>(is-nohl)<Plug>(anzu-n-with-echo)<Plug>(anzu-update-search-status-with-echo)
  map N <Plug>(is-nohl)<Plug>(anzu-N-with-echo)<Plug>(anzu-update-search-status-with-echo)

"""--- Alignment ---
  Plug 'cometsong/AlignChips.vim'           " from Dr Chip's Align plugin (vimscript #294)
  let g:DrChipTopLvlMenu= 'Plugin.'         " default: 'DrChip.'

"""--- commentary ---
  Plug 'cometsong/CommentFrame.vim'         " frame and full line comment styles
  let g:CommentFrame_SkipDefaultMappings = 0
  let g:CommentFrame_TextWidth = 100

  Plug 'scrooloose/nerdcommenter'           " comments smartly by filetype
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
    call map#Keys('nv', 'ds', ':Dispatch<CR>')
    call map#Keys('nv', 'dm', ':Make<CR>')
    amenu <silent> .66 &Cometsong.Dispatch\ file<Tab>dm   <Leader>dm   " Cometsong Menu!
    let g:dispatch_compilers = {
          \ 'sh': 'bash',
          \ }

  Plug 'thinca/vim-quickrun'                " quick make, many filetypes
    call map#Keys('niv', 'qr', ':QuickRun<CR>')
    amenu <silent> .66 &Cometsong.QuickRun\ file<Tab>qr   <Leader>qr   " Cometsong Menu!
    call map#Keys('niv', 'gQ', ':QuickRun<CR>', '')
    amenu <silent> .66 &Cometsong.QuickRun\ file<Tab>gQ   gQ           " Cometsong Menu!

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
    "let g:ale_linters_explicit = 1 " enable limited set
    let g:ale_linter_aliases = {'groovy': 'java'}
    let g:ale_linters = {
    \   'awk':        ['all'],
    \   'dockerfile': ['all'],
    \   'git':        ['all'],
    \   'go':         ['gofmt', 'golint'],
    \   'groovy':     ['groovysh', 'codenarc', 'javac'],
    \   'javascript': ['all'],
    \   'json':       ['all'],
    \   'lua':        ['all'],
    \   'markdown':   ['all'],
    \   'python':     ['flake8'],
    \   'sql':        ['all'],
    \   'sh':         ['shell', 'shellcheck'],
    \   'typescript': ['all'],
    \   'vim':        ['all'],
    \   'yaml':       ['all'],
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
    call map#Keys('ni', '<F5>', ':Neomake<CR>', '')
    amenu <silent> .66 &Cometsong.&Neomake<Tab>F5  <F5>
  endif

"""--- unix/shell/utils ---
  Plug 'kassio/neoterm'                     " Wrapper of some (neo)vim's :terminal functions
    let g:neoterm_default_mod = 'rightbelow'
  Plug 'tpope/vim-eunuch'                   " unix
  Plug 'artnez/vim-writepath'               " e some/new/path/file.foo
  Plug 'vim-utils/vim-man'                  " View man pages in vim. Grep for the man pages

"""--- grepping flexibility ---
  Plug 'mhinz/vim-grepper'
    let g:grepper = {}
    "runtime plugin/grepper.vim

    let g:grepper.prompt_text = '$c($t)>'   " prompt: Grepper(tool)
    let g:grepper.tools = ['rg', 'git', 'grep']
    let g:grepper.highlight = 1             " highlight matches
    let g:grepper.git = {'grepprg': 'InGi'} " append case insensitive
    let g:grepper.jump = 0                  " auto jump to the first match.
    let g:grepper.append = 0                " append matches to the current list

    "nmap gs <plug>(GrepperOperator)         " put text into 'select' mode
    "xmap gs <plug>(GrepperOperator)         " put visual text into 'select' mode

    nnoremap <leader>gg :Grepper -tool git<cr>
    nnoremap <leader>gr :Grepper -cword -dir file<cr>
    nnoremap <leader>gs :Grepper -side<cr>
    nnoremap <leader>g* :Grepper -cword -noprompt<cr>

    command! -nargs=1 Gw Grepper -tool rg -dir file -query <args>
    command! Todo Grepper -noprompt -tool git -query -E '(TODO|FIXME|NOTE|XXX):'

  "Plug 'benmills/vimux'                     " interact with tmux
  "Plug 'ervandew/screen'                    " simulate a split shell in vim using either gnu screen or tmux
  "Plug 'Shougo/vimproc.vim', {'do' : 'make'}  " Asynchronous execution plugin for Vim 

"""--- matches ---
  Plug 'Raimondi/delimitMate'               " autoclose {([, etc
  Plug 'andymass/vim-matchup'               " show matches of words, not just chars
  Plug 'Valloric/MatchTagAlways'            " show matching x[ht]ml tags
  let delimitMate_autoclose = 1
  call map#Keys('ni', 'dc', ':DelimitMateSwitch<CR>')
  amenu <silent> .910 &Cometsong.&DelimitMateSwitch<Tab>dc   :DelimitMateSwitch<CR>

"""--- omnicompletions galore ---
  Plug 'maralla/completor.vim'
    "let g:completor_{filetype}_omni_trigger = '<python regex>'  "e.g.
    let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'
    let g:completor_blacklist = ['tagbar', 'qf', 'netrw', 'unite', 'vimwiki'] " default
    let g:completor_blacklist = 
      \ g:completor_blacklist + ['diff'] " add new vals to list var
      call uniq(sort(g:completor_blacklist)) " remove dupes if exist, when `so %`
    let g:completor_complete_options = 'menuone,noselect,preview'

  Plug 'wellle/tmux-complete.vim'          " complete: 'tmux'
  Plug 'c9s/perlomni.vim', {'for': 'perl'} " perl omnicomplete

"""--- File Explorer ---
  " Disable netrw
  let g:loaded_netrw             = 1
  let g:loaded_netrwPlugin       = 1
  let g:loaded_netrwSettings     = 1
  let g:loaded_netrwFileHandlers = 1

  Plug 'lambdalisue/fern.vim'
    call map#Keys('ni', '<F2>', ':Fern . -drawer -keep -toggle -width=45 <CR>', '')  " explore cur buf's folder
    call map#Keys('ni', '<F3>', ':Fern . -opener="topleft split" <CR>', '')           " explore cur buf's folder

  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'       " Fern plugin: use nerdfont icons for filtypes
    let g:fern#renderer = "nerdfont"

  Plug 'lambdalisue/fern-bookmark.vim'                " Fern plugin: implement bookmark scheme
  Plug 'lambdalisue/fern-mapping-project-top.vim'     " Fern plugin: to find top project folder via git


"  Plug 'scrooloose/nerdtree'                " Nerdy Directories
"  let g:NERDTreeHijackNetrw = 1
"  let g:NERDTreeSortHiddenFirst = 1
"  let g:NERDTreeHighlightCursorline = 1
"  let g:NERDTreeQuitOnOpen = 0
"  let g:NERDTreeShowFiles = 1
"  let g:NERDTreeShowBookmarks = 1
"  let g:NERDTreeNaturalSort = 1
"  call map#Keys('ni', '<F2>', ':NERDTreeToggle<CR>', '')

"""--- CtrlSpace ---
  Plug 'vim-ctrlspace/vim-ctrlspace'  " lists of stuff:  Buffer List, File List, Tab List, Workspace List, Bookmark List
  let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
  if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
  endif
  let g:CtrlSpaceUseMouseAndArrowsInTerm = 1  " enable arrow keys in lists
  call map#Keys('n', 'cwn', ':CtrlSpaceNewWorkspace<CR>') " keymap for new workspace with name (don't kill all buffers/tabs!)
  call map#Keys('n', 'cws', ':CtrlSpaceSaveWorkspace<CR>') " keymap for saving workspace

  let g:CtrlSpaceUseTabline = 1
  "set tabline=%!ctrlspace#api#Tabline().CWDTabline()
  "set tabline=%!CWDTabline()
  function! CWDTabline()
    let tabline=''
    let tabline.='%#TabLineFill#'
    let tabline.='%=|'      "left/right separator
    let tabline.='%#identifier#'
    let tabline.='%.30(%{fnamemodify(getcwd(), ":~")}%)'
    let tabline.='%*'
    return tabline
  endfunction

  " Symbols:
  " WLoad-options: "➚⤴︎ ⇡", 
  " WSave-options: "➘⤵︎ ⇣",
  "if (encoding =~? 'utf') "FIXME: 'encoding not variable to check...
    let g:CtrlSpaceSymbols = {
        \   "WLoad": "⤴︎",
        \   "WSave": "⤵︎",
        \ }
  "else
  "  let g:CtrlSpaceSymbols = {
  "      \   "WLoad": "|^|",
  "      \   "WSave": "[+]",
  "      \   "BM":    "<3",
  "      \ }
  "endif

  "let g:CtrlSpaceKeys = {}

  "let g:CtrlSpaceCacheDir = expand($HOME)
  "let g:CtrlSpaceProjectRootMarkers = []

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
  call map#Keys('ni', 'tb', ':TagbarToggle<CR>')
  call map#Keys('ni', '<F6>', ':TagbarToggle<CR>', '')
  amenu <silent> .20 &Cometsong.&Tagbar\ Toggle<Tab>tb/F6  <Leader>tb
  "let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD'

"""--- Crunch Calc ---
  Plug 'arecarn/selection.vim'
  \| Plug 'arecarn/crunch.vim'              " calculator
  let g:util_debug = 0

"""--- Encryption ---
  Plug 'jamessan/vim-gnupg'                 " use gpg for file encryption

"""--- Numeric, Increments ---
  "Plug 'jmcantrell/numbered.vim'             " number or renumber lines
  Plug 'vim-scripts/L9'                     " utils
  Plug 'cometsong/VisIncr.vim'              " Dr. Chip's Visual Increasing number,date,octal,etc columns

  Plug 'Konfekt/vim-CtrlXA'                 " [in|de]crement *words.  !Yay!
  let g:CtrlXA_Toggles = [
    \ ['true', 'false'], ['True', 'False'], ['TRUE', 'FALSE'],
    \ ['yes', 'no'], ['Yes', 'No'], ['YES', 'NO'],
    \ ['on', 'off'], ['On', 'Off'], ['ON', 'OFF'],
    \ ['up', 'down'], ['Up', 'Down'] ,['UP', 'DOWN'],
    \ ['set', 'unset'],
    \ ['is', 'isnot', "isn't"],
    \ ['if', 'elseif', 'else', 'endif', 'fi'],
    \ ['+', '-', '+=', '-='],
    \ ['==', '!='], ['<', '>'], ['<=', '>='], ['=~', '!~'],
    \ ['increase', 'decrease'], ['Increase', 'Decrease'],   
    \ ['increment', 'decrement'], ['Increment', 'Decrement'], 
    \ ['positive', 'negative'], ['Positive', 'Negative'],   
    \ ['enable', 'disable'], ['Enable', 'Disable'],
    \ ['enabled', 'disabled'], ['Enabled', 'Disabled'],
    \ ['maximum', 'minimum'], ['Maximum', 'Minimum'],
    \ ['maximal', 'minimal'], ['Maximal', 'Minimal'],
    \ ['maximize', 'minimize'], ['Maximize', 'Minimize'],
    \ ['upper', 'lower'], ['Upper', 'Lower'],
    \ ['top', 'bottom'], ['Top', 'Bottom'],
    \ ['above', 'below'], ['Above', 'Below'],
    \ ['forward', 'backward'], ['Forward', 'Backward'],
    \ ['up', 'down'], ['Up', 'Down'],
    \ ['right', 'middle', 'left'], ['Right', 'Middle', 'Left'],
    \ ['next', 'previous'], ['Next', 'Previous'],
    \ ['first', 'last'], ['First', 'Last'],
    \ ['before', 'after'], ['Before', 'After'],
    \ ['more', 'less'], ['More', 'Less'],
    \ ['fast', 'slow'], ['Fast', 'Slow'],
    \ ['faster', 'slower'], ['Faster', 'Slower'],
    \ ['i', 'ii', 'iii', 'iv', 'v', 'vi', 'viii', 'ix', 'x'],
    \ ['I', 'II', 'III', 'IV', 'V', 'VI', 'VIII', 'IX', 'X'],
    \ ] " roman numerals cross-match with alphabet letters (i, v, x)

"""--- Colorrific ---
  if (has('termguicolors'))
    set termguicolors
  endif

  Plug 'junegunn/limelight.vim'             " highlights each paragraph/section of the file (puts it in the limelight)
    " Background Color name (:help cterm-colors)
    let g:limelight_conceal_ctermg = 'DarkGrey'
    let g:limelight_conceal_guifg = 'DarkGrey'
    call map#Keys('nvx', 'lm', ':Limelight!!<CR>')  " LimeLight Toggle

  Plug 'nanotech/jellybeans.vim'            " jellybeans colors
    let g:jellybeans_use_lowcolor_black = 0
    let g:jellybeans_use_term_italics = 0
    let g:jellybeans_overrides = {
    \    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
    \}
    "other jellybeans_overrides... {
    "\    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
    "\              'ctermfg': 'Black', 'ctermbg': 'Yellow',
    "\              'attr': 'italics' },
    "\    'Comment': { 'guifg': 'cccccc' },
    "\}
  Plug 'Lokaltog/vim-distinguished'         " distinguished colors
  Plug 'mkarmona/colorsbox'                 " colorsbox color set
  Plug 'romainl/flattened'
  Plug 'altercation/vim-colors-solarized'   " solarized colorscheme
  Plug 'lifepillar/vim-solarized8'          " True Colors, halfway between Solarized and Flattened
    let g:solarized_termcolors = 16
    let g:solarized_contrast = 'high'
    let g:solarized_visibility = 'normal'
    let g:solarized_underline = 0
    let g:solarized_bold = 1
  Plug 'morhetz/gruvbox'
    let g:gruvbox_italic = 1 "for terminal improvement
    let g:gruvbox_number_column = 'gray'
    let g:gruvbox_italicize_strings = 1
  Plug 'joshdick/onedark.vim'               " theme w/ airline as well
  Plug 'w0ng/vim-hybrid'                    " mix of Tomorrow-Night, Codecademy, Jellybeans, Solarized, iTerm
    let g:hybrid_custom_term_colors = 1
    let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
  Plug 'chrisbra/Colorizer'                 " Show colors by code, name, etc
    let g:colorizer_auto_filetype='css,html'
  Plug 'itchyny/landscape.vim'              " 'editor be colorful, life be joyful'; a dark/high-contrast scheme
  Plug 'sainnhe/sonokai'                    " High Contrast & Vivid Color Scheme based on Monokai Pro
    let g:sonokai_style = 'andromeda'
    let g:sonokai_enable_italic = 1
    let g:sonokai_disable_italic_comment = 1
  Plug 'plainfingers/black_is_the_color'    " found on http://vimcolors.com/1066/black_is_the_color/dark
  Plug 'cjgajard/patagonia-vim'             " A dark and cold theme for vim

"""--- Templates ---
  Plug 'cometsong/vim-template'             " forked set of template files
  "let g:templates_user_variables = [ ['', ''] ]
  let g:templates_no_autocmd = 1
  
"""--- snippets, completions ---

  let g:snippets_dir = '~/.vim/snippets'
  let g:snippet_dirs = ['~/.vim/bundle/vim-snippets/snippets']

  Plug 'Jorengarenar/miniSnip'          " lightweight minimal snippet engine
  Plug 'honza/vim-snippets'             " collection of snippets in diff formats

  let g:miniSnip_local = g:snippets_dir
  let g:miniSnip_dirs = g:snippet_dirs
  "let g:miniSnip_trigger  = '<Tab>'
  "let g:miniSnip_complkey = '<C-x><C-u>' = 
  let g:miniSnip_extends  = {}
  let g:miniSnip_ext      = 'snippets'

  " To use snipMate format snippets:  " defaults
  let g:miniSnip_opening  = '${'      " '<{'
  let g:miniSnip_closing  = '}'       " '}>'
  let g:miniSnip_evalmark = '`'       " '!' 
  let g:miniSnip_finalTag = '0'       " '+' 
  let g:miniSnip_noskip   = '!'       " '`' 

  let g:miniSnip_delimChg = '='       " '$' 
  let g:miniSnip_descmark = '?'       " '?' 
  let g:miniSnip_refmark  = '~'       " '~' 
  let g:miniSnip_named    = '@'       " '@' 


  " Plug 'drmingdrmer/xptemplate'         " code snippets engine for vim, and snippets library
  " let g:xptemplate_key = '<C-\>'
  " let g:xptemplate_always_show_pum = 1  " default:1
  " let g:xptemplate_brace_complete = 0   " default:1
  " let g:xptemplate_break_undo = 1       " default:0
  " "let g:xptemplate_close_pum = 0        " default:0
  " "let g:xptemplate_minimal_prefix =     " number of chars to trigger
  " let g:xptemplate_pum_quick_back = 0    " 1=>remove >1 chars back to longer list
  " "let g:xptemplate_strip_left = 
  " "let g:xptemplate_vars = 
  " "  \ 'author=cometsong'
  " "  \ '&email=cometsong.net'

  " Plugin key-mappings.
  "call map#Keys('ni', 'ss', '<C-c>:UltiSnipsEdit<CR>')
  "amenu <silent> .200 &Cometsong.&OpenSnippet\ File<Tab>ss ss

  " For conceal markers.
  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif

"""--- IndentLines ---
  Plug 'Yggdroot/indentline'                " marks each indent level with vertical line instead of colors!
  call map#Keys('ni', 'ig', ':IndentLinesToggle<CR>')
  call map#Keys('ni', 'il', ':LeadingSpaceToggle<CR>')
  let g:indentLine_char = '┊'
  let g:indentLine_leadingSpaceChar = '˽'
  let g:indentLine_showFirstIndentLevel = 0
  let g:indentLine_fileTypeExclude = ['text','sql','help','config','viminfo']

"""--- TaskList ---
  Plug 'vim-scripts/TaskList.vim'           " list all TODOs
  " this mapping (tl) is also the default
  "call map#Keys('ni', 'tl', ':TaskList<CR>')
  call map#Keys('ni', '<S-F4>', ':TaskList<CR>', '')
  amenu .60 &Cometsong.TaskList<Tab>tl/S-F4  <Leader>tl

"""--- UndoTree ---
  Plug 'mbbill/undotree'                    " shows window with all previous undos
  call map#Keys('ni', 'ut', ':UndotreeToggle<CR>')
  call map#Keys('ni', '<F4>', ':UndotreeToggle<CR>', '')
  amenu <silent> .12 &Cometsong.&UndoTree\ Toggle<Tab>ut/F4  <Leader>ut

"""--- Better Rainbow Parentheses ---
  Plug 'luochen1990/rainbow'                " colors diff levels of parens
  call map#Keys('ni', 'rpt', ':RainbowToggle<CR>')
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
  call map#Keys('ni', 'sct', ':ScratchToggle<CR>')
  amenu <silent> .61 &Cometsong.ScratchToggle<Tab>sct  <Leader>sct  " Cometsong Menu!

"""--- Registers ---
  Plug 'junegunn/vim-peekaboo'              " peek at all registers when starting to use one
  let g:peekaboo_delay = 5
  let g:peekaboo_compact = 0
  let g:peekaboo_window	= "vert bo 50new"
  Plug 'inkarkat/vim-ingo-library'          " lib for inkarkat plugins
  \|Plug 'inkarkat/vim-ReplaceWithRegister' " a two-in-one command that replaces text with register, d'ing to black hole

"""--- Signature Marks ---
  Plug 'kshenoy/vim-signature'              " place, toggle and display marks

"""--- Sayonara ---
  Plug 'cometsong/vim-sayonara'  " replace 'bufkill' with more sanity; forked from mhinz
  call map#Keys('nv', 'bd', ':Sayonara!<CR>')
  call map#Keys('nv', 'bD', ':Sayonara<CR>')
  cabbr BD Sayonara!

"""--- debug my stuff!
  "Plug 'dahu/bisectly'                      " plugin-manager-agnostic fault-localisation tool

"""-- FileTypes --
""""--- unicode ---
  Plug 'chrisbra/unicode.vim'   " show code values, allows insertion and completion of unicode chars

""""--- python ---
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

""""--- json ---
  Plug 'tpope/vim-jdaddy', {'for': ['json']}          " JSON manipulation and pretty printing

""""--- markdown ---
  Plug 'tpope/vim-markdown', {'for': 'md'}            " syntax highlighting, force .md = markdown
  Plug 'nelstrom/vim-markdown-folding', {'for': 'md'} " fold those markdowns!

""""--- html/jinja2, /(java|type)script ---
  Plug 'othree/html5.vim',           {'for': ['html']}
  Plug 'Glench/Vim-Jinja2-Syntax',   {'for': ['jinja2','jinja2.html','jinja.html','html']}
  Plug 'leafgarland/typescript-vim', {'for': ['javascript', 'typescript']}
  Plug 'pangloss/vim-javascript',    {'for': ['javascript', 'typescript']}

""""--- xml/toml/yaml ---
  Plug 'othree/xml.vim', {'for': ['xml','html','xhtml','sgml']}
  Plug 'cespare/vim-toml', {'for': 'toml'}

  Plug 'ingydotnet/yaml-vim', {'for': 'yaml'}
  if has("ruby")
    Plug 'munen/find_yaml_key', {'for': 'yaml'}
  else
    let g:find_yaml_key = 1
  endif

""""--- csv ---
  Plug 'chrisbra/csv.vim', {'for': 'csv'}             " csv display and functions
  let g:csv_table_leftalign = 1

""""--- less/css ---
  Plug 'groenewege/vim-less', {'for': 'less'}         " syntax for lesscss files
  Plug 'vitalk/vim-lesscss', {'for': 'less'}          " lessc compilation
    let g:lesscss_toggle_key = "<leader>lc"
  Plug 'hail2u/vim-css3-syntax', {'for': 'css'}       " css3
  Plug 'skammer/vim-css-color', {'for': 'css'}        " css

""""--- UML ---
  Plug 'aklt/plantuml-syntax',    {'for': ['uml','plantuml']}      " app for PlantUML !!

""""--- BioColors ---
  Plug 'bioSyntax/bioSyntax-vim',    {'for': ['fasta', 'fastq', 'sam', 'gtf', 'bed', 'clustal', 'vcf']}
    au BufRead,BufNewFile *.fsa set filetype=fasta  " add other extension to the possible fasta files

""""--- Pipelines/Workflows ---
  "Plug 'LukeGoodsell/nextflow-vim',  {'for': ['nextflow']} # cpu/memory hog?!

  Plug 'thecodesmith/groovy.vim',  {'for': ['groovy','nextflow']}
    au BufRead,BufNewFile *.nf set filetype=groovy.nextflow

  Plug 'broadinstitute/vim-wdl',  {'for': ['wdl']}

""""--- OS Containers ---
  Plug 'biosugar0/singularity-vim',  {'for': ['Singularity','singularity']}
    au BufRead,BufNewFile *.def set filetype=singularity

""""--- sub-context ftdetect ---
  Plug 'Shougo/context_filetype.vim'        " find fenced code blocks, assign filetype

"""--- for testing plugins ---
  Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }

"""--- Sample of Unmanaged plugin (manually installed and updated) ---
  "Plug '~/my-prototype-plugin'

"""--- devicons 'must be last'
  Plug 'ryanoasis/vim-devicons'             " Adds file type glyphs/icons to popular plugins

"""--- Add plugins to &runtimepath ---
call plug#end()

""" vim:fdm=expr:fdl=0:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='

