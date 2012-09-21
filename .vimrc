"left/right arrows to switch buffers in normal mode, this will probably annoy you
map <right> :bn<cr>
map <left> :bp<cr>
map ** gwap
map <F1> 1z=
imap <F1> <Esc>b1z=ea<Space>
map <F4> :w<CR> :!lacheck %<CR>
map <F8> :w<CR> :!make<CR>
map <silent> <F9> :NERDTreeToggle<CR>
nnoremap map <silent> <F9> :NERDTreeToggle<CR>
map <silent> <F10> :TagbarToggle<CR>
nnoremap <silent> <F10> :TagbarToggle<CR>
map <F12> :cn<CR>
map <C-p> :exe "ptag" expand("<cword>")<CR>
nnoremap <silent> <C-c> :call QuickfixToggle()<cr>
"set thesaurus+=/home/lx/.vim/thesaurus.txt

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
set guifont=Inconsolata\ 14
if has("gui_macvim")
  set guifont=Monaco:h14
endif
set t_Co=256    "use 256 colors
set hidden
set formatprg=par
set novb
set number
set viewdir=$HOME/.views
set mouse=a     " Turn this off for console-only mode
set selectmode+=mouse
set guioptions=aegit
set pumheight=15
set shortmess+=atIoT
set scrolloff=3
set ignorecase  "case insensitive searches
set smartcase
set wildmode=list:longest "shows a list of possible values when tab-completing
set hlsearch    "highlight all search matches
set nojoinspaces "don't allow two spaces after a period when reformatting
"this is a bunch of goofy auto-format stuff for bulleted lists, etc
set formatoptions=nwrtqljm
set autoindent
" This is the default comments string setting, with - added so it can be used 
" in bulletted lists.
set comments-=s1:/*,mb:*,ex:*/
set comments+=fb:*,b:\\item
set formatlistpat=^\\s*[0-9*]\\+[\\]:.)}\\t\ ]\\s*
set grepprg=grep\ -nH\ $*
set cpoptions=BFst
set printoptions=syntax:n
set tags=tags;/ "use first tags file in a directory tree
set nobackup
set nowritebackup
set directory=/tmp "litter up /tmp, not the CWD
set nomodeline
set showmode
set ts=4
set sw=4
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
set showcmd
set sidescroll=1
set lazyredraw ttyfast
set errorfile=/tmp/errors.vim
"set updatecount=100 updatetime=3600000		" saves power on notebooks
set cscopequickfix=s-,c-,d-,i-,t-,e-   " omfg so much nicer
set foldlevelstart=2

colorscheme lx-256-dark
source ~/.vim/ftplugin/man.vim

"latex
let g:LatexBox_latexmk_options = "-xelatex"
let g:LatexBox_viewer = "evince"
let g:Latexbox_Folding = 'yes'
let g:tex_verbspell = 'yes'
map tt i{\tt <Esc>wEa}<Esc>

augroup latex
    au BufWritePost *.tex silent! Latexmk
    au BufEnter *.tex,*.sty syntax spell toplevel 
    au BufEnter *.tex,*.sty set spell filetype=tex textwidth=78 smartindent
	au BufEnter *.tex,*.sty set comments+=b:\\item 
	au BufEnter *.tex,*.sty imap <buffer> [[ \begin{
	au BufEnter *.tex,*.sty imap <buffer> ]] <Plug>LatexCloseCurEnv
	au BufEnter *.tex,*.sty imap <S-Enter> \pagebreak
    au BufEnter deliverable.tex,status.tex badd vulnlist.tex
    au BufEnter deliverable.tex,status.tex,vulnlist.tex badd appendices.tex
    au BufEnter deliverable.tex badd execsummary.tex
	au BufWinLeave *.tex,*.sty mkview
	au BufWinEnter *.tex,*.sty silent loadview
augroup end

" supertab
let g:SuperTabContextFileTypeExclusions = ['make']
let g:SuperTabDefaultCompletionType = "context"

" cctree
let g:CCTreeSplitProgCmd="/usr/local/bin/gsplit"

" Indentguides
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_guide_size = 1

let s:line1 = getline(1)

" vimchat
let g:vimchat_otr = 1
let g:vimchat_statusicon = 0
let g:vimchat_showPresenceNotification = -1
map g<Tab> gt

" CtrlP
let g:ctrlp_map = '<C-e>'
let g:ctrlp_max_height = 30



" statline
let g:statline_fugitive=1
let g:statline_trailing_space=0
let g:statline_mixed_indent=0

" grephere
nmap <C-n> <Plug>(GrepHereCurrent) 

" clang
let g:clang_complete_copen = 0
let g:clang_snippets = 1
let g:clang_snippets_engine = 'snipmate'
let g:clang_use_library = 1

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

let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
                \ 'h:Heading_L1',
                \ 'i:Heading_L2',
                \ 'k:Heading_L3'
        \ ]
\ }

" augroups 
augroup cjava
	au!
	au BufNewFile *.c r ~/.vim/templates/template.c
	au BufEnter *.[mCchly] set nospell comments+=s1:/*,mb:*,ex:*/
    au BufRead,BufNewFile *.m setfiletype objc
	au BufEnter *.cpp,*.java set nospell
    au BufWinLeave *.[mchly] mkview
    au BufWinEnter *.[mchly] silent loadview
    au BufWinLeave *.cpp,*.java mkview
    au BufWinEnter *.cpp,*.java silent loadview
augroup end

augroup html
	au!
	au BufEnter *.htm* set spell wrapmargin=5 wrapscan
	au BufLeave *.htm* set wrapscan&
	au BufNewFile *.html r ~/.vim/templates/template.html
	au BufWinLeave *.htm* mkview
	au BufWinEnter *.htm* silent loadview
augroup end

augroup python
	au BufEnter *.py,*.pyw set smartindent smarttab nospell
	au BufWinLeave *.py mkview
	au BufWinEnter *.py silent loadview
augroup end

" Disable spellcheck on quickfix, switch between quickfix lists with the arrow 
" keys
augroup quickfix
	au FileType qf, noremap ' <CR><C-W><C-P>j 
	au FileType qf, set nospell
	au FileType qf, nnoremap <silent> <buffer> <right> :cnew<CR>
	au FileType qf, nnoremap <silent> <buffer> <left> :col<CR>
augroup end

augroup misc
	au BufWinEnter *.fugitiveblame, set nospell
	au BufWinEnter *.txt, set spell
	au BufWinLeave *.txt, mkview
	au BufWinEnter *.txt, silent loadview
	au BufWinLeave *.conf, mkview
	au BufWinEnter *.conf, silent loadview
	au BufWinEnter *mutt-*, set spell complete+=k
	au BufWinEnter *mutt-*, UniCycleOn
	au BufWinEnter *vimChatRoster, set foldlevel=1
    au BufEnter *.nse set filetype=lua
	au BufNewFile,BufRead *.md set spell
	au BufWinLeave *.md, mkview
	au BufWinEnter *.md, silent loadview
	au BufWinEnter *.md, set textwidth=78 complete+=k comments+=b:-,b:+,b:*,b:+,n:>
    au BufWinEnter *.md, imap >> <C-t>
    au BufWinEnter *.md, imap << <C-d>
augroup end

" Quickfix toggle
let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
