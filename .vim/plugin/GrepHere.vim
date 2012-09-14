" GrepHere.vim: List occurrences in the current buffer in the quickfix window.
"
" DEPENDENCIES:
"   - GrepHere.vim autoload script
"   - ingointegration.vim autoload script
"
" Copyright: (C) 2003-2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.

" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.10.012	24-Aug-2012	Make default flags for an empty :GrepHere
"				command configurable via
"				g:GrepHere_EmptyCommandGrepFlags.
"   1.00.011	24-Aug-2012	Add mappings for the [whole] <cword> and visual
"				selection, and align the mapping keys with the
"				SearchPosition plugin.
"				Factor out the mapping logic to GrepHere#List().
"				Extract g:GrepHere_MappingGrepFlags.
"	010	21-Mar-2012	Rename to GrepHere.vim, define <Plug>-mapping,
"				factor out function to autoload script and
"				separate documentation.
"	009	19-Mar-2012	Extract vimgrep wrapping to new GrepCommands
"				plugin for reuse.
"	008	15-Apr-2011	Renamed ingowindow#IsQuickfixWindow() to
"				ingowindow#IsQuickfixList(), because it also
"				detects location lists.
"	007	08-Dec-2010	Moved 'grepprg' setting to .vimrc.
"				Complete reimplementation of :GrepHere,
"				combining it with :GrepSearch. Script is Vim 7
"				and later now.
"				Added :GrepAddHere command.
"				Changed behavior of <A-?> so that only the
"				quickfix window is opened, but the cursor stays
"				in the original window.
"	006	28-Jun-2008	Added Windows detection via has('win64').
"	005	13-Jun-2008	Added -bar to all commands that do not take any
"				arguments, so that these can be chained together.
"	0.04	26-Jul-2006	BF: Passing <q-args> escaped backslashes,
"				disallowing things like :GrepSearch \sfoo\s\+
"				Added g:ingogrep_no_vimgrep customization.
"	0.03	11-May-2006	VIM7: Now using :vimgrep instead of external
"				grep.
"				BF: Wrong filename enclosing single quotes
"				caused shell error 1 on :GrepSearch.
"	0.02	13-Aug-2004	Make grep work for single files (grep -H)
"	0.01	11-Jun-2003	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_GrepHere') || v:version < 700
    finish
endif
let g:loaded_GrepHere = 1

"- configuration ---------------------------------------------------------------

if ! exists('g:GrepHere_EmptyCommandGrepFlags')
    let g:GrepHere_EmptyCommandGrepFlags = 'g'
endif
if ! exists('g:GrepHere_MappingGrepFlags')
    let g:GrepHere_MappingGrepFlags = 'gj'
endif


"- commands --------------------------------------------------------------------

command! -count -nargs=? GrepHere    call GrepHere#Grep(<count>, 'vimgrep', <q-args>)
command! -count -nargs=? GrepHereAdd call GrepHere#Grep(<count>, 'vimgrepadd', <q-args>)


"- mappings --------------------------------------------------------------------

nnoremap <silent> <Plug>(GrepHereCurrent)    :<C-u>call GrepHere#List('')<CR>
nnoremap <silent> <Plug>(GrepHereWholeCword) :<C-u>call GrepHere#List(GrepHere#SetCword(1))<CR>
nnoremap <silent> <Plug>(GrepHereCword)      :<C-u>call GrepHere#List(GrepHere#SetCword(0))<CR>
vnoremap <silent> <Plug>(GrepHereCword)      :<C-u>call GrepHere#List(substitute(ingointegration#GetVisualSelection(), "\n", '\\n', 'g'))<CR>
if ! hasmapto('<Plug>(GrepHereCurrent)', 'n')
    nmap <A-N> <Plug>(GrepHereCurrent)
endif
if ! hasmapto('<Plug>(GrepHereWholeCword)', 'n')
    nmap <A-M> <Plug>(GrepHereWholeCword)
endif
if ! hasmapto('<Plug>(GrepHereCword)', 'n')
    nmap g<A-M> <Plug>(GrepHereCword)
endif
if ! hasmapto('<Plug>(GrepHereCword)', 'v')
    vmap <A-M> <Plug>(GrepHereCword)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
