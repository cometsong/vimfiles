" tree - an abstruct treeview 
"
" Author:  Wind 
" Date:  2004-11-24  
" Email:  wind-xp@tut.by 
" Version:  1.0 
"


" buffer variables
" b:Tree_InitOptionsFunction () :void -  a function for option initialization
" b:Tree_ColorFunction () :void -  a function for highlighting deinition
" b:Tree_InitMappingsFunction () :void -  a function for initializing mappings
" b:Tree_pathSeparator :char path separator
" b:Tree_IsLeafFunction (path):boolean true if it has no subnodes false otherwise
" b:Tree_GetSubNodesFunction (path):string[] - returns list of strings separated with "\n"
" b:Tree_OnLeafClick (path):void - do somthing on the click on a leaf 
" b:Tree_OnPathChange (path):void - do somthing when path is changed 


" global variables

let Tree_VERSION='1.0'
let Tree_VerticalSplit=1
let Tree_HorizontalSplit=0
let Tree_Right=1
let Tree_Left=0
let Tree_Top=0
let Tree_Below=1

" global functions
function! Tree_NewTreeWindow (initialPath, orientation,side,minWidth,minHeigh,initOptionsFunctnion) "{{{1
	" setup options
	" create new window
	if a:orientation "{{{2
		let splitcmd=a:minWidth.'vnew'
	else
		let splitcmd=a:minHeigh.'new'
	end "}}}2
	" save splitright state
	let SPR=&splitright
	let SPB=&splitbelow
	let &splitright=a:side
	let &splitbelow=a:side
	exe splitcmd
	exe "setlocal wiw=".a:minWidth
	exe "setlocal wh=".a:minHeigh
	let &splitright=SPR
	let &splitbelow=SPB
	setlocal nowrap
	" in the new buffer
	let b:Tree_InitOptionsFunction=a:initOptionsFunctnion
	call <SID>Init()
	call <SID>BuildTree (a:initialPath)
endfunction "}}}1

function! Tree_RebuildTree () "{{{1
	call <SID>BuildTree (getline (1))
endfunction "}}}1

function! Tree_SetPath (path) "{{{1
	call <SID>BuildTree (a:path)
endfunction "}}}1

function! Tree_GetPathUnderCursor () "{{{1
	normal 1|g^
	let xpos=col ('.')-1
	let ypos=line ('.')
	return <SID>GetPathName (xpos,ypos)
endfunction "}}}1

function! GetNextLine (text) "{{{1
	let pos=match (a:text,"\n")
	return strpart (a:text,0,pos)
endfunction "}}}1

function! CutFirstLine (text) "{{{1
	let pos=match (a:text,"\n")
	return strpart (a:text,pos+1,strlen (a:text))
endfunction "}}}1

function! DummyFunction (...) "{{{1
endfunction "}}}1

" script private functions  

function! s:Init() "{{{1
	let b:Tree_pathSeparator='/'
	let b:Tree_ColorFunction="DummyFunction"
	let b:Tree_InitMappingsFunction="DummyFunction"
	let b:Tree_IsLeafFunction="DummyFunction"
	let b:Tree_GetSubNodesFunction="DummyFunction"
	let b:Tree_OnLeafClick="DummyFunction"
	let b:Tree_OnPathChange="DummyFunction"
	call <SID>InitOptions ()
	call <SID>InitColors ()
	call <SID>InitMappings ()
endfunction "}}}1

function! s:InitMappings () "{{{1
	exec "call ".b:Tree_InitMappingsFunction."()"
	noremap <silent> <buffer> <LeftRelease> :call <SID>OnClick ()<CR>
	noremap <silent> <buffer> <CR> :call <SID>OnDoubleClick ()<CR>
	noremap <silent> <buffer> <Down> :call <SID>GotoNextEntry ()<CR>
	noremap <silent> <buffer> <Up> :call <SID>GotoPrevEntry ()<CR>
	noremap <silent> <buffer> <S-Down> :call <SID>GotoNextNode ()<CR>
	noremap <silent> <buffer> <S-Up> :call <SID>GotoPrevNode ()<CR>
	noremap <silent> <buffer> <BS> :call <SID>BuildParentTree ()<CR>
	noremap <silent> <buffer> q :call <SID>CloseExplorer ()<CR>
endfunction "}}}1

function! s:InitOptions () "{{{1
	execute "call ".b:Tree_InitOptionsFunction."()"
endfunction "}}}1

function! s:InitColors () "{{{1 
	execute "call ".b:Tree_ColorFunction."()"
endfunction "}}}1

function! s:BuildTree (initialPath) "{{{1
	let path=a:initialPath
	" unlock bufer
	call <SID>UnLockBuffer()
	" clean up
	normal ggdGd
	call setline (1,path)
	call <SID>LockBuffer()
	call <SID>TreeExpand (-1,1,path)
	" move to first entry
	norm ggj1|g^
	execut 'call '.b:Tree_OnPathChange."('".path."')"
endfunction "}}}1

function! s:TreeExpand (xpos,ypos,path) "{{{1
	let path=a:path
	" first get all subdirectories
	let nodelist=s:GetSubNodes (path)."\n"
	call s:AppendSubNodes(a:xpos,a:ypos,nodelist)
endfunction "}}}1

function! s:AppendSubNodes(xpos,ypos,nodeList) "{{{1
	call s:UnLockBuffer()
	" turn + into -
	if a:ypos!=1 "{{{2
		"normal ^
		if getline(a:ypos)[a:xpos]=='+'  "{{{3
			normal r-
		else
			normal hxi-
		endif "}}3
	endif "}}}2
	let nodeList=a:nodeList
	let row=a:ypos
	while strlen (nodeList)>0 "{{{2
		" get next line
		let entry=GetNextLine (nodeList)
		let nodeList=CutFirstLine (nodeList)
		" add to tree 
		if entry!="" "{{{3 "spacing acordinally to type of the entry
			if s:IsLeaf(entry) "{{{4
				let entry=s:SpaceString (a:xpos+2).entry
			else
				let entry=s:SpaceString (a:xpos+1)."+".entry
			endif "}}}4
			call append (row,entry)
			let row=row+1
		endif "}}}3
	endw "}}}2
	call s:LockBuffer()
endfunction "}}}1

function! s:LockBuffer() "{{{1
	setlocal nomodifiable nomodified
endfunction "}}}1

function! s:UnLockBuffer() "{{{1
	setlocal modifiable
endfunction "}}}1

function! s:GetSubNodes (path) "{{{1
	execute "return ".b:Tree_GetSubNodesFunction.'(a:path)'
endfunction "}}}1

function! s:SpaceString (width) "{{{1
	let spacer=""
	let width=a:width
	while width>0
		let spacer=spacer." "
		let width=width-1
	endwhile
	return spacer
endfunction "}}}1

function! s:IsLeaf (path) "{{{1
	execute "return ".b:Tree_IsLeafFunction.'(a:path)'
endfunction "}}}1

function! s:TreeNodeAction (xpos,ypos) "{{{1
	if getline (a:ypos)[a:xpos] == '+'
		call s:TreeExpand (a:xpos,a:ypos, s:GetPathName (a:xpos,a:ypos))
	elseif getline (a:ypos)[a:xpos] == '-'
		call s:TreeCollapse (a:xpos,a:ypos)
	end
endfunction "}}}1

function! s:IsTreeNode (xpos,ypos) "{{{1
	if getline (a:ypos)[a:xpos] =~ '[+-]'
		" is it a directory or file starting with +/- ?
		"let path=s:GetPathName (a:xpos,a:ypos)
		"if s:IsLeaf (path)
		"	return 0
		"else
		return 1
		"end
	else
		return 0
	end
endfunction "}}}1

function! s:GetPathName (xpos,ypos) "{{{1
	let xpos=a:xpos
	let ypos=a:ypos
	" check for directory..
	if getline (ypos)[xpos]=~"[+-]" "{{{2
		let path=b:Tree_pathSeparator.strpart (getline (ypos),xpos+1,col ('$'))
	else
		" otherwise filename
		let path=b:Tree_pathSeparator.strpart (getline (ypos),xpos,col ('$'))
		let xpos=xpos-1
	end "}}}2
	" walk up tree and append subpaths
	let row=ypos-1
	let indent=xpos
	while indent>0 "{{{2
		" look for prev ident level
		let indent=indent-1
		while getline (row)[indent] != '-' "{{{3
			let row=row-1
			if row == 0 "{{{4
				return ""
			end "}}}4
		endwhile "}}}3
		" subpath found, append
		let path=b:Tree_pathSeparator.strpart (getline (row),indent+1,strlen (getline (row))).path
	endwhile  "}}}2
	" finally add base path
	" not needed, if in root
	"if getline (1)!=b:Tree_pathSeparator "{{{2
	if a:ypos>1 "{{{2
		let path=getline (1).path
	end "}}}2
	return path
endfunction "}}}1

function! s:TreeCollapse (xpos,ypos) "{{{1
	call <SID>UnLockBuffer ()
	" turn - into +, go to next line
	let entry=substitute(getline(a:ypos),'^\s*+','','')
	if s:IsLeaf(entry)
		normal ^r j
	else
		normal ^r+j
	end
	" delete lines til next line with same indent
	while (getline ('.')[a:xpos+1] =~ '[ +-]') && (line ('$') != line ('.')) "{{{2
		norm dd
	endwhile "}}}2
	" go up again
	normal k
	call <SID>LockBuffer()
endfunction "}}}1

function! s:CloseExplorer () "{{{1
	wincmd c
endfunction "}}}1

function! s:BuildParentTree () "{{{1
	normal gg$F/
	call <SID>OnDoubleClick ()
endfunction "}}}1

function! s:GotoNextNode () "{{{1
	" in line 1 like next entry
	if line ('.')==1 "{{{2
		call s:GotoNextEntry ()
	else
		normal j1|g^
		while getline ('.')[col ('.')-1] !~ "[+-]" && line ('.')<line ('$') "{{{3
			normal j1|g^
		endwhile "}}}3
	endif "}}}2
endfunction "}}}1

function! s:GotoPrevNode () "{{{1
	" entering base path section?
	if line ('.')<3 "{{{2
		call <SID>GotoPrevEntry ()
	else
		normal k1|g^
		while getline ('.')[col ('.')-1] !~ "[+-]" && line ('.')>1 "{{{3
			normal k1|g^
		endwhile "}}}3
	endif "}}}2
endfunction "}}}1

function! s:GotoNextEntry () "{{{1
	let xpos=col ('.')
	" different movement in line 1
	if line ('.')==1 "{{{2
		" if over slash, move one to right
		if getline ('.')[xpos-1]==b:Tree_pathSeparator "{{{3
			normal l
			" only root path there, move down
			if col ('.')==1 "{{{4
				norm j1|g^
			end "}}}4
		else
			" otherwise after next slash
			execute "norm f".b:Tree_pathSeparator."l"
			" if already last path, move down
			if col ('.')==xpos "{{{4
				norm j1|g^
			endif "}}}4
		endif "}}}3
	else
		" next line, first nonblank
		normal j1|g^
	endif "}}}2
endf "}}}1

function! s:GotoPrevEntry () "{{{1
	" different movement in line 1
	if line ('.')==1 "{{{2
		" move after prev slash
		exec "norm hF".b:Tree_pathSeparator."l"
	else
		" enter line 1 at the end
		if line ('.')==2 "{{{3
			exec 'norm k$F'.b:Tree_pathSeparator.'l'
		else
			" prev line, first nonblank
			normal k1|g^
		endif "}}}3
	endif "}}}2
endfunction "}}}1

"

"TODO rewrite this function ( I do not like how it looks like)
function! s:OnDoubleClick () "{{{1
	let xpos=col ('.')-1
	let ypos=line ('.')
	" clicked on node
	if s:IsTreeNode (xpos,ypos) "{{{2
		call s:TreeNodeAction (xpos,ypos)
	else
		" go to first non-blank when line>1
		if ypos>1 "{{{3
			normal 1|g^
			let xpos=col ('.')-1
			" check, if it's a directory
			let path=<SID>GetPathName (xpos,ypos)
			if !<SID>IsLeaf (path) "{{{4
				" build new root structure
				call <SID>BuildTree (path)
			else
				" try to resolve filename
				" and open in other window
				let path=<SID>GetPathName(xpos,ypos)
				call <SID>OnLeafClick(path)
			end "}}}4
		else
			" we're on line 1 here! getting new base path now...
			" advance to next slash
			if getline (1)[xpos]!=b:Tree_pathSeparator "{{{4
				execute "normal f".b:Tree_pathSeparator
				" no next slash -> current directory, just rebuild
				if col ('.')-1==xpos "{{{5
					call <SID>BuildTree (getline (1))
					return
				end "}}}5
			end "}}}4
			" cut ending slash
			normal h
			" rebuild tree with new path
			call <SID>BuildTree (strpart (getline (1),0,col ('.')))
		en "}}}3
	end "}}}2
endfunction "}}}1

function! s:OnClick () "{{{1
	let xpos=col ('.')-1
	let ypos=line ('.')
	if s:IsTreeNode (xpos,ypos) "{{{2
		call s:TreeNodeAction (xpos,ypos)
	endif "}}}2
endfunction "}}}1

function! s:OnLeafClick (path) "{{{1
	execute "call ".b:Tree_OnLeafClick."('".a:path."')"
endfunction "}}}1
" vim:fdm=marker:
