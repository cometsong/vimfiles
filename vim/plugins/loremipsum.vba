" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
autoload/loremipsum.vim	[[[1
157
" loremipsum.vim
" @Author:      Thomas Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2008-07-10.
" @Last Change: 2008-07-11.
" @Revision:    0.0.138

if &cp || exists("loaded_loremipsum_autoload")
    finish
endif
let loaded_loremipsum_autoload = 1
let s:save_cpo = &cpo
set cpo&vim

" http://www.lorem-ipsum-dolor-sit-amet.com/lorem-ipsum-dolor-sit-amet.html
let s:data = expand('<sfile>:p:h') .'/loremipsum.txt'


function! s:GetWords(nwords, splitrx, join) "{{{3
    if exists('b:loremipsum_file')
        let file = b:loremipsum_file
    else
        let file = get(g:loremipsum_files, &spelllang, s:data)
    endif
    let text  = split(join(readfile(file), "\n"), a:splitrx)
    let start = (localtime() * -23) % (len(text) - a:nwords)
    let start = start < 0 ? -start : start
    let out   = join(text[start : start + a:nwords], a:join)
    let out   = substitute(out, '^\s*\zs\S', '\u&', '')
    if out !~ '\.\s*$'
        let out = substitute(out, '[[:punct:][:space:]]*$', '.', '')
    endif
    return out
endf


function! s:NoInline(flags) "{{{3
    return get(a:flags, 0, 0)
endf


function! s:WrapMarker(marker, text) "{{{3
    if len(a:marker) >= 2
        let [pre, post; flags] = a:marker
        if type(a:text) == 1
            if s:NoInline(flags)
                return a:text
            else
                return pre . a:text . post
            endif
        else
            call insert(a:text, pre)
            call add(a:text, post)
            return a:text
        endif
    else
        return a:text
    endif
endf


function! loremipsum#Generate(nwords, template) "{{{3
    let out = s:GetWords(a:nwords, '\s\+\zs', '')
    let paras = split(out, '\n')
    if empty(a:template) || a:template == '*'
        let template = get(g:loremipsum_paragraph_template, &filetype, '')
    elseif a:template == '_'
        let template = ''
    else
        let template = a:template
    endif
    if !empty(template)
        call map(paras, 'v:val =~ ''\S'' ? printf(template, v:val) : v:val')
    end
    return paras
endf


function! loremipsum#GenerateInline(nwords) "{{{3
    let out = s:GetWords(a:nwords, '[[:space:]\n]\+', ' ')
    " let out = substitute(out, '[[:punct:][:space:]]*$', '', '')
    " let out = substitute(out, '[.?!]\(\s*.\)', ';\L\1', 'g')
    return out
endf


" :display: loremipsum#Insert(?inline=0, ?nwords=100, " ?template='', ?pre='', ?post='')
function! loremipsum#Insert(...) "{{{3
    let inline = a:0 >= 1 ? !empty(a:1) : 0
    let nwords = a:0 >= 2 ? a:2 : g:loremipsum_words
    let template = a:0 >= 3 ? a:3 : ''
    if a:0 >= 5
        let marker = [a:4, a:5]
    elseif a:0 >= 4
        if a:4 == '_'
            let marker = []
        else
            echoerr 'Loremipsum: No postfix defined'
        endif
    else
        let marker = get(g:loremipsum_marker, &filetype, [])
    endif
    " TLogVAR inline, nwords, template
    if inline
        let t = @t
        try
            let @t = s:WrapMarker(marker, loremipsum#GenerateInline(nwords))
            norm! "tp
        finally
            let @t = t
        endtry
    else
        let text = s:WrapMarker(marker, loremipsum#Generate(nwords, template))
        let lno  = line('.')
        if getline(lno) !~ '\S'
            let lno -= 1
        endif
        call append(lno, text)
        exec 'norm! '. lno .'gggq'. len(text) ."j"
    endif
endf


function! loremipsum#Replace(...) "{{{3
    let replace = a:0 >= 1 ? a:1 : ''
    if a:0 >= 3
        let marker = [a:2, a:3]
    else
        let marker = get(g:loremipsum_marker, &filetype, [])
    endif
    if len(marker) >= 2
        let [pre, post; flags] = marker
        let pre  = escape(pre, '\/')
        let post = escape(post, '\/')
        if s:NoInline(flags)
            let pre  = '\^\s\*'. pre  .'\s\*\n'
            let post = '\n\s\*'. post .'\s\*\n'
            let replace .= "\<c-m>"
        endif
        let rx  = '\V'. pre .'\_.\{-}'. post
        let rpl = escape(replace, '\&~/')
        let sr  = @/
        try
            " TLogVAR rx, rpl
            exec '%s/'. rx .'/'. rpl .'/ge'
        finally
            let @/ = sr
        endtry
    else
        echoerr 'Loremipsum: No marker for '. &filetype
    endif
endf


let &cpo = s:save_cpo
unlet s:save_cpo
autoload/loremipsum.txt	[[[1
127
Lorem ipsum dolor sit amet...

Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis splople autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi.

Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.

Nunc varius risus quis nulla. Vivamus vel magna. Ut rutrum. Aenean dignissim, leo quis faucibus semper, massa est faucibus massa, sit amet pharetra arcu nunc et sem. Aliquam tempor. Nam lobortis sem non urna. Pellentesque et urna sit amet leo accumsan volutpat. Nam molestie lobortis lorem. Quisque eu nulla. Donec id orci in ligula dapibus egestas. Donec sed velit ac lectus mattis sagittis.

In hac habitasse platea dictumst. Maecenas in ligula. Duis tincidunt odio sollicitudin quam. Nullam non mauris. Phasellus lacinia, velit sit amet bibendum euismod, leo diam interdum ligula, eu scelerisque sem purus in tellus.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. In sit amet nunc id quam porta varius. Ut aliquet facilisis turpis. Etiam pellentesque quam et erat. Praesent suscipit justo.

Cras nec metus pulvinar sem tempor hendrerit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nullam in nulla. Mauris elementum. Curabitur tempor, quam ac rutrum placerat, nunc augue ullamcorper est, vitae molestie neque nunc a nunc. Integer justo dolor, consequat id, rutrum auctor, ullamcorper sed, orci. In hac habitasse platea dictumst. Fusce euismod semper orci. Integer venenatis quam non nunc. Vivamus in lorem a nisi aliquet commodo. Suspendisse massa lorem, dignissim at, vehicula et, ornare non, libero. Donec molestie, velit quis dictum scelerisque, est lectus hendrerit lorem, eget dignissim orci nisl sit amet massa. Etiam volutpat lobortis eros. Nunc ac tellus in sapien molestie rhoncus. Pellentesque nisl. Praesent venenatis blandit velit. Fusce rutrum. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque vitae erat. Vivamus porttitor cursus lacus. Pellentesque tellus. Nunc aliquam interdum felis. Nulla imperdiet leo. Mauris hendrerit, sem at mollis pharetra, leo sapien pretium elit, a faucibus sapien dolor vel pede. Vestibulum et enim ut nulla sollicitudin adipiscing. Suspendisse malesuada venenatis mauris. Curabitur ornare mollis velit. Sed vitae metus. Morbi posuere mi id odio. Donec elit sem, tempor at, pharetra eu, sodales sit amet, elit.

Curabitur urna tellus, aliquam vitae, ultrices eget, vehicula nec, diam. Integer elementum, felis non faucibus euismod, erat massa dictum eros, eu ornare ligula tortor et mauris. Cras molestie magna in nibh. Aenean et tellus. Fusce adipiscing commodo erat. In eu justo. Nulla dictum, erat sed blandit venenatis, arcu dolor molestie dolor, vitae congue orci risus a nulla. Pellentesque sit amet arcu. In mattis laoreet enim. Pellentesque id augue et arcu blandit tincidunt. Pellentesque elit ante, rhoncus quis, dapibus sit amet, tincidunt eu, nibh. In imperdiet. Nunc lectus neque, commodo eget, porttitor quis, fringilla quis, purus.

Duis sagittis dignissim eros. In sit amet lectus. Fusce lacinia mauris vitae nisl interdum condimentum. Etiam in magna ac nibh ultrices vehicula. Maecenas commodo facilisis lectus. Praesent sed mi. Phasellus ipsum. Donec quis tellus id lectus faucibus molestie. Praesent vel ligula. Nam venenatis neque quis mauris. Proin felis. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam quam. Nam felis velit, semper nec, aliquam nec, iaculis vel, mi. Nullam et augue vitae nunc tristique vehicula. Suspendisse eget elit. Duis adipiscing dui non quam.

Duis posuere tortor sit amet est iaculis egestas. Ut at magna. Etiam dui nisi, blandit quis, fermentum vitae, auctor vel, sem. Cras et leo. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Proin luctus, odio eu porttitor adipiscing, ante elit tristique tortor, sit amet malesuada tortor nisi sit amet neque. Praesent rhoncus eros non velit. Pellentesque mattis. Sed sit amet ante. Mauris ac nibh eget risus volutpat tempor. Praesent volutpat sollicitudin dui. Sed in tellus id urna viverra commodo. Vestibulum enim felis, interdum non, sollicitudin in, posuere a, sem. Cras nibh.

Sed facilisis ultrices dolor. Vestibulum pretium mauris sed turpis. Phasellus a pede id odio interdum elementum. Nam urna felis, sodales ut, luctus vel, condimentum vitae, est. Vestibulum ut augue. Nunc laoreet sapien quis neque semper dictum. Phasellus rhoncus est id turpis. Vestibulum in elit at odio pellentesque volutpat. Nam nec tortor. Suspendisse porttitor consequat nulla. Morbi suscipit tincidunt nisi. Sed laoreet, mauris et tincidunt facilisis, est nisi pellentesque ligula, sit amet convallis neque dolor at sapien. Aenean viverra justo ac sem.

Pellentesque at dolor non lectus sagittis semper. Donec quis mi. Duis eget pede. Phasellus arcu tellus, ultricies id, consequat id, lobortis nec, diam. Suspendisse sed nunc. Pellentesque id magna. Morbi interdum quam at est. Maecenas eleifend mi in urna. Praesent et lectus ac nibh luctus viverra. In vel dolor sed nibh sollicitudin tincidunt. Ut consequat nisi sit amet nibh. Nunc mi tortor, tristique sit amet, rhoncus porta, malesuada elementum, nisi. Integer vitae enim quis risus aliquet gravida. Curabitur vel lorem vel erat dapibus lobortis. Donec dignissim tellus at arcu. Quisque molestie pulvinar sem.

Nulla magna neque, ullamcorper tempus, luctus eget, malesuada ut, velit. Morbi felis. Praesent in purus at ipsum cursus posuere. Morbi bibendum facilisis eros. Phasellus aliquam sapien in erat. Praesent venenatis diam dignissim dui. Praesent risus erat, iaculis ac, dapibus sed, imperdiet ac, erat. Nullam sed ipsum. Phasellus non dolor. Donec ut elit.

Sed risus.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vestibulum sem lacus, commodo vitae, aliquam ut, posuere eget, dui. Praesent massa dui, mattis et, vehicula auctor, iaculis id, diam. Morbi viverra neque sit amet risus. Nunc pellentesque aliquam orci. Proin neque elit, mollis vel, tristique nec, varius consectetuer, lorem. Nam malesuada ornare nunc. Duis turpis turpis, fermentum a, aliquet quis, sodales at, dolor. Duis eget velit eget risus fringilla hendrerit. Nulla facilisi. Mauris turpis pede, aliquet ac, mattis sed, consequat in, massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam egestas posuere metus. Aliquam erat volutpat. Donec non tortor. Vivamus posuere nisi mollis dolor. Quisque porttitor nisi ac elit. Nullam tincidunt ligula vitae nulla.

Vivamus sit amet risus et ipsum viverra malesuada. Duis luctus. Curabitur adipiscing metus et felis. Vestibulum tortor. Pellentesque purus. Donec pharetra, massa quis malesuada auctor, tortor ipsum lobortis ipsum, eget facilisis ante nisi eget lectus. Sed a est. Aliquam nec felis eu sem euismod viverra. Suspendisse felis mi, dictum id, convallis ac, mattis non, nibh. Donec sagittis quam eu mauris. Phasellus et leo at quam dapibus pellentesque. In non lacus. Nullam tristique nunc ut arcu scelerisque aliquam. Nullam viverra magna vitae leo. Vestibulum in lacus sit amet lectus tempus aliquet. Duis cursus nisl ac orci. Donec non nisl. Mauris lacus sapien, congue a, facilisis at, egestas vel, quam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae.

Phasellus ipsum odio, suscipit nec, fringilla at, vehicula quis, tellus. Phasellus gravida condimentum dui. Aenean imperdiet arcu vitae ipsum. Duis dapibus, nisi non porttitor iaculis, ligula odio sollicitudin mauris, non luctus nunc massa a velit. Fusce ac nisi. Integer volutpat elementum metus. Vivamus luctus ultricies diam. Curabitur euismod. Vivamus quam. Nunc ante. Nulla mi nulla, vehicula nec, ultrices a, tincidunt vel, enim.

Suspendisse potenti. Aenean sed velit. Nunc a urna quis turpis imperdiet sollicitudin. Mauris aliquam mauris ut tortor. Pellentesque tincidunt mattis nibh. In id lectus eu magna vulputate ultrices. Aliquam interdum varius enim. Maecenas at mauris. Sed sed nibh. Nam non turpis. Maecenas fermentum nibh in est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.

Duis sagittis fermentum nunc. Nullam elementum erat. Quisque dapibus, augue nec dapibus bibendum, velit enim scelerisque sem, accumsan suscipit lectus odio ac justo. Fusce in felis a enim rhoncus placerat. Cras nec eros et mi egestas facilisis. In hendrerit tincidunt neque. Maecenas tellus. Fusce sollicitudin molestie dui. Sed magna orci, accumsan nec, viverra non, pharetra id, dui.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Nullam placerat mi vitae felis. In porta, quam sit amet sodales elementum, elit dolor aliquam elit, a commodo nisi felis nec nibh. Nulla facilisi. Etiam at tortor. Vivamus quis sapien nec magna scelerisque lobortis.

Curabitur tincidunt viverra justo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Sed eros ante, mattis ullamcorper, posuere quis, tempor vel, metus. Maecenas cursus cursus lacus. Sed risus magna, aliquam sed, suscipit sit amet, porttitor quis, odio. Suspendisse cursus justo nec urna. Suspendisse potenti. In hac habitasse platea dictumst. Cras quis lacus. Vestibulum rhoncus congue lacus. Vivamus euismod, felis quis commodo viverra, dolor elit dictum ante, et mollis eros augue at est. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nulla lectus sem, tristique sed, semper in, hendrerit non, sem. Vivamus dignissim massa in ipsum. Morbi fringilla ullamcorper ligula. Nunc turpis. Mauris vitae sapien. Nunc luctus bibendum velit.

Morbi faucibus volutpat sapien. Nam ac mauris at justo adipiscing facilisis. Nunc et velit. Donec auctor, nulla id laoreet volutpat, pede erat feugiat ante, auctor facilisis dui augue non turpis. Suspendisse mattis metus et justo. Aliquam erat volutpat. Suspendisse potenti. Nam hendrerit lorem commodo metus laoreet ullamcorper. Proin vel nunc a felis sollicitudin pretium. Maecenas in metus at mi mollis posuere. Quisque ac quam sed massa adipiscing rutrum. Vestibulum ipsum. Phasellus porta sapien. Maecenas venenatis tellus vel tellus.

Aliquam aliquam dolor at justo. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Morbi pretium purus a magna. Nullam dui tellus, blandit eu, facilisis non, pharetra consectetuer, leo. Maecenas sit amet ante sagittis magna imperdiet pulvinar. Vestibulum a lacus at sapien suscipit tempus. Proin pulvinar velit sed nulla. Curabitur aliquet leo ac massa. Praesent posuere lectus vitae odio. Donec imperdiet urna vel ante. In semper accumsan diam. Vestibulum porta justo. Suspendisse egestas commodo eros.

Suspendisse tincidunt mi vel metus. Vivamus non urna in nisi gravida congue. Aenean semper orci a eros. Praesent dictum. Maecenas pharetra odio ut dui. Pellentesque ut orci. Sed lobortis, velit at laoreet suscipit, quam est sagittis nibh, id varius ipsum quam ac metus. Phasellus est nibh, bibendum non, dictum sed, vehicula in, sem. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris sollicitudin. Duis congue tincidunt orci. Integer blandit neque ut quam. Morbi mollis. Integer lacinia. Praesent blandit elementum sapien. Praesent enim mauris, suscipit a, auctor et, lacinia vitae, nunc. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Praesent lacus diam, auctor quis, venenatis in, hendrerit at, est. Vivamus eget eros. Phasellus congue, sapien ac iaculis feugiat, lacus lacus accumsan lorem, quis volutpat justo turpis ac mauris.

Duis velit magna, scelerisque vitae, varius ut, aliquam vel, justo. Proin ac augue. Nullam auctor lectus vitae arcu. Vestibulum porta justo placerat purus. Ut sem nunc, vestibulum nec, sodales vitae, vehicula eget, ipsum. Sed nec tortor. Aenean malesuada. Nunc convallis, massa eu vestibulum commodo, quam mauris interdum arcu, at pellentesque diam metus ut nulla. Vestibulum eu dolor sit amet lacus varius fermentum. Morbi dolor enim, pulvinar eget, lobortis ac, fringilla ac, turpis. Duis ac erat. Etiam consequat. Integer sed est eu elit pellentesque dapibus. Duis venenatis magna feugiat nisi. Vestibulum et turpis. Maecenas a enim. Suspendisse ultricies ornare justo. Fusce sit amet nisi sed arcu condimentum venenatis. Vivamus dui. Nunc accumsan, quam a fermentum mattis, magna sapien iaculis pede, at porttitor quam odio at est.

Proin eleifend nisi et nibh. Maecenas a lacus. Mauris porta quam non massa molestie scelerisque. Nulla sed ante at lorem suscipit rutrum. Nam quis tellus. Cras elit nisi, ornare a, condimentum vitae, rutrum sit amet, tellus. Maecenas a dolor. Praesent tempor, felis eget gravida blandit, urna lacus faucibus velit, in consectetuer sapien erat nec quam. Integer bibendum odio sit amet neque. Integer imperdiet rhoncus mi. Pellentesque malesuada purus id purus. Quisque viverra porta lectus. Sed lacus leo, feugiat at, consectetuer eu, luctus quis, risus. Suspendisse faucibus orci et nunc. Nullam vehicula fermentum risus. Fusce felis nibh, dignissim vulputate, ultrices quis, lobortis et, arcu. Duis aliquam libero non diam.

Vestibulum placerat tincidunt tortor. Ut vehicula ligula quis lectus. In eget velit. Quisque vel risus. Mauris pede. Nullam ornare sapien sit amet nisl. Cras tortor. Donec tortor lorem, dignissim sit amet, pulvinar eget, mattis eu, metus. Cras vestibulum erat ultrices neque. Praesent rhoncus, dui blandit pellentesque congue, mauris mi ullamcorper odio, eget ultricies nunc felis in augue. Nullam porta nunc. Donec in pede ac mauris mattis eleifend. Cras a libero vel est lacinia dictum. In hac habitasse platea dictumst. Nullam malesuada molestie lorem. Nunc non mauris. Nam accumsan tortor gravida elit. Cras porttitor.

Praesent vel enim sed eros luctus imperdiet. Mauris neque ante, placerat at, mollis vitae, faucibus quis, leo. Ut feugiat. Vivamus urna quam, congue vulputate, convallis non, cursus cursus, risus. Quisque aliquet. Donec vulputate egestas elit. Morbi dictum, sem sit amet aliquam euismod, odio tortor pellentesque odio, ac ultrices enim nibh sed quam. Integer tortor velit, condimentum a, vestibulum eget, sagittis nec, neque. Aenean est urna, bibendum et, imperdiet at, rhoncus in, arcu. In hac habitasse platea dictumst. Vestibulum blandit dignissim dui. Maecenas vitae magna non felis ornare consectetuer. Sed lorem. Nam leo. In eget pede. Donec porta.

Etiam facilisis. Nam suscipit. Ut consectetuer leo vehicula augue. Aliquam cursus. Integer pharetra rhoncus massa. Cras et ligula vel quam tristique commodo. Sed est lectus, mollis quis, lacinia id, sollicitudin nec, eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi urna dui, fermentum quis, feugiat imperdiet, imperdiet id, sapien. Phasellus auctor nunc. Vivamus eget augue quis neque vestibulum placerat. Duis placerat. Maecenas accumsan rutrum lacus. Vestibulum lacinia semper nibh. Aenean diam odio, scelerisque at, ullamcorper nec, tincidunt dapibus, quam. Duis vel ante nec tortor porta mollis. Praesent orci. Cras dignissim vulputate metus.

Phasellus eu quam. Quisque interdum cursus purus. In orci. Maecenas vehicula. Sed et mauris. Praesent feugiat viverra lacus. Suspendisse pulvinar lacus ut nunc. Quisque nisi. Suspendisse id risus nec nisi ultrices ornare. Donec eget tellus. Nullam molestie placerat felis. Aenean facilisis. Nunc erat. Integer in tellus. Mauris volutpat, neque vel ornare porttitor, dolor nisi sagittis dolor, sit amet bibendum orci leo blandit lacus.

In id velit sodales arcu iaculis venenatis. Etiam at leo. Vivamus vitae sem. Mauris volutpat congue risus. Curabitur leo. Aenean tempor tortor eget ligula. Aenean vel augue. Vestibulum ac justo. In hac habitasse platea dictumst. Nam dignissim nisi non mauris. Donec et tortor. Morbi felis. Donec aliquet, erat eu ultrices tincidunt, lorem mi sagittis lectus, ut feugiat pede lacus quis sapien. Suspendisse porta, felis a fermentum interdum, dui nisl sodales felis, ut fermentum sapien nibh eu nunc.

Lorem ipsum dolor sit amet. Integer sed magna. Duis nisl nulla, porta ut, molestie sit amet, tincidunt eu, enim. Cras eu mauris. Cras iaculis, nisi vel tempor fringilla, nisl dolor imperdiet dolor, id lobortis ligula nunc sed dolor.

Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur eu dui vitae nulla tempor consectetuer. Suspendisse ligula dolor, varius nec, vulputate id, luctus sed, lacus. Pellentesque purus urna, porta molestie, mattis non, posuere et, velit. Curabitur diam mauris, dictum vel, lacinia congue, molestie at, nisi. Proin tempus diam ut ligula. Mauris dictum, metus dapibus iaculis sollicitudin, leo ligula cursus sem, eu congue metus ligula sed justo. Suspendisse potenti. Donec sodales elementum turpis. Duis dolor elit, dapibus sed, placerat vitae, auctor sit amet, nunc. Donec nisl quam, hendrerit vitae, porttitor et, imperdiet id, quam. Quisque dolor. Nulla tincidunt, lacus id dapibus ullamcorper, turpis diam fringilla eros, quis aliquet dolor felis at lorem. Pellentesque et lacus. Vestibulum tempor lectus at est. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Sed vitae eros. Nulla pulvinar turpis eget nunc. Sed bibendum pellentesque nunc. Integer tristique, lorem ac faucibus tempor, lorem dolor mollis turpis, a consectetuer nunc justo ac nisl.

Nam vitae purus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Praesent semper magna. In eu justo. Nunc vitae risus nec sem scelerisque consequat. In hac habitasse platea dictumst. Nam posuere ultricies turpis. Pellentesque a pede. Duis sed tortor. Phasellus egestas porta lectus. Aliquam dignissim consequat diam. Pellentesque pede.

Ut varius tincidunt tellus. Curabitur ornare ipsum. Aenean laoreet posuere orci. Etiam id nisl. Suspendisse volutpat elit molestie orci. Suspendisse vel augue at felis tincidunt sollicitudin. Fusce arcu. Duis a tortor. Duis et odio et leo sollicitudin consequat. Aliquam lobortis. Phasellus condimentum. Ut porttitor bibendum libero. Integer euismod lacinia velit. Donec velit justo, sodales varius, cursus sed, mattis a, arcu.

Maecenas accumsan, sem iaculis egestas gravida, odio nunc aliquet dui, eget cursus diam purus vel augue. Donec eros nisi, imperdiet quis, volutpat ac, sollicitudin sed, arcu. Aenean vel mauris. Mauris tincidunt. Nullam euismod odio at velit. Praesent elit purus, porttitor id, facilisis in, consequat ut, libero. Morbi imperdiet, magna quis ullamcorper malesuada, mi massa pharetra lectus, a pellentesque urna urna id turpis. Nam posuere lectus vitae nibh. Etiam tortor orci, sagittis malesuada, rhoncus quis, hendrerit eget, libero. Quisque commodo nulla at nunc. Mauris consequat, enim vitae venenatis sollicitudin, dolor orci bibendum enim, a sagittis nulla nunc quis elit. Phasellus augue. Nunc suscipit, magna tincidunt lacinia faucibus, lacus tellus ornare purus, a pulvinar lacus orci eget nibh. Maecenas sed nibh non lacus tempor faucibus. In hac habitasse platea dictumst. Vivamus a orci at nulla tristique condimentum. Donec arcu quam, dictum accumsan, convallis accumsan, cursus sit amet, ipsum. In pharetra sagittis nunc.

Donec consequat mi. Quisque vitae dolor. Integer lobortis. Maecenas id nulla. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed volutpat felis vitae dui. Vestibulum et est ac ligula dapibus elementum. Nunc suscipit nisl eu felis. Duis nec tortor. Nullam diam libero, semper id, consequat in, consectetuer ut, metus. Phasellus dui purus, vehicula sed, venenatis a, rutrum at, nunc. Pellentesque interdum sapien nec neque.

Vivamus sagittis, sem sit amet porttitor lobortis, turpis sapien consequat orci, sed commodo nulla pede eget sem. Phasellus sollicitudin. Proin orci erat, blandit ut, molestie sed, fringilla non, odio. Nulla porta, tortor non suscipit gravida, velit enim aliquam quam, nec condimentum orci augue vel magna. Nulla facilisi. Donec ipsum enim, congue in, tempus id, pulvinar sagittis, leo. Donec et elit in nunc blandit auctor. Nulla congue urna quis lorem. Nam rhoncus pede sed nunc. Etiam vitae quam. Fusce feugiat pede vel quam. In et augue.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit.

Phasellus mollis dictum nulla. Integer vitae neque vitae eros fringilla rutrum. Vestibulum in pede adipiscing mi dapibus condimentum. Etiam felis risus, condimentum in, malesuada eget, pretium ut, sapien. Suspendisse placerat lectus venenatis lorem. Sed accumsan aliquam enim. Etiam hendrerit, metus eu semper rutrum, nisl elit pharetra purus, non interdum nibh enim eget augue. Sed mauris. Nam varius odio a sapien. Aenean rutrum dictum sapien. Fusce pharetra elementum ligula. Nunc eu mi non augue iaculis facilisis. Morbi interdum. Donec nisi arcu, rhoncus ac, vestibulum ut, pellentesque nec, risus. Maecenas tempus facilisis neque. Nulla mattis odio vitae tortor. Fusce iaculis. Aliquam rhoncus, diam quis tincidunt facilisis, sem quam luctus augue, ut posuere neque sem vitae neque.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nunc faucibus posuere turpis. Sed laoreet, est sed gravida tempor, nibh enim fringilla quam, et dapibus mi enim sit amet risus. Nulla sollicitudin eros sit amet diam. Aliquam ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Ut et est. Donec semper nulla in ipsum. Integer elit. In pharetra lorem vel ante.

Sed sed justo. Curabitur consectetuer arcu. Etiam placerat est eget odio. Nulla facilisi. Nulla facilisi. Mauris non neque. Suspendisse et diam. Sed vestibulum malesuada ipsum. Cras id magna. Nunc pharetra velit vitae eros. Vivamus ac risus. Mauris ac pede laoreet felis pharetra ultricies. Proin et neque. Aliquam dignissim placerat felis. Mauris porta ante sagittis purus.

Pellentesque quis leo eget ante tempor cursus. Pellentesque sagittis, diam ut dictum accumsan, magna est viverra erat, vitae imperdiet neque mauris aliquam nisl. Suspendisse blandit quam quis felis. Praesent turpis nunc, vehicula in, bibendum vitae, blandit ac, turpis. Duis rhoncus. Vestibulum metus. Morbi consectetuer felis id tortor. Etiam augue leo, cursus eget, ornare et, ornare sagittis, tellus. Fusce felis tellus, consectetuer nec, consequat at, ornare non, arcu. Maecenas condimentum sodales odio. Sed eu orci.

Nullam adipiscing eros sit amet ante. Vestibulum ante. Sed quis ipsum non ligula dignissim luctus. Integer quis justo id tortor accumsan tempus. Cras vitae magna. Nunc bibendum lacinia tellus. Quisque porttitor ligula et pede. Nam erat nibh, fringilla ac, rutrum sit amet, rhoncus in, ipsum. Mauris rhoncus, lacus eu convallis sagittis, quam magna placerat est, vitae imperdiet mauris arcu ac dui. In ac urna non justo posuere mattis. Suspendisse egestas bibendum nulla. In erat nunc, posuere sed, auctor quis, pulvinar quis, mi. Mauris at est. Phasellus lacinia eros in arcu. Maecenas lobortis, tellus vel gravida tincidunt, elit erat suscipit arcu, in varius erat risus vel magna. Fusce nec ante quis dolor vestibulum bibendum. Pellentesque sit amet urna.

Curabitur eget nisi at lectus placerat gravida. Vivamus nulla. Donec luctus. Sed quis tellus. Quisque lobortis faucibus mi. Aenean vitae risus ut arcu malesuada ornare. Maecenas nec erat. Sed rhoncus, elit laoreet sagittis luctus, nulla leo faucibus lectus, vitae accumsan est diam id felis. Nunc dui pede, vestibulum eu, elementum et, gravida quis, sapien. Donec blandit. Donec sed magna. Curabitur a risus. Nullam nibh libero, sagittis vel, hendrerit accumsan, pulvinar consequat, tellus. Donec varius dictum nisl. Vestibulum suscipit enim ac nulla. Proin tincidunt. Proin sagittis. Curabitur auctor metus non mauris. Nunc condimentum nisl non augue. Donec leo urna, dignissim vitae, porttitor ut, iaculis sit amet, sem.

Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Suspendisse potenti. Quisque augue metus, hendrerit sit amet, commodo vel, scelerisque ut, ante. Praesent euismod euismod risus. Mauris ut metus sit amet mi cursus commodo. Morbi congue mauris ac sapien. Donec justo. Sed congue nunc vel mauris. Pellentesque vehicula orci id libero. In hac habitasse platea dictumst. Nulla sollicitudin, purus id elementum dictum, dolor augue hendrerit ante, vel semper metus enim et dolor. Pellentesque molestie nunc id enim. Etiam mollis tempus neque. Duis tincidunt commodo elit.

Aenean pellentesque purus eu mi. Proin commodo, massa commodo dapibus elementum, libero lacus pulvinar eros, ut tincidunt nisl elit ut velit. Cras rutrum porta purus. Vivamus lorem. Sed turpis enim, faucibus quis, pharetra in, sagittis sed, magna. Curabitur ultricies felis ut libero. Nullam tincidunt enim eu nibh. Nunc eget ipsum in sem facilisis convallis. Proin fermentum risus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum hendrerit malesuada odio. Fusce ut elit ut augue sollicitudin blandit. Phasellus volutpat lorem. Duis non pede et neque luctus tincidunt. Duis interdum tempus elit.

Aenean metus. Vestibulum ac lacus. Vivamus porttitor, massa ut hendrerit bibendum, metus augue aliquet turpis, vitae pellentesque velit est vitae metus. Duis eros enim, fermentum at, sagittis id, lacinia eget, tellus. Nunc consequat pede et nulla. Donec nibh. Pellentesque cursus orci vitae urna. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque risus turpis, aliquet ac, accumsan vel, iaculis eget, enim. Pellentesque nibh neque, malesuada id, tempor vel, aliquet ut, eros. In hac habitasse platea dictumst. Integer neque purus, congue sed, mattis sed, vulputate ac, pede. Donec vestibulum purus non tortor. Integer at nunc.

Suspendisse fermentum velit quis sem. Phasellus suscipit nunc in risus. Nulla sed lectus. Morbi sollicitudin, diam ac bibendum scelerisque, enim tortor rhoncus sapien, vel posuere dolor neque in sem. Pellentesque tellus augue, tempus nec, laoreet at, porttitor blandit, leo. Phasellus in odio. Duis lobortis, metus eu laoreet tristique, pede mi congue mi, quis posuere augue nulla a augue. Pellentesque sed est. Mauris cursus urna id lectus. Integer dignissim feugiat eros. Sed tempor volutpat dolor. Vestibulum vel lectus nec mauris semper adipiscing.

Aliquam tincidunt enim sit amet tellus. Sed mauris nulla, semper tincidunt, luctus a, sodales eget, leo. Sed ligula augue, cursus et, posuere non, mollis sit amet, est. Mauris massa. Proin hendrerit massa. Phasellus eu purus. Donec est neque, dignissim a, eleifend vitae, lobortis ut, nibh. Nullam sed lorem. Proin laoreet augue quis eros. Suspendisse vehicula nunc ac nisi.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Fusce mi. Vivamus enim velit, condimentum sit amet, laoreet quis, fermentum non, ipsum. Etiam quis felis. Curabitur tincidunt, sapien et luctus faucibus, nibh nisi commodo arcu, vitae cursus neque ante sed elit. Sed sit amet erat. Phasellus luctus cursus risus. Phasellus ac felis. Proin nec eros quis ipsum pellentesque congue. Curabitur et diam sed odio accumsan cursus. Pellentesque ultricies. Quisque aliquam. Sed nisi velit, consectetuer eget, dictum ac, molestie a, magna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Curabitur consequat leo et dui. Aenean ligula mi, dignissim ut, imperdiet tristique, interdum a, dolor.

Vestibulum elit nibh, rhoncus non, euismod sit amet, pretium eu, enim. Nunc commodo ultricies dui. Cras gravida rutrum massa. Donec accumsan mattis turpis. Quisque sem. Quisque elementum sapien iaculis augue. In dui sem, congue sit amet, feugiat quis, lobortis at, eros.

Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin interdum vehicula purus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Aenean risus dui, volutpat non, posuere vitae, sollicitudin in, urna. Nam eget eros a enim pulvinar rhoncus. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla facilisis massa ut massa. Sed nisi purus, malesuada eu, porta vulputate, suscipit auctor, nunc. Vestibulum convallis, augue eu luctus malesuada, mi ante mattis odio, ac venenatis neque sem vitae nisi. Donec pellentesque purus a lorem. Etiam in massa. Nam ut metus. In rhoncus venenatis tellus. Etiam aliquam. Ut aliquam lectus ut lectus. Nam turpis lacus, tristique sit amet, convallis sollicitudin, commodo a, purus. Nulla vitae eros a diam blandit mollis. Proin luctus feugiat eros. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis ultricies urna. Etiam enim urna, pharetra suscipit, varius et, congue quis, odio. Donec lobortis, elit bibendum euismod faucibus, velit nibh egestas libero, vitae pellentesque elit augue ut massa.

Nulla consequat erat at massa. Vivamus id mi. Morbi purus enim, dapibus a, facilisis non, tincidunt at, enim. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis imperdiet eleifend arcu. Cras magna ligula, consequat at, tempor non, posuere nec, libero. Vestibulum vel ipsum. Praesent congue justo et nunc. Vestibulum nec felis vitae nisl pharetra sollicitudin. Quisque nec arcu vel tellus tristique vestibulum. Aenean vel lacus. Mauris dolor erat, commodo ut, dapibus vehicula, lobortis sit amet, orci. Aliquam augue. In semper nisi nec libero. Cras magna ipsum, scelerisque et, tempor eget, gravida nec, lacus. Fusce eros nisi, ullamcorper blandit, ultricies eget, elementum eget, pede. Phasellus id risus vitae nisl ullamcorper congue. Proin est.

Sed eleifend odio sed leo. Mauris tortor turpis, dignissim vel, ornare ac, ultricies quis, magna. Phasellus lacinia, augue ac dictum tempor, nisi felis ornare magna, eu vehicula tellus enim eu neque. Fusce est eros, sagittis eget, interdum a, ornare suscipit, massa. Sed vehicula elementum ligula. Aliquam erat volutpat. Donec odio. Quisque nunc. Integer cursus feugiat magna. Fusce ac elit ut elit aliquam suscipit. Duis leo est, interdum nec, varius in, facilisis vitae, odio. Phasellus eget leo at urna adipiscing vulputate. Nam eu erat vel arcu tristique mattis. Nullam placerat lorem non augue. Cras et velit. Morbi sapien nulla, volutpat a, tristique eu, molestie ac, felis.

Suspendisse sit amet tellus non odio porta pellentesque. Nulla facilisi. Integer iaculis condimentum augue. Nullam urna nulla, vestibulum quis, lacinia eget, ullamcorper eu, dui. Quisque dignissim consequat nisl. Pellentesque porta augue in diam. Duis mattis. Aliquam et mi quis turpis pellentesque consequat. Suspendisse nulla erat, lacinia nec, pretium vitae, feugiat ac, quam. Etiam sed tellus vel est ultrices condimentum. Vestibulum euismod. Vivamus blandit. Pellentesque eu urna. Vestibulum consequat sem vitae dui. In dictum feugiat quam. Phasellus placerat. In sem nisl, elementum vitae, venenatis nec, lacinia ac, arcu. Pellentesque gravida egestas mi. Integer rutrum tincidunt libero.

Duis viverra. Nulla diam lectus, tincidunt et, scelerisque vitae, aliquam vitae, justo. Quisque eget erat. Donec aliquet porta magna. Sed nisl. Ut tellus. Suspendisse quis mi eget dolor sagittis tristique. Aenean non pede eget nisl bibendum gravida. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Morbi laoreet. Suspendisse potenti. Donec accumsan porta felis.

Fusce tristique leo quis pede. Cras nibh. Sed eget est vitae tortor mollis ullamcorper. Suspendisse placerat dolor a dui. Vestibulum condimentum dui et elit. Pellentesque porttitor ipsum at ipsum. Nam massa. Duis lorem. Donec porta. Proin ligula. Aenean nunc massa, dapibus quis, imperdiet id, commodo a, lacus. Cras sit amet erat et nulla varius aliquet. Aliquam erat volutpat. Praesent feugiat vehicula pede. Suspendisse pulvinar, orci in sollicitudin venenatis, nibh libero hendrerit sem, eu tempor nisi felis et metus. Etiam gravida sem ut mi. Integer volutpat, enim eu varius gravida, risus urna venenatis lectus, ac ultrices quam nulla eu leo. Duis arcu. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.

Vivamus lacus libero, aliquam eget, iaculis quis, tristique adipiscing, diam. Vivamus nec massa non justo iaculis pellentesque. Aenean accumsan elit sit amet nibh feugiat semper. Cras tempor ornare purus. Integer id nisi. Phasellus dui velit, ultrices vel, ullamcorper mattis, hendrerit in, erat. Aenean vel quam at eros mattis commodo. Aenean feugiat iaculis justo. Maecenas accumsan justo ut nibh. Donec ac lectus vitae odio lobortis tristique. Donec vestibulum mattis lectus. Donec et lorem.

Cras sit amet mauris. Curabitur a quam. Aliquam neque. Nam nunc nunc, lacinia sed, varius quis, iaculis eget, ante. Nulla dictum justo eu lacus. Phasellus sit amet quam. Nullam sodales. Cras non magna eu est consectetuer faucibus. Donec tempor lobortis turpis. Sed tellus velit, ullamcorper ac, fringilla vitae, sodales nec, purus. Morbi aliquet risus in mi.

Curabitur cursus volutpat neque. Proin posuere mauris ut ipsum. Praesent scelerisque tortor a justo. Quisque consequat libero eu erat. In eros augue, sollicitudin sed, tempus tincidunt, pulvinar a, lectus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Maecenas interdum purus id risus. Ut ultricies cursus dui. In nec enim at odio aliquam iaculis. Fusce nisl. Pellentesque sagittis. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean placerat tellus. In semper sagittis enim. Aliquam risus neque, pretium in, fermentum vitae, vulputate et, massa. Nulla sed erat vel eros ornare venenatis.

In hac habitasse platea dictumst. Sed nisl nunc, suscipit id, feugiat vel, tristique sit amet, sapien. Phasellus vestibulum. Nam quis justo. Nulla sit amet mauris sed lacus pharetra fringilla. In mollis orci ultrices.
Lorem ipsum dolor sit amet. 

plugin/loremipsum.vim	[[[1
85
" loremipsum.vim
" @Author:      Thomas Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2008-07-10.
" @Last Change: 2008-07-11.
" @Revision:    66
" GetLatestVimScripts: 2289 0 loremipsum.vim

if &cp || exists("loaded_loremipsum")
    finish
endif
let loaded_loremipsum = 2

let s:save_cpo = &cpo
set cpo&vim

if !exists('g:loremipsum_paragraph_template')
    " A dictionary of filetypes and paragraph templates (as format 
    " strings for |printf()|).
    " :nodefault:
    " :read: let g:loremipsum_paragraph_template = {} "{{{2
    let g:loremipsum_paragraph_template = {
                \ 'html': '<p>%s</p>',
                \ 'php': '<p>%s</p>',
                \ }
endif

if !exists('g:loremipsum_marker')
    " A dictionary of filetypes and array containing the prefix and the 
    " postfix for the inserted text:
    " [prefix, postfix, no_inline?]
    " :read: let g:loremipsum_marker = {}  "{{{2
    let g:loremipsum_marker = {
                \ 'html': ['<!--lorem-->', '<!--/lorem-->', 0],
                \ 'php': ['<!--lorem-->', '<!--/lorem-->', 0],
                \ 'tex': ['% lorem{{{', '% lorem}}}', 1],
                \ 'viki': ['% lorem{{{', '% lorem}}}', 1],
                \ }
endif

if !exists('g:loremipsum_words')
    " Default length.
    let g:loremipsum_words = 100   "{{{2
endif

if !exists('g:loremipsum_files')
    "                                                 *b:loremipsum_file*
    " If b:loremipsum_file exists, it will be used as source. Otherwise, 
    " g:loremipsum_files[&spelllang] will be checked. As a fallback, 
    " .../autoload/loremipsum.txt will be used.
    let g:loremipsum_files = {}   "{{{2
endif


" :display: :Loremipsum[!] [COUNT] [PARAGRAPH_TEMPLATE] [PREFIX POSTFIX]
" With [!], insert the text "inline", don't apply paragraph templates.
" If the PARAGRAPH_TEMPLATE is *, use the default template from 
" |g:loremipsum_paragraph_template| (in case you want to change 
" PREFIX and POSTFIX). If it is _, use no paragraph template.
" If PREFIX is _, don't use markers.
command! -bang -nargs=* Loremipsum call loremipsum#Insert("<bang>", <f-args>)

" Replace loremipsum text with something else. Or simply remove it.
" :display: :Loreplace [REPLACEMENT] [PREFIX] [POSTFIX]
command! -nargs=* Loreplace call loremipsum#Replace(<f-args>)


let &cpo = s:save_cpo
unlet s:save_cpo


finish
CHANGES:
0.1
- Initial release

0.2
- Loremipsum!: With !, insert inline (single paragraph)
- If the template argument is *, don't apply the default paragraph 
template.
- Loreplace: Replace loremipsum text with something else (provided a 
marker was defined for the current filetype)
- g:loremipsum_file, b:loremipsum_file

doc/loremipsum.txt	[[[1
97
*loremipsum.txt*    A dummy text generator
                    Author: Thomas Link, micathom at gmail com

Insert a dummy text of a certain length. Actually, the text isn't 
generated but selected from some text. By default, the following text is 
used, which is included in the archive:
http://www.lorem-ipsum-dolor-sit-amet.com/lorem-ipsum-dolor-sit-amet.html

NOTE: The webpage didn't contain any copyright message but there is a 
statement that one should copy & paste the text. I thus assume it's ok 
to include it in the archive. If not, please let me know.

-----------------------------------------------------------------------
Install~

Edit the vba file and type: >

    :so %

See :help vimball for details. If you have difficulties or use vim 7.0, 
please make sure, you have the current version of vimball (vimscript 
#1502) installed or update your runtime.


========================================================================
Contents~

    plugin/loremipsum.vim
        g:loremipsum_paragraph_template ... |g:loremipsum_paragraph_template|
        g:loremipsum_marker ............... |g:loremipsum_marker|
        g:loremipsum_words ................ |g:loremipsum_words|
        g:loremipsum_files ................ |g:loremipsum_files|
        :Loremipsum ....................... |:Loremipsum|
        :Loreplace ........................ |:Loreplace|
    autoload/loremipsum.vim
        loremipsum#Generate ............... |loremipsum#Generate()|
        loremipsum#GenerateInline ......... |loremipsum#GenerateInline()|
        loremipsum#Insert ................. |loremipsum#Insert()|
        loremipsum#Replace ................ |loremipsum#Replace()|


========================================================================
plugin/loremipsum.vim~

                                                    *g:loremipsum_paragraph_template*
g:loremipsum_paragraph_template
    A dictionary of filetypes and paragraph templates (as format 
    strings for |printf()|).

                                                    *g:loremipsum_marker*
g:loremipsum_marker            (default: {})
    A dictionary of filetypes and array containing the prefix and the 
    postfix for the inserted text:
    [prefix, postfix, no_inline?]

                                                    *g:loremipsum_words*
g:loremipsum_words             (default: 100)
    Default length.

                                                    *g:loremipsum_files*
g:loremipsum_files             (default: {})
                                                      *b:loremipsum_file*
    If b:loremipsum_file exists, it will be used as source. Otherwise, 
    g:loremipsum_files[&spelllang] will be checked. As a fallback, 
    ~/vimfiles/autoload/loremipsum.txt will be used.

                                                    *:Loremipsum*
:Loremipsum[!] [COUNT] [PARAGRAPH_TEMPLATE] [PREFIX] [POSTFIX]
    With [!], insert the text "inline", don't apply paragraph templates.
    If the paragraph template is *, use the default template from 
    |g:loremipsum_paragraph_template| (in case you want to change 
    PREFIX and POSTFIX). If it is _, use no paragraph template.
    If PREFIX is _, don't use markers.

                                                    *:Loreplace*
:Loreplace [REPLACEMENT] [PREFIX] [POSTFIX]
    Replace loremipsum text with something else. Or simply remove it.


========================================================================
autoload/loremipsum.vim~

                                                    *loremipsum#Generate()*
loremipsum#Generate(nwords, template)

                                                    *loremipsum#GenerateInline()*
loremipsum#GenerateInline(nwords)

                                                    *loremipsum#Insert()*
loremipsum#Insert(?inline=0, ?nwords=100, " ?template='', ?pre='', ?post='')

                                                    *loremipsum#Replace()*
loremipsum#Replace(...)



vim:tw=78:fo=tcq2:isk=!-~,^*,^|,^":ts=8:ft=help:norl:
