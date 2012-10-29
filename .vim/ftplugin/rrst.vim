"  This program is free software; you can redistribute it and/or modify
"  it under the terms of the GNU General Public License as published by
"  the Free Software Foundation; either version 2 of the License, or
"  (at your option) any later version.
"
"  This program is distributed in the hope that it will be useful,
"  but WITHOUT ANY WARRANTY; without even the implied warranty of
"  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
"  GNU General Public License for more details.
"
"  A copy of the GNU General Public License is available at
"  http://www.r-project.org/Licenses/

"==========================================================================
" ftplugin for Rrst files
"
" Authors: Jakson Alves de Aquino <jalvesaq@gmail.com>
"          Jose Claudio Faria
"          Alex Zvoleff
"
"==========================================================================

" Only do this when not yet done for this buffer
if exists("b:did_rrst_ftplugin") || exists("disable_r_ftplugin")
    finish
endif

" Don't load another plugin for this buffer
let b:did_rrst_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

" Source scripts common to R, Rrst, Rnoweb, Rhelp and Rdoc:
runtime r-plugin/common_global.vim
if exists("g:rplugin_failed")
    finish
endif

setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=>\ %s
setlocal formatoptions+=tcqln
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^\\s*[-*+]\\s\\+
setlocal iskeyword=@,48-57,_,.

" Some buffer variables common to R, Rrst, Rnoweb, Rhelp and Rdoc need to be 
" defined after the global ones:
runtime r-plugin/common_buffer.vim

function! RrstIsInRCode()
    let curline = line(".")
    let chunkline = search("^\\.\\. {r", "bncW")
    call cursor(chunkline)
    let docline = search("^\\.\\. \\.\\.", "bncW")
    call cursor(curline)
    if chunkline > docline
        return 1
    else
        return 0
    endif
endfunction

function! RrstPreviousChunk() range
    let rg = range(a:firstline, a:lastline)
    let chunk = len(rg)
    for var in range(1, chunk)
        let curline = line(".")
        if RrstIsInRCode()
            let i = search("^\\.\\. {r", "bnW")
            if i != 0
                call cursor(i-1, 1)
            endif
        endif
        let i = search("^\\.\\. {r", "bnW")
        if i == 0
            call cursor(curline, 1)
            call RWarningMsg("There is no previous R code chunk to go.")
            return
        else
            call cursor(i+1, 1)
        endif
    endfor
    return
endfunction

function! RrstNextChunk() range
    let rg = range(a:firstline, a:lastline)
    let chunk = len(rg)
    for var in range(1, chunk)
        let i = search("^\\.\\. {r", "nW")
        if i == 0
            call RWarningMsg("There is no next R code chunk to go.")
            return
        else
            call cursor(i+1, 1)
        endif
    endfor
    return
endfunction

function! RMakeHTMLrrst(t)
    call RSetWD()
    update
    if g:rplugin_has_rst2pdf == 0
        if executable("rst2pdf")
            let g:rplugin_has_rst2pdf = 1
        else
            call RWarningMsg("Is 'rst2pdf' application installed? Cannot convert into HTML/ODT: 'rst2pdf' executable not found.")
            return
        endif
    endif

    let rcmd = 'require(knitr)'
    if g:vimrplugin_strict_rst
        let rcmd = rcmd . '; render_rst(strict=TRUE)'
    endif
    let rcmd = rcmd . '; knit("' . expand("%:t") . '")'
    
    if a:t == "odt"
        let rcmd = rcmd . '; system("rst2odt ' . expand("%:r:t") . ".rst " . expand("%:r:t") . '.odt")'
    else
        let rcmd = rcmd . '; system("rst2html ' . expand("%:r:t") . ".rst " . expand("%:r:t") . '.html")'
    endif

    if g:vimrplugin_openhtml && a:t == "html"
        let rcmd = rcmd . '; browseURL("' . expand("%:r:t") . '.html")'
    endif
    let b:needsnewomnilist = 1
    call SendCmdToR(rcmd)
endfunction

function! RMakePDFrrst()
    if g:rplugin_vimcomport == 0
        exe "Py DiscoverVimComPort()"
        if g:rplugin_vimcomport == 0
            return
        endif
    endif
    update
    call RSetWD()
    if g:rplugin_has_rst2pdf == 0
        if executable("rst2pdf")
            let g:rplugin_has_rst2pdf = 1
        else
            call RWarningMsg("Is 'rst2pdf' application installed? Cannot convert into PDF: 'rst2pdf' executable not found.")
            return
        endif
    endif

    let pdfcmd = "vim.interlace.rrst('" . expand("%:t") . "'"
    if exists("g:vimrplugin_rrstcompiler")
        let pdfcmd = pdfcmd . ", compiler='" . g:vimrplugin_rrstcompiler . "'"
    endif
    if exists("g:vimrplugin_knitargs")
        let pdfcmd = pdfcmd . ", " . g:vimrplugin_knitargs
    endif
    if exists("g:vimrplugin_rst2pdfpath")
        pdfcmd = pdfcmd . ", rst2pdfpath='" . g:vimrplugin_rst2pdf_path . "'"
    endif
    if exists("g:vimrplugin_rst2pdfargs")
        let pdfcmd = pdfcmd . ", " . g:vimrplugin_rst2pdfargs
    endif
    let pdfcmd = pdfcmd . ")"
    let b:needsnewomnilist = 1
    let ok = SendCmdToR(pdfcmd)
    if ok == 0
        return
    endif
endfunction  

" Send Rrst chunk to R
function! SendRrstChunkToR(e, m)
    if RrstIsInRCode() == 0
        call RWarningMsg("Not inside an R code chunk.")
        return
    endif
    let chunkline = search("^\\.\\. {r", "bncW") + 1
    let docline = search("^\\.\\. \\.\\.", "ncW") - 1
    let lines = getline(chunkline, docline)
    let b:needsnewomnilist = 1
    let ok = RSourceLines(lines, a:e)
    if ok == 0
        return
    endif
    if a:m == "down"
        call RrstNextChunk()
    endif  
endfunction

"==========================================================================
" Key bindings and menu items

call RCreateStartMaps()
call RCreateEditMaps()
call RCreateSendMaps()
call RControlMaps()
call RCreateMaps("nvi", '<Plug>RSetwd',        'rd', ':call RSetWD()')

" Only .Rrst files use these functions:
call RCreateMaps("nvi", '<Plug>RKnit',        'kn', ':call RKnit()')
call RCreateMaps("nvi", '<Plug>RMakePDFK',    'kp', ':call RMakePDFrrst()')
call RCreateMaps("nvi", '<Plug>RMakeHTML',    'kh', ':call RMakeHTMLrrst("html")')
call RCreateMaps("nvi", '<Plug>RMakeODT',     'ko', ':call RMakeHTMLrrst("odt")')
call RCreateMaps("nvi", '<Plug>RIndent',      'si', ':call RrstToggleIndentSty()')
call RCreateMaps("ni",  '<Plug>RSendChunk',   'cc', ':call SendRrstChunkToR("silent", "stay")')
call RCreateMaps("ni",  '<Plug>RESendChunk',  'ce', ':call SendRrstChunkToR("echo", "stay")')
call RCreateMaps("ni",  '<Plug>RDSendChunk',  'cd', ':call SendRrstChunkToR("silent", "down")')
call RCreateMaps("ni",  '<Plug>REDSendChunk', 'ca', ':call SendRrstChunkToR("echo", "down")')
nmap <buffer><silent> gn :call RrstNextChunk()<CR>
nmap <buffer><silent> gN :call RrstPreviousChunk()<CR>

" Menu R
if has("gui_running")
    call MakeRMenu()
endif

let g:rplugin_has_rst2pdf = 0

let &cpo = s:cpo_save
unlet s:cpo_save
