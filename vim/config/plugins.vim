"--- Plugged In
"""--- Disable Potentially Invalid Plugins ---
""""--- python requirements... ---
function! Py_add_virtualenv_sys_path()
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

""""--- pythonic ---
if has('python')
  command! -nargs=* Py python <args>
  let g:jedi#force_py_version = 2
  let g:syntastic_python_python_exec = 'python2'
  "let g:pymode_python = 'python2'
  call Py_add_virtualenv_sys_path()
elseif has('python3')
  command! -nargs=* Py python3 <args>
  let g:jedi#force_py_version = 3
  let g:syntastic_python_python_exec = 'python3'
  "let g:pymode_python = 'python3'
  call Py_add_virtualenv_sys_path()
else
  let g:loaded_jedi = 1
  let g:loaded_youcompleteme = 1
endif

""""--- rubies ---
if !has("ruby")
  let g:find_yaml_key = 1
endif"



"""--- Load all Plugins using plug.vim ---
""""--- Automatic plug.vim installation ---
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !curl -fLo ~/.vim/autoload/plug.vim
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    au VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')

""""--- the basics ---
  Plug 'cometsong/statline.vim'             " status line definition
  Plug 'yegappan/mru'                       " most recently used files
  Plug 'cometsong/minibufexpl.vim'          " buffers listed in top window
  Plug 'cometsong/bufkill.vim'              " delete buffer without closing the window
  Plug 'kshenoy/vim-signature'              " place, toggle and display marks
  Plug 'vim-scripts/camelcasemotion'        " TraverseCamelStrings
  Plug 'cometsong/simplefold.vim'           " custom folding for some syntaxes
  Plug 'tpope/vim-surround'                 " surround strings with things
  Plug 'tpope/vim-repeat'                   " repeat many many tasks
  Plug 'vim-scripts/visualrepeat'           " cf. vim-repeat, but in visual mode
  Plug 'mbbill/undotree'                    " shows window with all previous undos
  Plug 'vim-scripts/TaskList.vim'           " list all TODOs
  Plug 'tpope/vim-abolish'                  " Abbreviation, Subvert, Coercion
  Plug 'junegunn/vim-easy-align'            " aligning power!
  Plug 'cometsong/IndexedSearch.vim'        " shows 'Nth match out of M' at every search
  Plug 'cometsong/scratch.vim'              " create a temporary scratch buffer while running vim
  Plug 'nathanaelkane/vim-indent-guides'    " colors each indent level
  Plug 'wesQ3/vim-windowswap'               " swap window locations
  Plug 'ervandew/archive'                   " browse contents of archive files
  Plug 'ervandew/maximize'                  " max/minimize windows in multi-window layout

""""--- netrw, oil and vinegar ---
  Plug 'tpope/vim-vinegar'
  Plug 'justinmk/vim-dirvish'               " directory viewer, path navigator (instead of netrw, alongside vinegar)

""""--- commentary ---
  Plug 'scrooloose/nerdcommenter'           " comments smartly by filetype
  Plug 'cometsong/CommentFrame.vim'         " frame and full line comment styles

""""--- compilation ---
  Plug 'benekastah/neomake'                 " syntax checking
  Plug 'thinca/vim-quickrun'                " quick make, many filetypes
  Plug 'JarrodCTaylor/vim-shell-executor'   " execute al or selected with any shell command

""""--- template files ---
  Plug 'cometsong/vim-template'             " forked set of template files

""""--- unix/shell/utils ---
  Plug 'tpope/vim-eunuch'                   " unix
  Plug 'vim-utils/vim-man' 		              " View man pages in vim. Grep for the man pages
  "Plug 'benmills/vimux'                     " interact with tmux
  "Plug 'ervandew/screen'                    " simulate a split shell in vim using either gnu screen or tmux
  Plug 'artnez/vim-writepath'               " e some/new/path/file.foo
  Plug 'mhinz/vim-grepper' 		              " grepping flexibility

""""--- colorful ---
  "Plug 'flazz/vim-colorschemes'             " plethora of colorschemes to choose from
  Plug 'junegunn/limelight.vim'             " highlights each paragraph/section of the file (puts it in the limelight)
    " Background Color name (:help cterm-colors)
    let g:limelight_conceal_ctermg = 'DarkGrey'
    let g:limelight_conceal_guifg = 'DarkGrey'
    call MapKeys('nvx', 'lm', ':Limelight!!<CR>')  " LimeLight Toggle
  Plug 'Lokaltog/vim-distinguished'         " distinguished colors
  Plug 'nanotech/jellybeans.vim'            " jellybeans colors
  "Plug 'mkarmona/colorsbox'                 " colorsbox color set
  Plug 'altercation/vim-colors-solarized'   " solarized colorscheme

""""--- matches ---
  Plug 'Raimondi/delimitMate'               " autoclose {([, etc
  Plug 'vim-scripts/matchit.zip'            " show matches of words, not just chars
  Plug 'Valloric/MatchTagAlways'            " show matching x[ht]ml tags

""""--- snippet completions galore ---
  Plug 'MarcWeber/vim-addon-mw-utils'
  \| Plug 'tomtom/tlib_vim'
  \| Plug 'garbas/vim-snipmate'
  \| Plug 'honza/vim-snippets'
  \| Plug 'tlavi/SnipMgr'
  Plug 'ervandew/supertab'

  if has('nvim')
    Plug 'Shougo/neosnippet.vim'
    Plug 'Shougo/deoplete.nvim'
  endif

""""--- unite: search and display information from sources: files, buffers, recently used or registers ---
  Plug 'Shougo/unite.vim'

""""--- versionizing ---
  Plug 'inkarkat/vcscommand.vim'            " all version controllers
  Plug 'tpope/vim-fugitive'                 " gutsy gitsiness
  Plug 'gregsexton/gitv'                    " git visuals
  Plug 'vim-scripts/thermometer'            " mercurial
  Plug 'airblade/vim-gitgutter'		          " show git diffs in signs column

""""--- tag sale! ---
  Plug 'xolox/vim-misc'
  \| Plug 'xolox/vim-easytags'              " UpdateTags! HighlightTags
    set tags=./tags;
    let g:easytags_dynamic_files = 1
  Plug 'majutsushi/tagbar'                  " shows all tags in sidebar window

""""--- misc ---
  Plug 'kien/rainbow_parentheses.vim'       " colors diff levels of parens

  Plug 'arecarn/selection.vim'
  \| Plug 'arecarn/crunch.vim'              " calculator

  "Plug 'justinmk/vim-sneak'                " minimalist, versatile Vim motion plugin
  "Plug 'vim-scripts/dbext.vim'             " database connections
  "Plug 'vim-scripts/grep.vim'              " various greppers
  "Plug 'vim-scripts/numbered.vim'          " number or renumber lines
  Plug 'xolox/vim-session'                 " session manager
  "Plug 'vim-scripts/FuzzyFinder'           " fuzzy char find in buffers, files, tags, etc (ns9tks)
  "Plug 'vim-scripts/QuickFixCurrentNumber' " navigation extension on quickfix items

  "Plug 'vim-scripts/L9'                    " utils
    "\ | Plug 'vim-scripts/VisIncr'         " making a column of increasing or decreasing numbers, dates, or daynames

  Plug 'terryma/vim-multiple-cursors'       " multiple cursors within vim, for quick refactoring, correcting, amazing, etc.
  Plug 'dyng/ctrlsf.vim'                    " An ack/ag/pt/rg powered code search and view tool, w/ edit mode!

""""--- FileTypes --

"""""--- bash ---
  Plug 'vim-scripts/bash-support.vim', {'for': 'sh'}   " WolfgangMehner bash stuff

"""""--- python[2/3] ---
  Plug 'davidhalter/jedi-vim', {'for': ['python']}     " python awesomeness
  Plug 'tmhedberg/SimpylFold', {'for': ['python']}     " python folding
  Plug 'xolox/vim-misc'
    \ | Plug 'xolox/vim-pyref', {'for': ['python']}    " python docs
  "Plug 'jmcantrell/vim-virtualenv, {'for': ['python']}'

"""""--- markdown ---
  Plug 'tpope/vim-markdown', {'for': 'md'}             " syntax highlighting, force .md = markdown
  Plug 'nelstrom/vim-markdown-folding', {'for': 'md'}  " fold those markdowns!

"""""--- yaml ---
  Plug 'ingydotnet/yaml-vim', {'for': 'yaml'}
  Plug 'munen/find_yaml_key', {'for': 'yaml'}

"""""--- csv ---
  Plug 'chrisbra/csv.vim', {'for': 'csv'}              " csv display and functions

"""""--- lesscss ---
  Plug 'groenewege/vim-less', {'for': 'less'}          " syntax for lesscss files
  Plug 'vitalk/vim-lesscss', {'for': 'less'}           " lessc compilation

"""""--- vim, perl stuff ---
  Plug 'vim-scripts/Vim-Support', {'for': 'vim'} "WolfgangMehner vim stuff
  "Plug 'vim-scripts/perl-support.vim', {'for': 'perl'} "WolfgangMehner perl stuff


""""--- Sample of Unmanaged plugin (manually installed and updated) ---
  "Plug '~/my-prototype-plugin'

""""--- Add plugins to &runtimepath ---
call plug#end()

"""--- Config for all Plugs ---
""""--- statline ---
let g:statline_scmfrontend = 1
let g:statline_no_encoding_string = 'NoEnc'

""""--- Colorrific ---
" for terminal vim:
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

""""--- MRU ---
let MRU_Max_Entries = 400
call MapKeys('n', 'r', ':MRU<CR>')
call MapKeys('ni', '<S-F2>', ':MRU<CR>', '')
amenu <silent> .40 &Cometsong.&Most\ Recently\ Used\ (MRU)<Tab>r/S-F2   <S-F2>

""""--- NERDcommenter ---
let g:NERDCustomDelimiters = {
  \ 'vim': { 'left': '"' },
  \ 'iptables': { 'left': '# ' },
  \ 'ferm': { 'left': '# ' }
  \ }

""""--- TagBar ---
let g:tagbar_left = 1
let g:tagbar_width = 50
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
call MapKeys('ni', 'tb', ':TagbarToggle<CR>')
call MapKeys('ni', '<F6>', ':TagbarToggle<CR>', '')
amenu <silent> .20 &Cometsong.&Tagbar\ Toggle<Tab>tb/F6  <Leader>tb
"let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD'

""""--- Python Jedi Completion ---
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 1
let g:jedi#rename_command = "<leader>re"
let g:jedi#squelch_py_warning	= 1
"let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0

""""--- Python Folding ---
let g:SimpylFold_docstring_preview = 1

""""--- Perl-Support ---
let g:Perl_GlobalTemplateFile     = $HOME.'/.vim/bundle/perl-support.vim/perl-support/templates/Templates'
let g:Perl_LocalTemplateFile      = $HOME.'/.vim/misc/perl-support/Templates.local'
let g:Perl_CodeSnippets           = $HOME.'/.vim/misc/perl-support/codesnippets'
let g:Perl_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
let g:Perl_TemplateOverwrittenMsg = 'no'
let g:Perl_PerlTags               = 'on'
let g:Perl_XtermDefaults          = "-fa courier -fs 10 -geometry 90x50"

""""--- Bash-Support ---
let g:BASH_GlobalTemplateFile     = $HOME.'/.vim/bundle/bash-support.vim/bash-support/templates/Templates'
let g:BASH_LocalTemplateFile      = $HOME.'/.vim/misc/bash-support/Templates.local'
let g:BASH_CodeSnippets           = $HOME.'/.vim/misc/bash-support/codesnippets'
let g:BASH_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
let g:BASH_MenuHeader             = 'off'
let g:BASH_TemplateOverwrittenMsg = 'no'
let g:BASH_XtermDefaults          = '-fa courier -fs 10 -geometry 90x50'
let g:BASH_Debugger               = 'bashdb'

""""--- snippets, completions ---
let g:snips_author = "Benjamin Leopold (cometsong)"
let g:snippets_dir = '~/.vim/snippets'

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"let g:snipMate = {}
"let g:snipMate.scope_aliases = {}
"let g:snipMate.scope_aliases['python'] = 'python,python3,django'

" Plugin key-mappings.
call MapKeys('ni', 'ss', '<C-c>:SnipMateOpenSnippetFiles<CR>')
amenu <silent> .200 &Cometsong.&OpenSnippet\ Files<Tab>ss ss


""""--- netrw ---
if v:version > 702
  "let g:netrw_home = "~"
  let g:netrw_ctags =$HOME.'/bin/ctags'
  let g:netrw_dirhistmax = 50
  let g:netrw_special_syntax = 1
  let g:netrw_timefmt = "%Y-%m-%d %H-%M-%S"
  let g:netrw_winsize = 25
  let g:netrw_liststyle = 3
  let g:netrw_browse_split = 0

  call MapKeys('ni', 'vf', ':Vex<CR>')
  call MapKeys('ni', '<F2>', ':Vex<CR>', '')
  amenu <silent> .10 &Cometsong.&Vexplore\ Toggle<Tab>vf/F2  <Leader>vf

  call MapKeys('ni', '<S-F2>', ':Lex<CR>', '')
  call MapKeys('ni', 'vl', ':Lex<CR>', '')
  amenu <silent> .10 &Cometsong.&Lexplore\ Toggle<Tab>vl/S-F2  <Leader>vl
else " do not load netrw if ver < 7.2
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1
endif

""""--- delimitMate ---
let delimitMate_autoclose = 1
call MapKeys('ni', 'dc', ':DelimitMateSwitch<CR>')
amenu <silent> .910 &Cometsong.&DelimitMateSwitch<Tab>dc   :DelimitMateSwitch<CR>

""""--- vim-session plugin settings ---
let g:session_directory = $HOME . '/.vimsessions/'
let g:session_autosave  = 'yes'
let g:session_autoload  = 'no'
let g:session_command_aliases = 1

""""--- IndentGuides ---
" this mapping (ig) is also the default
call MapKeys('ni', 'ig', ':IndentGuidesToggle<CR>')
amenu .350 &Cometsong.Indent\ &Guides<Tab>ig  <Leader>ig

""""--- TaskList ---
" this mapping (tl) is also the default
"call MapKeys('ni', 'tl', ':TaskList<CR>')
call MapKeys('ni', '<S-F4>', ':TaskList<CR>', '')
amenu .60 &Cometsong.TaskList<Tab>tl/S-F4  <Leader>tl

""""--- UndoTree ---
call MapKeys('ni', 'ut', ':UndotreeToggle<CR>')
call MapKeys('ni', '<F4>', ':UndotreeToggle<CR>', '')
amenu <silent> .12 &Cometsong.&UndoTree\ Toggle<Tab>ut/F4  <Leader>ut

""""--- Better Rainbow Parentheses ---
" see autocmd e.g. "RainbowParenthesesToggleAll" above
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
call MapKeys('ni', 'rpt', ':RainbowParenthesesToggleAll<CR>')
call MapKeys('ni', '<S-F6>', ':RainbowParenthesesToggleAll<CR>', '')
amenu <silent> .80 &Cometsong.&RainbowParentheses\ Toggle<Tab>rpt/S-F6  <Leader>rpt

""""--- Git it to Me! ---
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
let g:gitgutter_enabled = 0
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0
let g:gitgutter_highlight_lines = 1


""""--- Crunch Calc ---
let g:util_debug = 0

""""--- FuzzyFinder ---
let g:fuf_modesDisable = [ 'mrufile', 'mrucmd', 'bookmarkfile', 'bookmarkdir', 'quickfix',
                         \ 'coveragefile', 'taggedfile', 'line', 'callbackfile', 'callbackitem' ]
let g:fuf_enumeratingLimit = 55

call MapKeys('ni', 'ff',  ':FufFileWithCurrentBufferDir<CR>') " File mode in buffer dir
call MapKeys('ni', 'ffd', ':FufFileWithCurrentBufferDir<CR>') " File mode in buffer dir
amenu <silent> .12 &Cometsong.&FuzzyFinder\ &File\ Toggle<Tab>ffd  <Leader>ffd
amenu <silent> .195 &Cometsong.&FuzzyFinder.&File\ (cwd)\ mode<Tab>ffd  <Leader>ffd
call MapKeys('ni', 'ffh', ':FufFile<CR>')                     " File mode
amenu <silent> .195 &Cometsong.&FuzzyFinder.&File\ (home)\ mode<Tab>ffh  <Leader>ffh
call MapKeys('ni', 'fmr', ':FufMruFile<CR>')                  " MRU-File mode
amenu <silent> .195 &Cometsong.&FuzzyFinder.&MRU\ mode<Tab>fmr  <Leader>fmr
call MapKeys('ni', 'fb',  ':FufBuffer<CR>')                   " Buffer mode
amenu <silent> .195 &Cometsong.&FuzzyFinder.&Buffer\ mode<Tab>fb  <Leader>fb
amenu .195 &Cometsong.&FuzzyFinder.-sep1- :
call MapKeys('ni', 'fd',  ':FufDir<CR>')                      " Directory mode from $HOME
amenu <silent> .195 &Cometsong.&FuzzyFinder.&Dir\ mode<Tab>fd  <Leader>fd
call MapKeys('ni', 'fd',  ':FufDirWithCurrentBufferDir<CR>')  " Directory mode in buffer dir
amenu <silent> .195 &Cometsong.&FuzzyFinder.&Dir\ (cwd)\ mode<Tab>fd  <Leader>fd
amenu .195 &Cometsong.&FuzzyFinder.-sep2- :
call MapKeys('ni', 'ftb', ':FufBufferTag<CR>')                " Buffer-Tag mode
amenu <silent> .195 &Cometsong.&FuzzyFinder.&Tags\ in\ buffer<Tab>ft  <Leader>ft
call MapKeys('ni', 'ftw', ':FufTagWithCursorWord<CR>')        " Tag mode with word under cursor
amenu <silent> .195 &Cometsong.&FuzzyFinder.&Tag\ of\ word<Tab>ftw  <Leader>ftw
call MapKeys('ni', 'fta', ':FufTag<CR>')                      " Tag mode
amenu <silent> .195 &Cometsong.&FuzzyFinder.&Tags\ mode<Tab>fta  <Leader>fta
amenu .195 &Cometsong.&FuzzyFinder.-sep3- :
call MapKeys('ni', 'fjl', ':FufJumpList<CR>')                 " Jump-List mode
amenu <silent> .195 &Cometsong.&FuzzyFinder.&JumpList\ mode<Tab>fj  <Leader>fj
call MapKeys('ni', 'ful', ':FufChangeList<CR>')               " Change-List (Undo-list) mode
call MapKeys('ni', 'fcl', ':FufChangeList<CR>')               " Change-List mode
amenu <silent> .195 &Cometsong.&FuzzyFinder.&ChangeList\ mode<Tab>ful  <Leader>ful
amenu .195 &Cometsong.&FuzzyFinder.-sep4- :
call MapKeys('ni', 'fh',  ':FufHelp<CR>')                     " Help mode
amenu <silent> .195 &Cometsong.&FuzzyFinder.&Help\ mode<Tab>fh  <Leader>fh

""""--- unite ---
let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 40

call MapKeys('ni', 'ub', ':UniteWithBufferDir file<CR>')
call MapKeys('ni', '<S-F3>', ':UniteWithBufferDir file<CR>', '')
call MapKeys('ni', 'uf', ':Unite file<CR>')
call MapKeys('ni', 'ur', ':Unite register<CR>')
call MapKeys('ni', '<F3>', ':Unite register<CR>', '')

amenu <silent> .13 &Cometsong.&Unite:\ registers<Tab>F3  <F3>
amenu <silent> .13 &Cometsong.&Unite:\ Files\ BufferDir<Tab>S-F3  <S-F3>

""""--- NeoMake ---
let g:neomake_open_list = 2
let g:neomake_list_height = 15

call MapKeys('ni', '<F5>', ':Neomake<CR>', '')
amenu <silent> .225 &Cometsong.&NeomakeTab>F5  <F5>

""""--- CSV ---
let g:csv_table_leftalign = 1

""""--- Sneak ---
call MapKeys('n', 'f', '<Plug>SneakForward', '')
call MapKeys('x', 'f', '<Plug>VSneakForward', '')
call MapKeys('n', 'F', '<Plug>SneakBackward', '')
call MapKeys('x', 'F', '<Plug>VSneakBackward', '')
amenu <silent> .226 &Cometsong.&SneakForward f
amenu <silent> .226 &Cometsong.&SneakBackward F

""""--- Easy Align ---
"call MapKeys('nv', 'ga', '<Plug>(EasyAlign)') " MapKeys does not work with this keymapping
vmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
amenu <silent> .901 &Cometsong.EasyAlign<Tab>\ga   ga   " Cometsong Menu!

"""""--- --- augroup FileType sh,perl --- ---
augroup FileType sh,perl
  let g:easy_align_delimiters = {
      \ 's': {
      \     'pattern':       '\$',
      \     'ignore_groups': ['Comment'],
      \     'left_margin':   0,
      \     'right_margin':  0,
      \     'indentation':   'shallow',
      \     'stick_to_left': 0
      \     },
      \ '=': {
      \     'pattern':       '=',
      \     'ignore_groups': ['Comment'],
      \     'left_margin':   0,
      \     'right_margin':  0,
      \     'indentation':   'deep',
      \     'stick_to_left': 0
      \     }
  \}
  augroup END

""""--- LessCss ---
let g:lesscss_toggle_key = "<leader>lc"

""""--- Signature Marks ---
let g:SignatureMarkLineHL = "'Exception'"

""""--- Templates ---
"let g:templates_user_variables = [ ['', ''] ]
let g:templates_no_autocmd = 1
let g:username = 'Benjamin (cometsong)'
let g:email = 'benjamin(at)cometsong(dot)net'
let g:license = 'GPL v3'

""""--- CtrlSF (ag!) ---
let g:ctrlsf_context = '-C 2'
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '25%'

call MapKeys('n', '<C-F>f', '<Plug>CtrlSFPrompt', '')
call MapKeys('v', '<C-F>f', '<Plug>CtrlSFVwordPath', '')
call MapKeys('v', '<C-F>c', '<Plug>CtrlSFCwordPath', '')
call MapKeys('ni', '<C-F>t', ':CtrlSFToggle<CR>', '')


""" vim:fdm=expr:fdl=0:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
