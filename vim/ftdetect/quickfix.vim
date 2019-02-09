autocmd BufNewFile,BufRead if match(getline(1),"#quickfix") >= 0 | set ft=qf | endif
autocmd BufNewFile,BufRead *.qf,*.quickfix,*.fof                   set ft=qf
