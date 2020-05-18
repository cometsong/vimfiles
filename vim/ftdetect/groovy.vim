autocmd BufNewFile,BufRead *.groovy   set ft=groovy

autocmd BufNewFile,BufRead if match(getline(1),"nextflow") >= 0 | set ft=groovy.nextflow | endif
autocmd BufNewFile,BufRead *.nf,*nextflow*.config     set ft=groovy.nextflow

