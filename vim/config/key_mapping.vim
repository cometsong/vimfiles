"--- Key Mapping

"--- if Leader=\ then set 2xLeader=\ (to allow fast typing of the <Leader>  {{{
"---    instead of waiting for vim to catch up with you.)
"call map#Keys('i', '<Leader><Leader>', '<Leader>', '')
inoremap <Leader><Leader> <Leader>
"}}}

"--- cd to dir of current buffer  {{{
" The current directory is the directory of the file in the current window.
call map#Keys('n', 'lcd', ':lchdir %:p:h<CR>')   " map \lcd to lchdir to dir of current buffer
"}}}

"--- Fast editing of vimrc  {{{
call map#Keys('n', 'vi', ':vsplit $MYVIMRC<cr>')
amenu <silent> .999 &Cometsong.Edit\ &vimrc\ <Tab>vi  <Leader>vi   " Cometsong Menu!
"}}}

"--- Edit hotkey command appends current dir to :e, :sp, :vsp {{{
cnoremap %% <C-R>=expand('%:h').'/'<cr>
call map#Keys('n', 'ee', ':e %%')
call map#Keys('n', 'es', ':sp %%')
call map#Keys('n', 'ev', ':vsp %%')
"}}}

"--- set capital Y to do same as D&C, yank to end of line {{{
call map#Keys('n', 'Y', 'y$', '')
"}}}

"--- Make p in Visual mode replace the selected text with the "" register.  {{{
call map#Keys('v', 'p', '<Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>', '')
"}}}

"--- Wrap Setup {{{
set showbreak=\ …\  " shows at beginning of each wrapped line
set cpoptions+=n    " sets the showbreak in between the line numbers
command! -nargs=* Wrap set wrap linebreak nolist
command! -nargs=* WrapOff set nowrap nolinebreak
call map#Keys('ni', 'w', ':set wrap!<CR>')
amenu .110 &Cometsong.&Wraps.Wrap<Tab>w  :set wrap!<CR>
call map#Keys('ni', 'l', ':set linebreak!<CR>')
amenu .110 &Cometsong.&Wraps.&Linebreak<Tab>l :set linebreak!<CR>
call map#Keys('ni', 'wl', ':set wrap!<CR> :set linebreak!<CR>')
amenu .110 &Cometsong.&Wraps.&Wrap\ \&\ Linebreak<Tab>wl  :set wrap!<CR> :set linebreak!<CR>
"}}}

"--- Pastin' Setup {{{
call map#Keys('ni', 'p', ':set paste!<CR>')
amenu <silent> .210 &Cometsong.&Paste\ mode<Tab>p  <Leader>p
"}}}

"--- Buffer Access Setup  {{{
call map#Keys('ni', '<C-PageUp>',   ':bprev<CR>', '')
call map#Keys('ni', '<C-PageDown>', ':bnext<CR>', '')
"call map#Keys('ni', '<C-k>',        ':bprev<CR>', '')
"call map#Keys('ni', '<C-j>',        ':bnext<CR>', '')

" :ls with auto-bufselect begun :b
" idea from romainl: http://vi.stackexchange.com/a/2124/2303
call map#Keys('n', 'gls', ':ls<CR>:b', '')
"}}}

"--- datetime stamps  {{{
call map#Keys('ni', 'dts', '"=strftime("%Y%m%d_%H%M%S")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.&Datetime:\ ccyymmdd_hhmiss<Tab>dts          <Leader>dts
call map#Keys('ni', 'dtz', '"=strftime("%F %T%z")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.&Datetime:\ ccyy-mm-dd\ hh:mi:ss+tz<Tab>dtz  <Leader>dtz
"--- date stamps
call map#Keys('ni', 'ymd', '"=strftime("%Y%m%d")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Date:\ ccyymmdd<Tab>ymd                      <Leader>ymd
call map#Keys('ni', 'ymd-', '"=strftime("%Y-%m-%d")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Date:\ ccyy-mm-dd<Tab>ymd-                   <Leader>ymd-
call map#Keys('ni', 'dny', '"=strftime("%d-%b-%Y")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Date:\ dd-mon-ccyy<Tab>dny                   <Leader>dny
"--- time stamps
call map#Keys('ni', 'tz', '"=strftime("%T%z")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Time:\ hh:mi:ss+tz<Tab>tz                    <Leader>tz
call map#Keys('ni', 'ts', '"=strftime("%H%M%S")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Time:\ hhmiss<Tab>ts                         <Leader>ts
"}}}

"--- ignorecase {{{
set ignorecase
set smartcase
call map#Keys('ni', 'ic', ':set ignorecase!<CR>')
amenu .350 &Cometsong.&Ignore\ Case<Tab>ic  <Leader>ic
call map#Keys('ni', 'sc', ':set smartcase!<CR>')
amenu .350 &Cometsong.&Smart\ Case<Tab>sc  <Leader>sc
"}}}

"--- operating system clipboard {{{
" see set clipboard in settings
call map#Keys('n', ',y', '"+y') " copy
call map#Keys('n', ',x', '"+x') " cut
call map#Keys('n', ',p', '"+p') " paste
"}}}

"--- Q=quit-all instead of going to Ex mod  {{{
call map#Keys('n', 'Q', ':qa<CR>', '')
"}}}

"--- List chars  {{{
call map#Keys('ni', 'li', ':set list!<CR>') " Toggle invisible chars
amenu <silent> .900 &Cometsong.Show\ &invisible\ chars\ <Tab>li   <Leader>li   " Cometsong Menu!
"}}}

"--- Cursor column and line show/hide  {{{
if v:version > 700
  set nocursorline
  set nocursorcolumn
  hi  CursorLine   cterm=underline ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=undercurl
  hi  CursorColumn cterm=underline ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=undercurl
  call map#Keys('ni', 'curt', ':set cursorcolumn! cursorline! <CR>')
  amenu <silent> .500 &Cometsong.&Cursor\ position\ toggle<Tab>curt     <Leader>curt
endif
"}}}

"--- matchit   {{{
call map#Keys('n', ',mi', ':runtime macros/matchit.vim<CR>') " run the macros matchit (% for if/endif,etc)
amenu <silent> .900 &Cometsong.Matchit<Tab>,mi   <Leader>,mi   " Cometsong Menu!
"}}}

"--- Spell Checking   {{{
call map#Keys('ni', 'sp', ':set spell!<CR>') " toggle spelling
amenu <silent> .59 &Cometsong.Spell\ Checking\ Toggle<Tab>sp   <Leader>sp   " Cometsong Menu!
"}}}

"--- Remove EOL spaces   {{{
call map#Keys('ni', 'ers', ':%s/\s\+$//<CR>')
amenu <silent> .61 &Cometsong.Remove\ EOL\ Spaces<Tab>ers   <Leader>ers   " Cometsong Menu!
"}}}

"--- JSON   {{{
call map#Keys('niv', '=j', ':%!pyx -m json.tool<CR>', '')
amenu <silent> .901 &Cometsong.Format\ JSON\ buffer<Tab>\=j   =j   " Cometsong Menu!
"}}}

"--- OS X: command -> control conversion {{{
map <d-a> <c-a>
map <d-b> <c-b>
map <d-c> <c-c>
map <d-d> <c-d>
map <d-e> <c-e>
map <d-f> <c-f>
map <d-g> <c-g>
map <d-h> <c-h>
map <d-i> <c-i>
map <d-j> <c-j>
map <d-k> <c-k>
map <d-l> <c-l>
map <d-m> <c-m>
map <d-n> <c-n>
map <d-o> <c-o>
map <d-p> <c-p>
map <d-q> <c-q>
map <d-r> <c-r>
map <d-s> <c-s>
map <d-t> <c-t>
map <d-u> <c-u>
map <d-v> <c-v>
map <d-w> <c-w>
map <d-x> <c-x>
map <d-y> <c-y>
map <d-z> <c-z>
"}}}

"--- WinFix height and width Toggle {{{
call map#Keys('ni', 'wf', ':call ShowCmdMsg("set wfh! wfw! wfh? wfw?")<CR>')
amenu <silent> .210 &Cometsong.&WinFixToggle\ (height+width)\ mode<Tab>wf  <Leader>wf
"}}}

"--- JAX work mappings {{{
command! MinutesDatestamp normggo- datetime: "\dtzggO\dtsyiw"tdd/event<CR>$diW
call map#Keys('n', '=md', ':MinutesDatestamp<CR>', '')
call map#Keys('n', '=ms', ':saveas t<BS>--mtg.yaml<Left><Left><Left><Left><Left><Left><Left><Left><Left>', '')
call map#Keys('n', '=mi', '=md=ms', '')
"}}}

"--- map foldcolumn keys   {{{
call map#Keys('ni', 'fco', ':set foldcolumn=2<CR>')  " turn on foldcolumn
call map#Keys('ni', 'fcf', ':set foldcolumn=0<CR>')  " turn off foldcolumn
call map#Keys('ni', 'fc+', ':set foldcolumn+=1<CR>') " widen foldcolumn
call map#Keys('ni', 'fc-', ':set foldcolumn-=1<CR>') " shrink foldcolumn
"}}}

"--- open <cfile> [at linenum] in vsplit   {{{
call map#Keys('ni', 'gf', ':vertical windcmd f<CR>')
call map#Keys('ni', 'gF', ':vertical windcmd F<CR>') " to linenum
"}}}

"--- terminal 'termkey'  {{{
call map#Keys('t', '<C-W>gt', '<C-W>:tabnext<cr>', '')
call map#Keys('t', '<C-W>gT', '<C-W>:tabprev<cr>', '')
call map#Keys('t', '<C-W><Space>', '<C-W>:CtrlSpace<cr>', '')
"}}}

" vim: set ft=vim ts=2 sw=2 tw=100 et fdm=marker:
