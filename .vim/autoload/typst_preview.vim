" autoload/typst_preview.vim
" Continuous Typst preview in a kitty split via tdf, modeled on vimtex's
" localleader workflow. Mappings live in after/ftplugin/typst.vim.
" Requires kitty remote control: allow_remote_control + listen_on in kitty.conf
" (restart kitty after enabling). tdf hot-reloads the PDF as `typst watch`
" rewrites it.

" Project root: the git toplevel (so absolute /template imports resolve),
" falling back to the file's own directory when not in a repo.
function! s:root() abort
    let l:root = trim(system('git -C ' . shellescape(expand('%:p:h')) . ' rev-parse --show-toplevel'))
    if v:shell_error != 0 || empty(l:root)
        return expand('%:p:h')
    endif
    return l:root
endfunction

" A stable, repo-free output path under ~/.cache, unique per source file.
function! s:pdf() abort
    let l:cache = expand('~/.cache/typst-preview')
    call mkdir(l:cache, 'p')
    return l:cache . '/' . substitute(expand('%:p:r'), '/', '%', 'g') . '.pdf'
endfunction

" Open tdf on {pdf} in a vertical kitty split, keeping focus on the editor.
function! s:launch_viewer(pdf) abort
    let l:id = trim(system('kitten @ launch --type=window --location=vsplit --keep-focus --cwd '
                \ . shellescape(fnamemodify(a:pdf, ':h')) . ' tdf ' . shellescape(a:pdf)))
    if v:shell_error == 0 && l:id =~# '^\d\+$'
        let b:typst_view_window = l:id
    else
        echohl ErrorMsg
        echo 'typst: could not open kitty split -- enable remote control in kitty.conf and restart kitty'
        echohl None
    endif
endfunction

function! typst_preview#running() abort
    return exists('b:typst_watch_job') && job_status(b:typst_watch_job) ==# 'run'
endfunction

" Focus the existing preview split, or open one if none is alive.
function! typst_preview#view() abort
    let l:pdf = get(b:, 'typst_pdf', s:pdf())
    if !filereadable(l:pdf)
        echo 'typst: no preview yet -- press <localleader>ll'
        return
    endif
    if exists('b:typst_view_window')
        call system('kitten @ focus-window --match id:' . b:typst_view_window)
        if v:shell_error == 0
            return
        endif
    endif
    call s:launch_viewer(l:pdf)
endfunction

" Compile once (surfacing errors), watch in the background, open the split.
function! typst_preview#start() abort
    silent! update
    let l:src = expand('%:p')
    let l:root = s:root()
    let l:pdf = s:pdf()
    let l:out = system('typst compile --root ' . shellescape(l:root)
                \ . ' ' . shellescape(l:src) . ' ' . shellescape(l:pdf))
    if v:shell_error != 0
        echohl ErrorMsg | echo "typst:\n" . l:out | echohl None
        return
    endif
    let b:typst_pdf = l:pdf
    let l:log = fnamemodify(l:pdf, ':r') . '.log'
    let b:typst_watch_job = job_start(
                \ ['typst', 'watch', '--root', l:root, l:src, l:pdf],
                \ {'out_io': 'file', 'out_name': l:log,
                \  'err_io': 'file', 'err_name': l:log})
    call s:launch_viewer(l:pdf)
    echo 'typst: watching ' . fnamemodify(l:src, ':t') . ' -> tdf'
endfunction

" Stop the watcher and close the preview split.
function! typst_preview#stop() abort
    if typst_preview#running()
        call job_stop(b:typst_watch_job)
        echo 'typst: watch stopped'
    else
        echo 'typst: no watcher running'
    endif
    if exists('b:typst_view_window')
        call system('kitten @ close-window --match id:' . b:typst_view_window)
        unlet b:typst_view_window
    endif
endfunction

" <localleader>ll toggles, just like vimtex's continuous-compilation binding.
function! typst_preview#toggle() abort
    if typst_preview#running()
        call typst_preview#stop()
    else
        call typst_preview#start()
    endif
endfunction
