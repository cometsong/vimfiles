"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
"    Cometsong's composed and composited vimrc file.     "
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

" User Variables
let g:username = 'cometsong'
let g:author   = "Benjamin Leopold (cometsong)"
let g:email    = 'benjamin(at)cometsong(dot)net'
let g:license  = 'GPL v3 http://www.gnu.org/licenses/gpl-3.0.txt'
let g:github   = 'https://github.com/cometsong'
let g:gitrepos = 'https://git.cometsong.net'


"""--- (pythonx bug in some vim versions)
"silent pyx 'print();'
silent call has('python3')


"""--- Vim Options
runtime config/vim_options.vim

"""--- Key Mapping
runtime config/key_mapping.vim

"""--- Folding
runtime config/folding.vim

"""--- Autocmds
runtime config/autocmds.vim

"""--- We Are Plugged In!
runtime config/plugins.vim

"""--- Set Colors
"colorscheme flattened_dark
colorscheme landscape
set background=dark

