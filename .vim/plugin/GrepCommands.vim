" GrepCommands.vim: Perform :vimgrep over arguments, buffers, windows.
"
" DEPENDENCIES:
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.00.001	19-Mar-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_GrepCommands') || (v:version < 700)
    finish
endif
let g:loaded_GrepCommands = 1

command! -bang -count -nargs=? -complete=expression ArgGrep    call GrepCommands#Grep(<count>, 'vimgrep<bang>',    GrepCommands#Arguments(),  <q-args>)
command! -bang -count -nargs=? -complete=expression ArgGrepAdd call GrepCommands#Grep(<count>, 'vimgrepadd<bang>', GrepCommands#Arguments(),  <q-args>)
command! -bang -count -nargs=? -complete=expression BufGrep    call GrepCommands#Grep(<count>, 'vimgrep<bang>',    GrepCommands#Buffers(),    <q-args>)
command! -bang -count -nargs=? -complete=expression BufGrepAdd call GrepCommands#Grep(<count>, 'vimgrepadd<bang>', GrepCommands#Buffers(),    <q-args>)
command! -bang -count -nargs=? -complete=expression WinGrep    call GrepCommands#Grep(<count>, 'vimgrep<bang>',    GrepCommands#Windows(),    <q-args>)
command! -bang -count -nargs=? -complete=expression WinGrepAdd call GrepCommands#Grep(<count>, 'vimgrepadd<bang>', GrepCommands#Windows(),    <q-args>)
command! -bang -count -nargs=? -complete=expression TabGrep    call GrepCommands#Grep(<count>, 'vimgrep<bang>',    GrepCommands#TabWindows(), <q-args>)
command! -bang -count -nargs=? -complete=expression TabGrepAdd call GrepCommands#Grep(<count>, 'vimgrepadd<bang>', GrepCommands#TabWindows(), <q-args>)

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
