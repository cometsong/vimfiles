"--- Key Mapping

"--- if Leader=\ then set 2xLeader=\ (to allow fast typing of the <Leader>  {{{
"---    instead of waiting for vim to catch up with you.)
"call MapKeys('i', '<Leader><Leader>', '<Leader>', '')
inoremap <Leader><Leader> <Leader>
"}}}

"--- cd to dir of current buffer  {{{
" The current directory is the directory of the file in the current window.
call MapKeys('n', 'lcd', ':lchdir %:p:h<CR>')   " map \lcd to lchdir to dir of current buffer
"}}}

"--- Fast editing of vimrc  {{{
call MapKeys('n', 'vi', ':vsplit $MYVIMRC<cr>')
amenu <silent> .999 &Cometsong.Edit\ &vimrc\ <Tab>vi  <Leader>vi   " Cometsong Menu!
"}}}

"--- Edit hotkey command appends current dir to :e, :sp, :vsp {{{
cnoremap %% <C-R>=expand('%:h').'/'<cr>
call MapKeys('n', 'ee', ':e %%')
call MapKeys('n', 'es', ':sp %%')
call MapKeys('n', 'ev', ':vsp %%')
"}}}

"--- set capital Y to do same as D&C, yank to end of line {{{
call MapKeys('n', 'Y', 'y$', '')
"}}}

"--- Make p in Visual mode replace the selected text with the "" register.  {{{
call MapKeys('v', 'p', '<Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>', '')
"}}}

"--- Wrap Setup {{{
set showbreak=\ …\  " shows at beginning of each wrapped line
set cpoptions+=n    " sets the showbreak in between the line numbers
command! -nargs=* Wrap set wrap linebreak nolist
command! -nargs=* WrapOff set nowrap nolinebreak
call MapKeys('ni', 'w', ':set wrap!<CR>')
amenu .110 &Cometsong.&Wraps.Wrap<Tab>w  :set wrap!<CR>
call MapKeys('ni', 'l', ':set linebreak!<CR>')
amenu .110 &Cometsong.&Wraps.&Linebreak<Tab>l :set linebreak!<CR>
call MapKeys('ni', 'wl', ':set wrap!<CR> :set linebreak!<CR>')
amenu .110 &Cometsong.&Wraps.&Wrap\ \&\ Linebreak<Tab>wl  :set wrap!<CR> :set linebreak!<CR>
"}}}

"--- Pastin' Setup {{{
call MapKeys('ni', 'p', ':set paste!<CR>')
amenu <silent> .210 &Cometsong.&Paste\ mode<Tab>p  <Leader>p
"}}}

"--- Buffer Access Setup  {{{
call MapKeys('ni', "<C-PageUp>",   ':bprev<CR>', '')
call MapKeys('ni', "<C-PageDown>", ':bnext<CR>', '')
call MapKeys('ni', "<C-Up>",       ':bprev<CR>', '')
call MapKeys('ni', "<C-Down>",     ':bnext<CR>', '')
call MapKeys('ni', "<C-k>",        ':bprev<CR>', '')
call MapKeys('ni', "<C-j>",        ':bnext<CR>', '')
"}}}

"--- datetime stamps  {{{
call MapKeys('ni', 'dts', '"=strftime("%Y%m%d_%H%M%S")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.&Datetime:\ ccyymmdd_hhmiss<Tab>dts          <Leader>dts
call MapKeys('ni', 'dtz', '"=strftime("%F %T%z")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.&Datetime:\ ccyy-mm-dd\ hh:mi:ss+tz<Tab>dtz  <Leader>dtz
"--- date stamps
call MapKeys('ni', 'ymd', '"=strftime("%Y%m%d")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Date:\ ccyymmdd<Tab>ymd                      <Leader>ymd
call MapKeys('ni', 'ymd-', '"=strftime("%Y-%m-%d")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Date:\ ccyy-mm-dd<Tab>ymd-                   <Leader>ymd-
call MapKeys('ni', 'dny', '"=strftime("%d-%b-%Y")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Date:\ dd-mon-ccyy<Tab>dny                   <Leader>dny
"--- time stamps
call MapKeys('ni', 'tz', '"=strftime("%T%z")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Time:\ hh:mi:ss+tz<Tab>tz                    <Leader>tz
call MapKeys('ni', 'ts', '"=strftime("%H%M%S")<CR>p')
amenu <silent> .110 &Cometsong.&Dating.Time:\ hhmiss<Tab>ts                         <Leader>ts
"}}}

"--- ignorecase {{{
set ignorecase
set smartcase
call MapKeys('ni', 'ic', ':set ignorecase!<CR>')
amenu .350 &Cometsong.&Ignore\ Case<Tab>ic  <Leader>ic
call MapKeys('ni', 'sc', ':set smartcase!<CR>')
amenu .350 &Cometsong.&Smart\ Case<Tab>sc  <Leader>sc
"}}}

"--- operating system clipboard {{{
" see set clipboard in settings
call MapKeys('n', ',y', '"+y') " copy
call MapKeys('n', ',x', '"+x') " cut
call MapKeys('n', ',p', '"+p') " paste
"}}}

"--- Q=quit-all instead of going to Ex mod  {{{
call MapKeys('n', 'Q', ':qa<CR>', '')
"}}}

"--- List chars  {{{
call MapKeys('ni', 'li', ':set list!<CR>') " Toggle invisible chars
amenu <silent> .900 &Cometsong.Show\ &invisible\ chars\ <Tab>li   <Leader>li   " Cometsong Menu!
"}}}

"--- Cursor column and line show/hide  {{{
if v:version > 700
  set nocursorline
  set nocursorcolumn
  hi  CursorLine   cterm=underline ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=undercurl
  hi  CursorColumn cterm=underline ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=undercurl
  call MapKeys('ni', 'curt', ':set cursorcolumn! cursorline! <CR>')
  amenu <silent> .500 &Cometsong.&Cursor\ position\ toggle<Tab>curt     <Leader>curt
endif
"}}} --------------------------------------------------------------------------

"--- matchit   {{{
call MapKeys('n', ',mi', ':runtime macros/matchit.vim<CR>') " run the macros matchit (% for if/endif,etc)
amenu <silent> .900 &Cometsong.Matchit<Tab>,mi   <Leader>,mi   " Cometsong Menu!
"}}}

"--- Spell Checking   {{{
call MapKeys('ni', 'sp', ':set spell!<CR>') " toggle spelling
amenu <silent> .59 &Cometsong.Spell\ Checking\ Toggle<Tab>sp   <Leader>sp   " Cometsong Menu!
"}}}

"--- ScratchToggle   {{{
call MapKeys('ni', 'ts', ':ScratchToggle<CR>')
amenu <silent> .61 &Cometsong.ScratchToggle<Tab>ts   <Leader>ts   " Cometsong Menu!
"}}}

"--- Remove EOL spaces   {{{
call MapKeys('ni', 'ers', ':%s/\s\+$//<CR>')
amenu <silent> .61 &Cometsong.Remove\ EOL\ Spaces<Tab>ers   <Leader>ers   " Cometsong Menu!
"}}}

"--- QuickRun   {{{
call MapKeys('niv', 'qr', ':QuickRun<CR>')
amenu <silent> .66 &Cometsong.QuickRun\ file<Tab>qr   <Leader>qr   " Cometsong Menu!
"}}}

"--- JSON   {{{
call MapKeys('niv', '=j', ':%!python -m json.tool<CR>', '')
amenu <silent> .901 &Cometsong.Format\ JSON\ buffer<Tab>\=j   =j   " Cometsong Menu!
"}}}

"--- JAX work mappings {{{
command! MinutesDatestamp normggo- datetime: "\dtzggO\dtsyiw"tdd/event<CR>$diW
call MapKeys('n', '=md', ':MinutesDatestamp<CR>', '')
call MapKeys('n', '=ms', ':saveas t<BS>--mtg.yaml<Left><Left><Left><Left><Left><Left><Left><Left><Left>', '')
call MapKeys('n', '=mi', '=md=ms', '')
"}}}
