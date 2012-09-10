"left/right arrows to switch buffers in normal mode, this will probably annoy you
map <right> :bn<cr>
map <left> :bp<cr>
map ** gwap
map <F4> :w<CR> :!lacheck %<CR>
map <F8> :w<CR> :!make<CR>
map <S-t> :call PreviewWord()<CR>
" Jump to next word in quickfix list
map <F12> :cn<CR>
map <silent> <F9> :NERDTreeToggle<CR>
nnoremap map <silent> <F9> :NERDTreeToggle<CR>
"map <silent> <F10> :TlistToggle<CR>
"nnoremap <silent> <F10> :TlistToggle<CR>
map <silent> <F10> :TagbarToggle<CR>
nnoremap <silent> <F10> :TagbarToggle<CR>
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
map <buffer> K :execute "!pydoc " . expand("<cword>")<CR>
map <F11> :set paste<CR>i<CR>%---<CR>\vtitle{}<CR>\vid{}<CR>\vclass{}<CR>\vseverity{}<CR>\vdifficulty{}<CR>\vuln<CR><CR>\vtargets<CR><CR>\vdesc<CR><CR>\vscenario<CR><CR>\vshortterm<CR><CR>\vlongterm<CR>  :set nopaste<CR>

" save my pinky
nore ; :
nore , ;

syntax on
filetype plugin on
filetype indent on
helptags ~/.vim/doc

set et          "expand tabs
set diffopt+=iwhite
set cursorline
if has('gui_running')
    set ballooneval
    set balloondelay=100
endif
set gfn=Inconsolata\ 15
set t_Co=256    "use 256 colors
set hidden
set novb
set number
set viewdir=$HOME/.views
set mouse=a     " Turn this off for console-only mode
set selectmode+=mouse
set guioptions=aegit
set shortmess=atI
set scrolloff=3
set ignorecase  "case insensitive searches
set smartcase
set wildmode=list:longest "shows a list of possible values when tab-completing
set shortmess=a
set hlsearch    "highlight all search matches
set nojoinspaces "don't allow two spaces after a period when reformatting
"this is a bunch of goofy auto-format stuff for bulleted lists, etc
set formatoptions=nwrtql 
" This is the default comments string setting, with - added so it can be used 
" in bulletted lists.
set comments=s1:/*,mb:*,ex:*/,://,b:#,b:-,b:+,:%,:XCOMM,n:>,fb:-,b:\\item
set grepprg=grep\ -nH\ $*
set cpoptions=BFst
set printoptions=syntax:n
set tags=tags;/ "use first tags file in a directory tree
set nobackup
set nowritebackup
set directory=/tmp "litter up /tmp, not the CWD
set nomodeline
set showmode
set ts=4        "tabstop
set sw=4        "shiftwidth
set backspace=indent,eol,start
set ruler
set notitle icon
set helpheight=0
set incsearch
set showmatch
set suffixes=.out
set wildignore+=*.bak,~*,*.o,*.aux,*.dvi,*.bbl,*.blg,*.orig,*.toc,*.fls,*.
set wildignore+=*.loc,*.gz,*.latexmain,*.tv,*.ilg,*.lltr,*.lov,*.lstr,*.idx
set wildignore+=*.fdb_latexmk,*.ind
set scrolloff=2
set shortmess=otix
set showcmd
set sidescroll=1
set lazyredraw ttyfast
set errorfile=/tmp/errors.vim
"set updatecount=100 updatetime=3600000		" saves power on notebooks
set cscopequickfix=s-,c-,d-,i-,t-,e-   " omfg so much nicer

"   Settings for vt100
if $TERM == 'vt100'
" makes vim a bit more responsive when on slow terminal
  set noincsearch nottyfast
endif

colorscheme tir_black
source ~/.vim/ftplugin/man.vim

"latex
imap <buffer> [[ \begin{
imap <buffer> ]] <Plug>LatexCloseCurEnv
let g:LatexBox_latexmk_options = "-xelatex"
let g:LatexBox_viewer = "evince"

" supertab
let g:SuperTabContextFileTypeExclusions = ['make']

" Indentguides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1

let s:line1 = getline(1)

" buftabs
let g:buftabs_marker_start = "(("
let g:buftabs_marker_end = "))"

" statline
let g:statline_fugitive=1
let g:statline_trailing_space=0
let g:statline_mixed_indent=0

"tagbar 
let g:tagbar_type_objc = {
    \ 'ctagstype' : 'ObjectiveC',
    \ 'kinds'     : [
        \ 'i:interface',
        \ 'I:implementation',
        \ 'p:Protocol',
        \ 'm:Object_method',
        \ 'c:Class_method',
        \ 'v:Global_variable',
        \ 'F:Object field',
        \ 'f:function',
        \ 'p:property',
        \ 't:type_alias',
        \ 's:type_structure',
        \ 'e:enumeration',
        \ 'M:preprocessor_macro',
    \ ],
    \ 'sro'        : ' ',
    \ 'kind2scope' : {
        \ 'i' : 'interface',
        \ 'I' : 'implementation',
        \ 'p' : 'Protocol',
        \ 's' : 'type_structure',
        \ 'e' : 'enumeration'
    \ },
    \ 'scope2kind' : {
        \ 'interface'      : 'i',
        \ 'implementation' : 'I',
        \ 'Protocol'       : 'p',
        \ 'type_structure' : 's',
        \ 'enumeration'    : 'e'
    \ }
\ }

let g:tagbar_type_tex = {
    \ 'ctagstype' : 'latex',
    \ 'kinds'     : [
        \ 's:sections',
        \ 't:subsections',
        \ 'u:subsubsections',
        \ 'v:vulns',
        \ 'g:graphics',
        \ 'l:labels',
        \ 'r:refs:1',
        \ 'p:pagerefs:1'
    \ ],
    \ 'sort'    : 0,
\ }

" augroups 
augroup c
	au!
"   au BufEnter *.[Cchly] set cindent cinoptions+=n2,t0,(0,p0 cinwords={
	au BufEnter *.[mCchly] set nospell
	au BufEnter *.cpp set nospell
	au BufEnter *.java set nospell
    au BufWinLeave *.[mchly] mkview
    au BufWinEnter *.[mchly] silent loadview
    au BufWinLeave *.cpp mkview
    au BufWinEnter *.cpp silent loadview
    au BufWinLeave *.java mkview
    au BufWinEnter *.java silent loadview
augroup end

augroup html
	au!
	au BufEnter *.htm* set wrapmargin=5 wrapscan
	au BufEnter *.htm* set spell
	au BufLeave *.htm* set wrapscan&
" 	Read the html template automagically when starting a new html file
	au BufNewFile *.html r ~/.vim/template.html
	au BufWinLeave *.htm* mkview
	au BufWinEnter *.htm* silent loadview
augroup end

augroup python
	au BufEnter *.py,*.pyw set smartindent smarttab nospell
	au BufWinLeave *.py mkview
	au BufWinEnter *.py silent loadview
augroup end

augroup latex
    au BufEnter *.tex,*.sty set filetype=tex
    au BufEnter *.tex set spell
    au BufEnter *.tex,*.sty syntax spell toplevel
    au BufEnter *.tex,*.sty set textwidth=78
	au BufEnter *.tex,*.sty let g:Imap_UsePlaceHolders=0
	au BufEnter *.tex,*.sty let g:tex_flavor='latex'
	au BufEnter *.tex,*.sty set comments+=b:\\item
	au BufWinLeave *.tex,*.sty mkview
	au BufWinEnter *.tex,*.sty silent loadview
    au BufEnter deliverable.tex,status.tex badd vulnlist.tex
    au BufEnter deliverable.tex,status.tex badd appendices.tex
    au BufEnter deliverable.tex badd execsummary.tex
augroup end

augroup misc
	au BufWinEnter *.fugitiveblame, set nospell
	au FileType qf, set nospell
	au BufWinEnter *.txt, set spell
	au BufWinLeave *.txt, mkview
	au BufWinEnter *.txt, silent loadview
	au BufWinLeave *.conf, mkview
	au BufWinEnter *.conf, silent loadview
	au BufWinEnter *mutt-*, set spell
    " complete words from the dictionary when writing emails
	au BufWinEnter *mutt-*, set complete+=k
"	au BufWinEnter *mutt-*, UniCycleOn
    au BufEnter *.nse set filetype=lua
	au BufNewFile,BufRead *.md set spell
	au BufWinLeave *.md, mkview
	au BufWinEnter *.md, silent loadview
	au BufWinEnter *.md, set textwidth=78
	au BufWinEnter *.md, set comments+=b:-,b:+,b:*,b:+,n:>
augroup end

au BufWinEnter * call QFBind()
function! QFBind()
    if &buftype==#"quickfix"
        exec "nnoremap <silent> <buffer> <right> :cnew<CR>"
        exec "nnoremap <silent> <buffer> <left> :col<CR>"
    endif
endfunction
