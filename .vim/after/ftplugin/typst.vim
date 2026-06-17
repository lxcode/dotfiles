" Typst preview mappings, mirroring vimtex's localleader workflow.
" Functions live in autoload/typst_preview.vim.
"   <localleader>ll : toggle continuous compilation (typst watch) + open Skim
"   <localleader>lv : view / refocus the PDF in Skim
"   <localleader>lk : stop the watcher
nnoremap <buffer> <silent> <localleader>ll :call typst_preview#toggle()<CR>
nnoremap <buffer> <silent> <localleader>lv :call typst_preview#view()<CR>
nnoremap <buffer> <silent> <localleader>lk :call typst_preview#stop()<CR>
