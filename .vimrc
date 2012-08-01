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
map <silent> <F10> :TlistToggle<CR>
nnoremap <silent> <F10> :TlistToggle<CR>
map <buffer> <S-e> :w<CR>:!/usr/bin/env python % <CR>
map <buffer> K :execute "!pydoc " . expand("<cword>")<CR>
map <F11> :set paste<CR>i<CR>%---<CR>\vtitle{}<CR>\vid{}<CR>\vclass{}<CR>\vseverity{}<CR>\vdifficulty{}<CR>\vuln<CR><CR>\vtargets<CR><CR>\vdesc<CR><CR>\vscenario<CR><CR>\vshortterm<CR><CR>\vlongterm<CR>  :set nopaste<CR>

syntax on
set et          "expand tabs
"this is a bunch of goofy auto-format stuff for bulleted lists, etc
set formatoptions=nwrtql 
" This is the default comments string setting, with - added so it can be used 
" in bulletted lists.
set comments=s1:/*,mb:*,ex:*/,://,b:#,b:-,b:+,:%,:XCOMM,n:>,fb:-,b:\\item
set diffopt+=iwhite
set cursorline
set gfn=Inconsolata\ 13
set t_Co=256    "use 256 colors
set novb
set number
set mouse=nv     " Turn this off for console-only mode
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
colorscheme tir_black

filetype plugin on
filetype indent on
set grepprg=grep\ -nH\ $*
helptags ~/.vim/doc

set cpoptions=BFst
set printoptions=syntax:n
set tags=./tags

set nobackup
set nowritebackup
set directory=/tmp "litter up /tmp, not the CWD
"set noswapfile
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
"set errorformat=%f:%l:%m,\"%f\"\\,\ line\ %l\:\ %m
set suffixes=.bak,~,.o,.info,.aux,.dvi,.bbl,.log,.blg,
set scrolloff=2
set shortmess=otix
set showcmd
set sidescroll=1
"set updatecount=100 updatetime=3600000		" saves power on notebooks
set lazyredraw ttyfast
set errorfile=/tmp/errors.vim

"   Settings for vt100
if $TERM == 'vt100'
" makes vim a bit more responsive when on slow terminal
  set noincsearch nottyfast
endif

augroup c
	au!
"   autocmd BufEnter *.[Cchly] set cindent cinoptions+=n2,t0,(0,p0 cinwords={
	autocmd BufEnter *.[mCchly] set nospell
	autocmd BufEnter *.cpp set nospell
	autocmd BufEnter *.java set nospell
au BufWinLeave *.[mchly] mkview
au BufWinEnter *.[mchly] silent loadview
au BufWinLeave *.cpp mkview
au BufWinEnter *.cpp silent loadview
au BufWinLeave *.java mkview
au BufWinEnter *.java silent loadview
augroup end

augroup html
	au!
	autocmd BufEnter *.htm* set wrapmargin=5 wrapscan
	autocmd BufEnter *.htm* set spell
	autocmd BufLeave *.htm* set wrapscan&
" 	Read the html template automagically when starting a new html file
	autocmd BufNewFile *.html r ~/.vim/template.html
	au BufWinLeave *.htm* mkview
	au BufWinEnter *.htm* silent loadview
augroup end

augroup python
	autocmd BufEnter *.py,*.pyw set smartindent smarttab nospell
	au BufWinLeave *.py mkview
	au BufWinEnter *.py silent loadview
augroup end

augroup latex
    autocmd BufEnter *.tex,*.sty set filetype=tex
    autocmd BufEnter *.tex set spell
    autocmd BufEnter *.tex,*.sty syntax spell toplevel
    autocmd BufEnter *.tex,*.sty set textwidth=78
	autocmd BufEnter *.tex,*.sty let g:Imap_UsePlaceHolders=0
	autocmd BufEnter *.tex,*.sty let g:tex_flavor='latex'
	au BufWinLeave *.tex,*.sty mkview
	au BufWinEnter *.tex,*.sty silent loadview
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
"	au BufWinEnter *mutt-*, UniCycleOn
    au BufEnter *.nse set filetype=lua
	au BufNewFile,BufRead *.notes setf notes
	au BufNewFile,BufRead *.notes set spell
augroup end

func PreviewWord()
  if &previewwindow			" don't do this in the preview window
    return
  endif
  let w = expand("<cword>")		" get the word under cursor
  if w != ""				" if there is one ":ptag" to it

" Delete any existing highlight before showing another tag
    silent! wincmd P			" jump to preview window
    if &previewwindow			" if we really get there...
      match none			" delete existing highlight
      wincmd p			" back to old window
    endif

" Try displaying a matching tag for the word under the cursor
    let v:errmsg = ""
    exe "silent! ptag " . w
    if v:errmsg =~ "tag not found"
      return
    endif

    silent! wincmd P			" jump to preview window
    if &previewwindow		" if we really get there...
	 if has("folding")
	   silent! .foldopen		" don't want a closed fold
	 endif
	 call search("$", "b")		" to end of previous line
	 let w = substitute(w, '\\', '\\\\', "")
	 call search('\<\V' . w . '\>')	" position cursor on match
" Add a match highlight to the word at this position
      hi previewWord term=bold ctermbg=green guibg=green
	 exe 'match previewWord "\%' . line(".") . 'l\%' . col(".") . 'c\k*"'
      wincmd p			" back to old window
    endif
  endif
endfun

" vim-latex options
let g:Tex_ViewRule_pdf = 'evince 2>/dev/null'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'xelatex -synctex=1 -interaction=nonstopmode $*'
let g:Imap_UsePlaceHolders = 0
let g:Tex_UseMakefile = 0
let g:Tex_GotoError = 0
let g:Tex_ShowErrorContext = 0
let g:Tex_FoldedSections = 'part,chapter,section,subsection,subsubsection,paragraph,vtitle'
let g:SuperTabContextFileTypeExclusions = ['make']
let g:tex_no_error=1

" Indentguides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1

let s:line1 = getline(1)
" Don't have eclim on by default
"let g:EclimDisabled = 1
