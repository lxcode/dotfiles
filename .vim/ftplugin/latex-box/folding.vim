" Folding support for LaTeX
"
" Options
" g:LatexBox_Folding       - Turn on/off folding
" g:LatexBox_fold_envs     - Turn on/off folding of environments
" g:LatexBox_fold_preamble - Turn on/off folding of preamble
" g:LatexBox_fold_parts    - Define which sections and parts to fold
" g:LatexBox_not_fold      - Define what to not fold

" {{{1 Set options
if exists('g:LatexBox_Folding')
    setl foldmethod=expr
    setl foldexpr=LatexBox_FoldLevel(v:lnum)
    setl foldtext=LatexBox_FoldText(v:foldstart)
endif
if !exists('g:LatexBox_fold_preamble')
    let g:LatexBox_fold_preamble=1
endif
if !exists('g:LatexBox_fold_envs')
    let g:LatexBox_fold_envs=1
endif
if !exists('g:LatexBox_fold_parts')
    let g:LatexBox_fold_parts=[
                \ "part",
                \ "chapter",
                \ "section",
                \ "subsection",
                \ "subsubsection"
                \ ]
endif
if !exists('g:LatexBox_not_fold')
    let g:LatexBox_not_fold=[
                \ "appendix",
                \ "frontmatter",
                \ "mainmatter",
                \ "backmatter"
                \ ]
endif

function! s:Detect_fold_level(delim)
    let s:LatexBox_fold_parts = []
    for i in range(len(g:LatexBox_fold_parts))
        if search('\C^\\' . g:LatexBox_fold_parts[i] . '\*\?\s*{', 'n')
            call add(s:LatexBox_fold_parts, g:LatexBox_fold_parts[i])
        end
    endfor
    return index(s:LatexBox_fold_parts, a:delim)
endfunction

" {{{1 LatexBox_FoldLevel
function! LatexBox_FoldLevel(lnum)
    let lnum = a:lnum
    let nlnum = nextnonblank(lnum)
    let line = getline(nlnum)
	let notbslash = '\%(\\\@<!\%(\\\\\)*\)\@<='
	let notcomment = '\%(\%(\\\@<!\%(\\\\\)*\)\@<=%.*\)\@<!'

    " Fold preamble
    if g:LatexBox_fold_preamble==1
        if nlnum == lnum && line =~# '\s*\\documentclass'
            if search('\C^\s*\\begin\s*{\s*document\s*}', 'n') > nlnum +1
                return ">1"
            else
                return 0
            endif
        elseif line =~# '^\s*\\begin\s*{\s*document\s*}'
            if nlnum==lnum
                return ">". g:LatexBox_fold_envs
            else
                return 0
            endif
        endif
    endif

    " reset foldlevel if \frontmatter \mainmatter \backmatter \appendix
    if line =~# '^\s*\\\%('.join(g:LatexBox_not_fold, '\|') . '\)'
        return g:LatexBox_fold_envs
    endif

    " Fold parts and sections
    let delim = matchstr(line, '^\s*\\\zs\%(' . join(g:LatexBox_fold_parts, '\|') . '\)\ze\*\?\>')
    if !empty(delim)
        if  nlnum == lnum
            return ">" . (s:Detect_fold_level(delim)+ 1 + g:LatexBox_fold_envs)
        else
            return (s:Detect_fold_level(delim) + g:LatexBox_fold_envs)
        endif
    endif

    " Fold environments
    if line =~# '^\s*\\end\s*{document}'
        return g:LatexBox_fold_envs
    endif
    if g:LatexBox_fold_envs==1
        if nlnum == lnum
            if line =~# notcomment . notbslash . '\\begin\s*{.\{-}}'
                return "a1"
            elseif line =~# notcomment . notbslash . '\\end\s*{.\{-}}'
                return "s1"
            endif
        endif
    endif

    " if foldlevel of previous line is known, return it
    " if not, continue to search using "="
    let lvl = foldlevel(lnum - 1)
    if lvl >= 0
        return lvl
    else
        return "="
    endif
endfunction

" {{{1 LatexBox_FoldText
function! LatexBox_FoldText(lnum)
    let line = getline(a:lnum)

    " Define pretext
    let pretext = '+-' .  repeat('-', v:foldlevel)
    let pretext = pretext . printf('%3i', (v:foldend-v:foldstart+1)) . ' lines: '

    " Preamble
    if line =~# '\s*\\documentclass'
        return pretext . "Preamble" . ' '
    endif

    " Parts and sections
    if line =~# '\\\(\(sub\)*section\|part\|chapter\|vtitle\)'
        let title = matchlist(line, '^\s*\\\(\%(sub\)*section\|part\|chapter\|vtitle\)\*\?\s*\[\(.\{1,80}\)')
        if !empty(title)
            return pretext . substitute(title[1], '^\(.\)' , '\u\1', '') . ': ' . substitute(title[2], '\].\{-}$', '', '') . ' '
        endif
        let title = matchlist(line, '^\s*\\\(\%(sub\)*section\|part\|chapter\|vtitle\)\*\?\s*{\(.\{1,80}\)')
        if !empty(title)
            return pretext . substitute(title[1], '^\(.\)' , '\u\1', '') . ': ' . substitute(title[2], '}.\{-}$', '', '') . ' '
        endif
        return pretext. line. ' '
    endif

    " Environments
    if line =~# '\\begin'
        let env = matchstr(line,'\\begin\*\?\s*{\zs.\{-}\ze}')
        if env == 'document'
            return pretext. "Document"
        endif
        let label = ' '
        let caption = ''
        let env = '[' . env . ']'
        let i = v:foldstart
        while i <= v:foldend
            if getline(i) =~# '^\s*\\label'
                let label = ' (' . matchstr(getline(i),
                            \ '^\s*\\label\s*{\zs.*\ze}') . ') '
            end
            if getline(i) =~# '^\s*\\caption'
                let env .=  ': '
                let caption = matchstr(getline(i),
                            \ '^\s*\\caption\s*\(\[.*\]\)\?{\zs.\{1,30}')
                let caption = substitute(caption, '}\s*$', '','')

            end
            let i += 1
        endwhile
        return pretext . env . caption . label
    endif

    " Not defined
    return "Fold text not defined"
endfunction

" {{{1 Footer
" vim:fdm=marker:ff=unix:ts=4:sw=4
