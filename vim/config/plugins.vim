"--- Plugged In

"---- Disable Potentially Invalid Plugins ---- {{{
" python requirements...
if !has("python")
  let g:loaded_jedi = 1
endif
"}}}

"---- Load all Plugins using the Pathogen plugin ---- {{{
call pathogen#infect()
call pathogen#helptags()
"}}}

"---- statline ---- {{{
let g:statline_scmfrontend = 1
let g:statline_no_encoding_string = 'NoEnc'
"}}}

"---- NERDcommenter ---- {{{
let g:NERDCustomDelimiters = {
  \ 'vim': { 'left': '"' },
  \ 'iptables': { 'left': '# ' },
  \ 'ferm': { 'left': '# ' }
  \ }
"}}}

"---- NERDTreeOptions ---- {{{
call MapKeys('ni', 'nt', ':NERDTreeToggle<CR>')
call MapKeys('ni', '<F2>', ':NERDTreeToggle<CR>', '')
amenu <silent> .10 &Cometsong.&NERDTree\ Toggle<Tab>nt/F2  <Leader>nt
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
"}}}

"---- TagBar ---- {{{
let g:tagbar_left = 1
let g:tagbar_width = 50
let g:tagbar_autoclose = 1
let g:tagbar_autofocus = 1
call MapKeys('ni', 'tb', ':TagbarToggle<CR>')
call MapKeys('ni', '<F6>', ':TagbarToggle<CR>', '')
amenu <silent> .20 &Cometsong.&Tagbar\ Toggle<Tab>tb/F6  <Leader>tb
"let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD'
"}}}

"---- Python Jedi Completion ---- {{{
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#popup_on_dot = 0
let g:jedi#rename_command = "<leader>re"
"}}}

"---- Python Folding ---- {{{
let g:SimpylFold_docstring_preview = 1
"}}}

"---- SuperTab automatic tab completion of keywords {{{
let g:SuperTabMappingForward  = '<s-tab>'
let g:SuperTabMappingBackward = '<s-c-tab>'
"}}}

"---- Perl-Support ---- {{{
let g:Perl_GlobalTemplateFile     = $HOME.'/.vim/bundle/perl-support.vim/perl-support/templates/Templates'
let g:Perl_LocalTemplateFile      = $HOME.'/.vim/misc/perl-support/Templates'
let g:Perl_CodeSnippets           = $HOME.'/.vim/misc/perl-support/codesnippets'
let g:Perl_Ctrl_j                 = 'on'
let g:Perl_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
let g:Perl_MenuHeader             = 'off'
let g:Perl_TemplateOverwrittenMsg = 'no'
let g:Perl_XtermDefaults          = '-fa courier -fs 12 -geometry 80x24'
"}}}

"---- Bash-Support ---- {{{
let g:BASH_GlobalTemplateFile     = $HOME.'/.vim/bundle/bash-support.vim/bash-support/templates/Templates'
let g:BASH_LocalTemplateFile      = $HOME.'/.vim/misc/bash-support/Templates'
let g:BASH_CodeSnippets           = $HOME.'/.vim/misc/bash-support/codesnippets'
let g:BASH_Ctrl_j                 = 'on'
let g:BASH_TimestampFormat        = '%Y-%m-%d_%H.%M.%S'
let g:BASH_MenuHeader             = 'off'
let g:BASH_TemplateOverwrittenMsg = 'no'
let g:BASH_XtermDefaults          = '-fa courier -fs 12 -geometry 80x24'
"}}}

"---- MRU ---- {{{
let MRU_Max_Entries = 400
call MapKeys('n', 'r', ':MRU<CR>')
call MapKeys('ni', '<S-F2>', ':MRU<CR>', '')
amenu <silent> .40 &Cometsong.&Most\ Recently\ Used\ (MRU)<Tab>r/S-F2   <S-F2> 
"}}}

"---- snippets ---- {{{
let g:loaded_snipmate = 0
let g:snips_author = "Benjamin Leopold (cometsong)"

call MapKeys('ni', '<S-F10>', ':SnipMateOpenSnippetFiles<CR>', '')
amenu <silent> .200 &Cometsong.&SnipMate\ OpenSnippetFiles<Tab>S-F10   <S-F10>


let g:__XPTEMPLATE_VIM__ = 1
function! SetPersonalXpVars()
  let l:personal_vars =
    \       'author=Benjamin\ Leopold'
    \ .'&'. 'email=benjamin at cometsong dot net'
    "\ .'&'. ''

  let g:xptemplate_vars = exists('g:xptemplate_vars') ?
    \ g:xptemplate_vars . '&' . l:personal_vars
    \ : l:personal_vars
endfunction
call SetPersonalXpVars()
"}}}

"---- netrw ---- {{{
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
"}}}

"---- delimitMate ---- {{{
let delimitMate_autoclose = 1
call MapKeys('ni', 'dc', ':DelimitMateSwitch<CR>')
amenu <silent> .910 &Cometsong.&DelimitMateSwitch<Tab>dc   :DelimitMateSwitch<CR>
"}}}

"---- vim-session plugin settings ---- {{{
let g:session_directory = $HOME . '/.vimsessions/'
let g:session_autosave  = 'yes'
let g:session_autoload  = 'no'
let g:session_command_aliases = 1
"}}}

"---- IndentGuides ---- {{{
" this mapping (ig) is also the default
call MapKeys('ni', 'ig', ':IndentGuidesToggle<CR>')
amenu .350 &Cometsong.Indent\ &Guides<Tab>ig  <Leader>ig
"}}}

"---- TaskList ---- {{{
" this mapping (tl) is also the default
"call MapKeys('ni', 'tl', ':TaskList<CR>')
call MapKeys('ni', '<S-F4>', ':TaskList<CR>', '')
amenu .60 &Cometsong.TaskList<Tab>tl/S-F4  <Leader>tl
"}}}

"---- UndoTree ---- {{{
call MapKeys('ni', 'ut', ':UndotreeToggle<CR>')
call MapKeys('ni', '<F4>', ':UndotreeToggle<CR>', '')
amenu <silent> .12 &Cometsong.&UndoTree\ Toggle<Tab>ut/F4  <Leader>ut
"}}}

"---- Better Rainbow Parentheses ---- {{{
" see autocmd e.g. "RainbowParenthesesToggleAll" above
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
call MapKeys('ni', 'rpt', ':RainbowParenthesesToggleAll<CR>')
call MapKeys('ni', '<S-F6>', ':RainbowParenthesesToggleAll<CR>', '')
amenu <silent> .80 &Cometsong.&RainbowParentheses\ Toggle<Tab>rpt/S-F6  <Leader>rpt
"}}}

"---- Git it to Me! ---- {{{
" gitv
let g:Gitv_CommitStep = 20
let g:Gitv_OpenHorizontal = 1
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_OpenPreviewOnLaunch = 1
let g:Gitv_DoNotMapCtrlKey = 1
cabbrev git Git
call MapKeys('nv', 'gv', ':Gitv --all<CR>')
amenu <silent> .192 &Cometsong.&Git.&Git\ Repo\ Log\ Toggle<Tab>gv  <Leader>gv
call MapKeys('nv', 'gV', ':Gitv! --all<CR>')
amenu <silent> .192 &Cometsong.&Git.&Git\ Repo\ File\ Log\ Toggle<Tab>gV  <Leader>gV

" fugitive
call MapKeys('ni', 'gs', ':Gstatus<CR>')
amenu <silent> .192 &Cometsong.&Git.&Git\ Status<Tab>gs  <Leader>gs
call MapKeys('ni', 'gd', ':Gdiff<CR>')
amenu <silent> .192 &Cometsong.&Git.&Git\ Diff<Tab>gd  <Leader>gd
"}}}

"---- bcCalc ---- {{{
"" calculate expression from selection
call MapKeys('v', 'bc', '"ey:call CalcLines(1)<CR>')
vmenu <silent> .255 &Cometsong.&calculate\ selected\ lines<Tab>bc  <Leader>bc
"" calculate expression on current line
call MapKeys('', 'bc', '"eyy:call CalcLines(0)<CR>')
amenu <silent> .255 &Cometsong.&calculate\ current\ line<Tab>bc  <Leader>bc
"}}}

"---- FuzzyFinder ---- {{{
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
"}}}

"---- unite ---- {{{
let g:unite_enable_split_vertically = 1
let g:unite_winwidth = 40

call MapKeys('ni', 'ub', ':UniteWithBufferDir file<CR>')
call MapKeys('ni', '<S-F3>', ':UniteWithBufferDir file<CR>', '')
call MapKeys('ni', 'uf', ':Unite file<CR>')
call MapKeys('ni', 'ur', ':Unite register<CR>')
call MapKeys('ni', '<F3>', ':Unite register<CR>', '')

amenu <silent> .13 &Cometsong.&Unite:\ registers<Tab>F3  <F3>
amenu <silent> .13 &Cometsong.&Unite:\ Files\ BufferDir<Tab>S-F3  <S-F3>
"}}}

"---- Syntastic ---- {{{
let g:syntastic_error_symbol    ='∆>'
let g:syntastic_warning_symbol  ='=>'
let g:syntastic_auto_loc_list   =1
let g:syntastic_loc_list_height =5
let g:syntastic_quiet_warnings  =1

call MapKeys('ni', '<F5>', ':SyntasticCheck<CR>', '')
call MapKeys('ni', '<S-F5>', ':Errors<CR>', '')
amenu <silent> .225 &Cometsong.&Syntastic:\ Check<Tab>F5  <F5>
amenu <silent> .225 &Cometsong.&Syntastic:\ ErrorShow<Tab>S-F5  <S-F5>
"}}}

