" Folding support for LaTeX
"
" This folding will provide a script to compute the level of a fold based on:
" - part
" - chapter
" - section
" - subsection
"

"set options for folding
if exists('g:LatexBox_Folding')
    set fdm=expr
    set foldexpr=LatexBox_FoldLevel(v:lnum)
endif

function! LatexBox_FoldLevel(linenum)
    " Get the line and next line
    let line = getline(a:linenum)
    let nline = getline(a:linenum + 1)

    let ret = -2 
    
    " If next line is another section, end a fold at the good level 
    if nline =~ '\\part{.*}'
        let ret = "<1"
    else
        if nline =~ '\\chapter{.*}'
            let ret = "<2"
        else 
            if nline =~ '\\section{.*}'
                let ret = "<3"
            else
                if nline =~ '\\subsection{.*}'
                    let ret = "<4"
                endif
            endif
        endif
    endif

    echoerr ret

    if ret == -1
        return -1
    else
        let ret = "="
    endif

    " If the line is a new section, start a fold at the good level
    if line =~ '\\part{.*}'
        let ret = ">1"
    else
        if line =~ '\\chapter{.*}'
            let ret = ">2"
        else
            if line =~ '\\section{.*}'
                let ret = ">3"
            else
                if line =~ '\\subsection{.*}'
                    let ret = ">4"
                endif
            endif
        endif
    endif

    return ret
endfunction

" vim:fdm=marker:ff=unix:ts=4:sw=4
