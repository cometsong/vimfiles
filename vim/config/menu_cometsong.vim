"--- Cometsong Menu Init!
" TODO create menus for my own schmancy plugins

" following line gives error on re-sourcing vimrc
"aunmenu Cometsong

menu 1411.10 &Cometsong.-Views- :
" items 11-98 are view/buffer toggles
amenu .99 &Cometsong.-Submenus- :
" items 100-198 are submenus
amenu .199 &Cometsong.-Switches- :
" items 200+ are misc switches


"---- Menu entries for HotKeys listed... TODO bother to fix this, just for fun :)  {{{
function! ListMenuItems ()
  let menu_name = "&Cometsong"
  let file_name = $MYVIMRC
  let theleader = exists('mapleader') ? mapleader : '<ldr>'
  "echo 'leader: ' theleader

  let menu_list = 'grep -h "' . menu_name . '" ' . file_name . '| grep -v "'. menu_name .'^\.-"'
  let menu_show = '!'. menu_list .' | sed -E "s/^.*(\' . menu_name . '\.)//" '
"  .
"     \ '| sed -e "s/^.*(\' . menu_name . ')//"' .
"     \ '| sed -e "s/\\//"'

  echo menu_list
  echo menu_show
  execute menu_show
endfunction
"}}}

" all items in menu are coded with the corresponding keymaps
"amenu .1111 &Cometsong.All\ My\ Shortcuts!  :echo "how do I show the maps specific to this menu?"<CR>

