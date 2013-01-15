"--- Sessions

" Sets what is saved when you save a session
set sessionoptions=blank,buffers,curdir,folds,resize,localoptions,winsize
set sessionoptions-=help,options,tabpages


"---- map and menu  {{{
call MapKeys('ni', 'sv', ':SaveSession')
amenu <silent> .190 &Cometsong.&Sessions.&Save\ Session<Tab>sv  <Leader>sv
call MapKeys('ni', 'ss', ':call SaveSessionFolds()<CR>')
amenu <silent> .190 &Cometsong.&Sessions.&Save\ Session\ with\ Folds<Tab>ss  <Leader>ss
call MapKeys('ni', 'so', ':OpenSession')
amenu <silent> .190 &Cometsong.&Sessions.&Open\ Session<Tab>so  <Leader>so

call MapKeys('ni', 'wv', ':exe "wviminfo! ".v:this_session.".viminfo"<CR>')
amenu <silent> .190 &Cometsong.&Sessions.&Write\ viminfo<Tab>wv  <Leader>wv
call MapKeys('ni', 'rv', ':exe "rviminfo! ".v:this_session.".viminfo"<CR>')
amenu <silent> .190 &Cometsong.&Sessions.&Read\ viminfo<Tab>rv  <Leader>rv
"}}}

 "noremap <Leader>ms       :mksession! ~/.vimsessions/untitled.vim<CR>
"inoremap <Leader>ms  <C-C>:mksession! ~/.vimsessions/untitled.vim<CR>

"--- if v:this_session, also save marks to the same folder (for use with 'bin/vims')
"au VimLeave * exe 'if strlen(v:this_session) | exe "wviminfo!  " . v:this_session . ".viminfo" | endif '
"au VimLeave * exe 'if strlen(v:this_session) | exe "mksession! " . v:this_session | endif '

" also see vim-session plugin options


