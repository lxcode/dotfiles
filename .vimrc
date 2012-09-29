"left/right arrows to switch buffers in normal mode
map <right> :bn<cr>
map <left> :bp<cr>
" there's probably some very good reason to not do this, guess I'll find out
nnoremap <Tab> :bn<CR>
" auto-format the current paragraph
map ** gwap
" correct spelling
map <F1> 1z=
imap <F1> <Esc>b1z=ea<Space>
map <F4> :w<CR> :!lacheck %<CR>
map <F8> :w<CR> :!make<CR>
map <silent> <F9> :NERDTreeToggle<CR>
nnoremap map <silent> <F9> :NERDTreeToggle<CR>
map <silent> <F10> :TagbarToggle<CR>
nnoremap <silent> <F10> :TagbarToggle<CR>
" jump to next quickfix item
map <F12> :cn<CR>
" preview the tag under the cursor
map <C-p> :exe "ptag" expand("<cword>")<CR>
nnoremap <silent> <C-c> :call QuickfixToggle()<cr>
" Delete my signature
map dS Gvipdgg10j

" save my pinky
nore ; :
nore , ;

syntax on
filetype plugin on
filetype indent on
helptags ~/.vim/doc

if has('gui')
    set guioptions=aAegiM       " get rid of useless stuff in the gui
    if has("gui_macvim")
        set guifont=Monaco:h14
    else
        set guifont=Inconsolata\ 15
    endif
endif
if has('gui_running')
    set ballooneval
    set balloondelay=100
endif
if $DISPLAY != "" 
    set mouse=a             " Turn this off for console-only mode
    set selectmode+=mouse	" Allow the mouse to select
endif 
set et                      " expand tabs
set diffopt+=iwhite         " ignore whitespace in diffs
set cursorline              " I like this, but damn is it slow
set hidden                  " allow hidden buffers
set novb                    " no visual bell
set number                  " line numbers
set viewdir=$HOME/.views    " keep view states out of my .vim
set pumheight=15            " trim down the completion popup menu
set shortmess+=atIoT        " save space in status messages
set scrolloff=3             " 3 lines of buffer before scrolling
set ignorecase              " case insensitive searches
set smartcase               " unless you type uppercase explicitly
set wildmode=list:longest   " shows a list of candidates when tab-completing
set hlsearch                " highlight all search matches
set nojoinspaces            " disallow two spaces after a period when joining
set formatoptions=nwrtqljm  " auto-formatting style for bullets and comments
set autoindent
set comments-=s1:/*,mb:*,ex:*/
set comments+=fb:*,b:\\item
set formatlistpat=^\\s*[0-9*]\\+[\\]:.)}\\t\ ]\\s*
set grepprg=grep\ -nH\ $*
set cpoptions=BFt
set tags=tags;/             " use first tags file in a directory tree
set nobackup                " ugh, stop making useless crap
set nowritebackup           " same with overwriting
set directory=/tmp          " litter up /tmp, not the CWD
set nomodeline              " modelines are dumb
set tabstop=4 shiftwidth=4
set backspace=indent,eol,start
set ruler                   " show position in file
set title icon              " set title data for gui
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
set helpheight=0            " no minimum helpheight
set incsearch               " search incrementally
set showmatch               " show the matching terminating bracket
set suffixes=.out           " set priority for tab completion
set wildignore+=*.bak,~*,*.o,*.aux,*.dvi,*.bbl,*.blg,*.orig,*.toc,*.fls,*.
set wildignore+=*.loc,*.gz,*.latexmain,*.tv,*.ilg,*.lltr,*.lov,*.lstr,*.idx
set wildignore+=*.fdb_latexmk,*.ind
set sidescroll=1            " soft wrap long lines
set lazyredraw ttyfast      " go fast
set errorfile=/tmp/errors.vim
set cscopequickfix=s-,c-,d-,i-,t-,e-   " omfg so much nicer
set foldlevelstart=2        " the default level of fold nesting on startup
"set updatecount=100 updatetime=3600000		" saves power on notebooks

" colors
set t_Co=256                " use 256 colors
let g:zenburn_high_Contrast=1
colorscheme lx-256-dark

source ~/.vim/ftplugin/man.vim

"latex
let g:LatexBox_latexmk_options = "-xelatex"
let g:LatexBox_viewer = "evince"
let g:Latexbox_Folding = 'yes'
let g:tex_comment_nospell=1

augroup latex
    au BufWritePost *.tex silent! Latexmk
    au BufEnter *.tex,*.sty syntax spell toplevel 
    au BufEnter *.tex,*.sty set spell filetype=tex textwidth=78 smartindent
	au BufEnter *.tex,*.sty set comments+=b:\\item 
	au BufEnter *.tex,*.sty imap <buffer> [[ \begin{
	au BufEnter *.tex,*.sty imap <buffer> ]] <Plug>LatexCloseCurEnv
	au BufEnter *.tex,*.sty imap <S-Enter> \pagebreak
    au BufEnter *.tex,*.sty map tt i{\tt <Esc>wEa}<Esc>
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
let g:ctrlp_by_filename = 1
let g:ctrlp_max_height = 30
map <Leader>e :CtrlP<CR>
map <Leader>b :CtrlPBuffer<CR>
map <Leader>m :CtrlPMRU<CR>

" statline
let g:statline_fugitive=1
let g:statline_trailing_space=0
let g:statline_mixed_indent=0

" grephere
nmap <C-n> <Plug>(GrepHereCurrent) 

" clang
"let g:clang_complete_enable = 1
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

augroup markdown
	au BufNewFile,BufRead *.md set spell
	au BufWinLeave *.md, mkview
	au BufWinEnter *.md, silent loadview
	au BufWinEnter *.md, set textwidth=78 complete+=k comments+=b:-,b:+,b:*,b:+,n:>
    au BufWinEnter *.md, imap >> <C-t>
    au BufWinEnter *.md, imap << <C-d>
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
	au BufWinEnter *.txt, set spell textwidth=78
	au BufWinLeave *.txt, mkview
	au BufWinEnter *.txt, silent loadview
	au BufWinLeave *.conf, mkview
	au BufWinEnter *.conf, silent loadview
	au BufWinEnter *mutt-*, set spell complete+=k
	au BufWinEnter *mutt-*, UniCycleOn
	au BufWinEnter *vimChatRoster, set foldlevel=1
    au BufEnter *.nse set filetype=lua
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

" ex command for toggling hex mode - define mapping if desired
command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction
