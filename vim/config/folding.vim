"--- Folding

set foldenable
" levels to show unfolded
set foldlevel=0
" show folds in left column
set foldcolumn=0

" prettify default foldtext!
highlight FoldColumn term=standout ctermfg=grey ctermbg=black guifg=#777777 guibg=#010F01
highlight Folded     term=standout ctermfg=LightYellow ctermbg=DarkGrey guifg=#777777 guibg=#010F01

" map create,un/fold existing folds
call MapKeys('ni', '<F8>', 'za', '')      " toggle fold open/closed
call MapKeys('ni', '<S-F8>', 'zA', '')    " toggle fold open/closed recursively
call MapKeys('ni', '<C-S-F8>', 'zM', '')  " close all folds
call MapKeys('ni', '<C-F8>', 'zR', '')    " open all folds

call MapKeys('nv', '<F7>', 'zf', '')      " create fold (with count or direction or visual)
call MapKeys('nv', '<C-F7>', 'zd', '')    " delete fold
call MapKeys('nv', '<C-S-F7>', 'zD', '')  " delete folds recursively

" map foldcolumn keys
call MapKeys('ni', 'fco', ':set foldcolumn=2<CR>')  " turn on foldcolumn
call MapKeys('ni', 'fcf', ':set foldcolumn=0<CR>')  " turn off foldcolumn
call MapKeys('ni', 'fc+', ':set foldcolumn+=1<CR>') " widen foldcolumn
call MapKeys('ni', 'fc-', ':set foldcolumn-=1<CR>') " shrink foldcolumn

