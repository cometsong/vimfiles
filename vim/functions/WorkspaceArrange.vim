" found orig on: https://gist.github.com/Garoth/4a44202d3515705917a1
function! WorkspaceArrange()
    " Rough num columns to decide between laptop and big monitor screens
    let numcol = 2
    if winwidth(0) >= 220
        let numcol = 3
    endif

    if numcol == 3
        e term://bash
        file Shell
        vnew
    endif

    leftabove vsp | Dirvish
    "file | Dirvish
    sp enew
    file empty
    wincmd k
    resize 4
    wincmd h
endfunction
command! -register WorkspaceArrange call WorkspaceArrange()
command! -register Workspace call WorkspaceArrange()
nnoremap <leader>wk :WorkspaceArrange<CR>
