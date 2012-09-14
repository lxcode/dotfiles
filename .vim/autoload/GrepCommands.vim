" GrepCommands.vim: Perform :vimgrep over arguments, buffers, windows.
"
" DEPENDENCIES:
"   - escapings.vim autoload script
"   - ingocollections.vim autoload script
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.01.003	24-Aug-2012	BUG: Forgot to append l:patternFlags and enclose
"				in delimiters when there's a non-whitespace
"				pattern; this makes the GrepHere plugin's
"				mappings wrongly jump to the first match.
"   1.00.002	16-Aug-2012	Use the original window order for :WinGrep[Add]
"				(just like in :windo) instead of processing by
"				buffer number. Same for :TabGrep[Add].
"	001	19-Mar-2012	file creation
let s:save_cpo = &cpo
set cpo&vim

function! GrepCommands#Arguments()
    return argv()
endfunction
function! s:BufNrsToFilespecs( bufNrs )
    return
    \   filter(
    \       map(
    \           a:bufNrs,
    \	        'bufname(0 + v:val)'
    \       ),
    \       '! empty(v:val)'
    \   )
endfunction
function! GrepCommands#Buffers()
    return s:BufNrsToFilespecs(
    \   filter(
    \       range(1, bufnr('$')),
    \       'buflisted(v:val)'
    \   )
    \)
endfunction
function! GrepCommands#Windows()
    return s:BufNrsToFilespecs(ingocollections#uniqueStable(tabpagebuflist()))
endfunction
function! GrepCommands#TabWindows()
    let l:bufList = []
    for l:i in range(tabpagenr('$'))
	call extend(l:bufList, tabpagebuflist(l:i + 1))
    endfor

    return s:BufNrsToFilespecs(ingocollections#uniqueStable(l:bufList))
endfunction

function! GrepCommands#Grep( count, grepCommand, filespecs, pattern, ... )
    let l:patternFlags = (a:0 ? a:1 : '')
    if empty(a:pattern)
	let l:patternDelimiter = (v:searchforward ? '/' : '?')
	let l:patternArgument = l:patternDelimiter . @/ . l:patternDelimiter . l:patternFlags
    else
	if a:pattern =~# '^\i.*\s' || ! empty(l:patternFlags)
	    " A pattern starting with an ID character must not contain
	    " whitespace; otherwise, everything after the first word would be
	    " parsed as additional file arguments to :vimgrep.
	    " Instead of complaining, we DWIM by enclosing the pattern in
	    " delimiters.
	    let l:patternArgument = '/' . escape(a:pattern, '/') . '/' . l:patternFlags
	else
	    let l:patternArgument = a:pattern
	endif
    endif

    try
	execute (a:count ? a:count : '') . a:grepCommand l:patternArgument join(map(a:filespecs, 'escapings#fnameescape(v:val)'))
    catch /^Vim\%((\a\+)\)\=:E/
	" v:exception contains what is normally in v:errmsg, but with extra
	" exception source info prepended, which we cut away.
	let v:errmsg = substitute(v:exception, '^Vim\%((\a\+)\)\=:', '', '')
	echohl ErrorMsg
	echomsg v:errmsg
	echohl None

	return 0
    endtry

    return 1
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
