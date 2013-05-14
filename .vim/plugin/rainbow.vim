"==============================================================================
"Script Title: rainbow parentheses improved
"Script Version: 2.51.1
"Author: luochen1990, oblitum
"Last Edited: 2012 Nov 29
"Simple Configuration:
"    first, put "rainbow.vim"(this file) to dir vim73/plugin or vimfiles/plugin
"    second, add the follow sentences to your .vimrc or _vimrc :
"
"            let g:rainbow_active = 1
"
"    third, restart your vim and enjoy coding.
"Advanced Configuration:
"    an advanced configuration allows you to define what parentheses to use 
"    for each type of file . you can also determine the colors of your 
"    parentheses by this way (read file vim73/rgb.txt for all named colors) .
"        e.g. this is an advanced config (add these sentences to your vimrc):
"
"            let g:rainbow_active = 1
"       
"            let g:rainbow_load_separately = [
"                \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"                \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
"                \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
"                \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
"                \ ]
"       
"            let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick',]
"
"User Command:
"   :RainbowToggle  --you can use it to toggle this plugin.
"   :Rainbow        --you can use it to toggle this plugin.


" read file vim73/rgb.txt for all named colors
let s:guifgs = exists('g:rainbow_guifgs')? g:rainbow_guifgs : [
            \ 'DeepSkyBlue', 'ChartReuse', 'Yellow', 'Coral', 'DeepPink',
            \ 'Purple'
            \ ]

let s:ctermfgs = exists('g:rainbow_ctermfgs')? g:rainbow_ctermfgs : [
            \ 'lightblue', 'lightgreen', 'yellow', 'red', 'magenta'
            \ ]

let s:max = has('gui_running')? len(s:guifgs) : len(s:ctermfgs)

func rainbow#load(...)
    if exists('b:loaded')
        cal rainbow#clear()
    endif

    if a:0 >= 1
        let b:loaded = a:1
    elseif &ft == 'cpp'
        let b:loaded = [
                    \ ['(', ')'],
                    \ ['\[', '\]'],
                    \ ['{', '}'],
                    \ ['\v%(<operator\_s*)@<!%(%(\_i|template\_s*)@<=\<[<#=]@!|\<@<!\<[[:space:]<#=]@!)', '>']
                    \ ]
    else
        let b:loaded = [ ['(', ')'], ['\[', '\]'], ['{', '}'] ]
    endif

    "let b:operators = (a:0 < 2) ? '"\v[{\[(<_"''`#*/>)\]}]@![[:punct:]]|\*/@!|/[/*]@!|\<#@!|#@<!\>"' : a:2
    let b:operators = ""

    let str = 'TOP'
    for each in range(1, s:max)
        let str .= ',lv'.each
    endfor

    if b:operators != ''
        exe 'syn match op_lv0 '.b:operators
        let cmd = 'syn match %s %s containedin=%s contained'
        for [left , right] in b:loaded
            for each in range(1, s:max)
                exe printf(cmd, 'op_lv'.each, b:operators, 'lv'.each)
            endfor
        endfor
    endif

    let cmd = 'syn region %s matchgroup=%s start=+%s+ end=+%s+ containedin=%s contains=%s,%s,@Spell fold'
    for [left , right] in b:loaded
        for each in range(1, s:max)
            exe printf(cmd, 'lv'.each, 'lv'.each.'c', left, right, 'lv'.(each % s:max + 1), str, 'op_lv'.each)
        endfor
    endfor

    cal rainbow#activate()
endfunc

func rainbow#clear()
    if exists('b:loaded')
        unlet b:loaded
        exe 'syn clear op_lv0'
        for each in range(1 , s:max)
            exe 'syn clear lv'.each
            exe 'syn clear op_lv'.each
        endfor
    endif
endfunc

func rainbow#activate()
    if !exists('b:loaded')
        cal rainbow#load()
    endif
    exe 'hi default op_lv0 ctermfg='.s:ctermfgs[-1].' guifg='.s:guifgs[-1]
    for id in range(1 , s:max)
        let ctermfg = s:ctermfgs[(s:max - id) % len(s:ctermfgs)]
        let guifg = s:guifgs[(s:max - id) % len(s:guifgs)]
        exe 'hi default lv'.id.'c ctermfg='.ctermfg.' guifg='.guifg
        exe 'hi default op_lv'.id.' ctermfg='.ctermfg.' guifg='.guifg
    endfor
    exe 'syn sync fromstart'
    let b:active = 'active'
endfunc

func rainbow#inactivate()
    if exists('b:active')
        exe 'hi clear op_lv0'
        for each in range(1, s:max)
            exe 'hi clear lv'.each.'c'
            exe 'hi clear op_lv'.each.''
        endfor
        exe 'syn sync fromstart'
        unlet b:active
    endif
endfunc

func rainbow#toggle()
    if exists('b:active')
        cal rainbow#inactivate()
    else
        cal rainbow#activate()
    endif
endfunc

if exists('g:rainbow_active') && g:rainbow_active
    if exists('g:rainbow_load_separately')
        let ps = g:rainbow_load_separately
        for i in range(len(ps))
            if len(ps[i]) < 3
                exe printf('auto syntax,bufnewfile,bufreadpost %s call rainbow#load(ps[%d][1])' , ps[i][0] , i)
            else
                exe printf('auto syntax,bufnewfile,bufreadpost %s call rainbow#load(ps[%d][1] , ps[%d][2])' , ps[i][0] , i , i)
            endif
        endfor
    else
        auto syntax,bufnewfile,bufreadpost * call rainbow#load()
    endif 
endif

command! RainbowToggle call rainbow#toggle()
command! RainbowLoad call rainbow#load()
