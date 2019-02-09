"--- Folding

""" prettify default foldtext!
highlight FoldColumn term=standout ctermfg=grey ctermbg=black guifg=#777777 guibg=#010F01
highlight Folded     term=standout ctermfg=LightYellow ctermbg=DarkGrey guifg=#777777 guibg=#010F01

""" vim:fdm=expr:fdl=0:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
