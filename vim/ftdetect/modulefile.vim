autocmd BufNewFile,BufReadPre,BufReadPost if match(getline(1),"#%Module") >= 0 | set ft=tcl | endif
autocmd BufNewFile,BufReadPre,BufReadPost modulefiles/*                          set ft=tcl


