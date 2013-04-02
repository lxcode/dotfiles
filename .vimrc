"left/right arrows to switch buffers in normal mode
map <right> :bn<cr>
map <left> :bp<cr>
map g<Tab> :bn<CR>
nnoremap <C-Tab> gt
" Make Y behave like C and D
nnoremap Y y$
" Use , in addition to \ for the leader
let mapleader = ","
nmap \ ,
" save my pinky
nore ; :
" But allow the original functionality of ; and ,
noremap ;; ;
noremap ,, ,
" auto-format the current paragraph
nmap -- gwap
nmap __ gqap
" Get rid of jumping behavior when using these search
nnoremap * *<c-o>
nnoremap # #<c-o>
" Clear search pattern with C-/ (only works in terminal)
nmap <silent>  :noh<CR>
" correct spelling
map <F1> 1z=
imap <F1> <Esc>b1z=ea<Space>
map <F4> :w<CR> :!lacheck %<CR>
noremap <F5> :GundoToggle<CR>
map <F8> :w<CR> :!make<CR>
map <silent> <F9> :call ToggleVExplorer()<CR>
map <silent> <F10> :TagbarToggle<CR>
nnoremap <silent> <F10> :TagbarToggle<CR>
" jump to next quickfix item
map <F12> :cn<CR>
" preview the tag under the cursor
map <C-p> :exe "ptag" expand("<cword>")<CR>
nnoremap <silent> <C-c> :call QuickfixToggle()<cr>
" Delete my signature
map <Leader>ds Gvipdgg10j
set pastetoggle=<F11> 
" Window movement
nnoremap <C-j> <C-W>w
nnoremap <C-k> <C-W>W

syntax on
filetype plugin on
filetype indent on
helptags ~/.vim/doc

if has('gui')
    set guioptions=aAegiM       " get rid of useless stuff in the gui
    if has("gui_macvim")
        set guifont=Monaco:h14
        set clipboard=unnamed
        let g:clang_complete_enable = 1
        let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
        let g:clang_user_options='-fblocks -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk -D__IPHONE_OS_VERSION_MIN_REQUIRED=40300'
    else
        set guifont=Inconsolata\ 13
    endif
endif
if has('gui_running')
    set ballooneval
    set balloondelay=100
endif
if $DISPLAY != "" 
    set cursorline          " I like this, but damn is it slow
endif 
set mouse=a                 " Turn this off for console-only mode
set selectmode+=mouse	    " Allow the mouse to select
set et                      " expand tabs
set diffopt+=iwhite,vertical   " ignore whitespace in diffs
set hidden                  " allow hidden buffers
set novb t_vb=              " no visual bell
set nonu                    " line numbers
set viewdir=$HOME/.views    " keep view states out of my .vim
set pumheight=15            " trim down the completion popup menu
set shortmess+=atIoT        " save space in status messages
set scrolloff=3             " 3 lines of buffer before scrolling
set ignorecase              " case insensitive searches
set smartcase               " unless you type uppercase explicitly
set smarttab                " use shiftwidth instead of tab stops
set wildmode=longest,list   " shows a list of candidates when tab-completing
set wildmenu                " use a more functional completion menu when tab-completing
set encoding=utf-8          " always use utf-8
set hlsearch                " highlight all search matches
set nojoinspaces            " disallow two spaces after a period when joining
set formatoptions=qnrtlm    " auto-formatting style for bullets and comments
set autoindent
set shiftround              " Round to the nearest shiftwidth when shifting
set linebreak               " When soft-wrapping long lines, break at a word
set comments-=s1:/*,mb:*,ex:*/
set comments+=fb:*,b:\\item
set formatlistpat=^\\s*[0-9*]\\+[\\]:.)}\\t\ ]\\s*
set grepprg=grep\ -nIH\ $*
set cpoptions=BFt
set completeopt=menuone,longest
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
set ttimeout
set ttimeoutlen=100         " Make it so Esc enters Normal mode right away
set helpheight=0            " no minimum helpheight
set incsearch               " search incrementally
set showmatch               " show the matching terminating bracket
set suffixes=.out           " set priority for tab completion
set wildignore+=*.bak,~*,*.o,*.aux,*.dvi,*.bbl,*.blg,*.orig,*.toc,*.fls
set wildignore+=*.loc,*.gz,*.tv,*.ilg,*.lltr,*.lov,*.lstr,*.idx,*.pdf
set wildignore+=*.fdb_latexmk,*.ind,*.cg,*.tdo,*.log,*.latexmain,*.out
set sidescroll=1            " soft wrap long lines
set lazyredraw ttyfast      " go fast
set errorfile=/tmp/errors.vim
set cscopequickfix=s-,c-,d-,i-,t-,e-        " omfg so much nicer
set foldlevelstart=2        " the default level of fold nesting on startup
set virtualedit=block       " when doing block select, allow going past the end of lines
"set updatecount=100 updatetime=3600000		" saves power on notebooks

" colors
set t_Co=256                " use 256 colors
"let g:zenburn_high_Contrast=1
colorscheme lx-256-dark

" 33ms startup penalty!
source ~/.vim/ftplugin/man.vim

"netrw
"let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=25

" quickfixsigns
let g:quickfixsigns_classes=['qfl', 'loc', 'marks', 'vcsdiff', 'breakpoints']
" Disable display of the ' and . marks, so the gutter will be disabled until
" manually set marks or quickfix/diff info is present.
let g:quickfixsigns#marks#buffer = split('abcdefghijklmnopqrstuvwxyz', '\zs')

" buftabs
let g:buftabs_only_basename=1

"latex
let g:tex_no_error=1
let g:tex_comment_nospell = 1
"let g:LatexBox_latexmk_options = "-pdflatex=lualatex -latex=lualatex"
let g:LatexBox_latexmk_options = "-xelatex"
if has("macunix")
    let g:LatexBox_viewer = "open"
else
    let g:LatexBox_viewer = "evince"
endif
let g:LatexBox_split_side = "rightbelow"
let g:LatexBox_Folding = 1
let g:LatexBox_fold_preamble = 1
let g:LatexBox_fold_envs = 0
let g:LatexBox_quickfix = 0
let g:LatexBox_show_warnings = 0
let g:LatexBox_ignore_warnings = [
            \ 'Underfull',
            \ 'Overfull',
            \ 'specifier changed to',
            \ 'Font shape',
            \ 'epstopdf',
            \ ]

let g:LatexBox_fold_parts=[
           \ "part",
           \ "chapter",
           \ "section",
           \ "subsection",
           \ "subsubsection",
           \ "vtitle"
           \ ]

augroup latex
    au BufWritePost *.tex silent! Latexmk
    " The NoStarch style is a bit crufty and needs pdflatex
    au BufWinEnter book.tex let g:LatexBox_latexmk_options = "" 
    au BufWinEnter book.tex let g:LatexBox_fold_envs = 1
    au BufWinEnter *.tex source ~/.vim/ftplugin/quotes.vim
    au BufWinEnter *.tex,*.sty syntax spell toplevel 
    au BufWinEnter *.tex,*.sty set spell filetype=tex textwidth=78 smartindent
    au BufWinEnter *.tex,*.sty set comments+=b:\\item formatoptions-=q foldlevel=6
    au BufWinEnter *.tex,*.sty imap <buffer> [[ \begin{
    au BufWinEnter *.tex,*.sty imap <buffer> ]] <Plug>LatexCloseCurEnv
    au BufWinEnter *.tex,*.sty imap <S-Enter> \pagebreak
    au BufWinEnter *.tex,*.sty map tt i{\tt <Esc>wEa}<Esc>
    au BufWinLeave *.tex,*.sty mkview
    au BufWinEnter *.tex,*.sty silent loadview
augroup end

" supertab
let g:SuperTabContextFileTypeExclusions = ['make']
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery =
    \ ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

autocmd FileType *
            \  if &omnifunc != '' |
            \      let g:myfunc = &omnifunc |
            \  elseif &completefunc != '' |
            \      let g:myfunc = &completefunc |
            \  else |
            \      let g:myfunc = '' |
            \  endif |
            \  if g:myfunc != '' |
            \      call SuperTabChain(g:myfunc, "<c-p>") |
            \      call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
            \  endif

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
let g:vimchat_pync_enabled = 1
"map g<Tab> gt

" CtrlP
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_map = '<C-e>'
let g:ctrlp_by_filename = 1
let g:ctrlp_working_path_mode = 0
let g:ctrlp_max_height = 30
let g:ctrlp_clear_cache_on_exit = 0
map <Leader>e :CtrlP<CR>
map <Leader>b :CtrlPBuffer<CR>
map <Leader>m :CtrlPMRU<CR>

" statline
let g:statline_fugitive=1
let g:statline_trailing_space=0
let g:statline_mixed_indent=0

" yankstack
let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']
nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_older_paste

" grephere
nmap <Leader>g <Plug>(GrepHereCurrent) 

" vim-notes
let g:notes_directory = '~/Documents/Notes'
let g:notes_suffix = '.notes'

" clang
let g:clang_complete_enable = 1
let g:clang_complete_copen = 1
let g:clang_snippets = 1
"let g:clang_snippets_engine = 'snipmate'
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
        \ 'g:graphics',
        \ 'l:labels',
        \ 'r:refs:1',
        \ 'p:pagerefs:1',
        \ 'v:vulns',
        \ 'r:strecs',
        \ 'R:ltrecs'
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
    au BufWinEnter *.[mCchly] set nospell comments+=s1:/*,mb:*,ex:*/
    au BufRead,BufNewFile *.m setfiletype objc
    au BufRead,BufNewFile *.m let c_no_curly_error = 1
    au BufWinEnter *.cpp,*.java set nospell number
    au BufWinLeave *.[mchly] mkview
    au BufWinEnter *.[mchly] silent loadview
    au BufWinLeave *.cpp,*.java mkview
    au BufWinEnter *.cpp,*.java silent loadview
augroup end

augroup html
    au!
    au FileType html set spell wrapmargin=5 wrapscan number
    au FileType html set wrapscan&
    au BufNewFile *.html r ~/.vim/templates/template.html
    au BufWinLeave *.htm* mkview
    au BufWinEnter *.htm* silent loadview
augroup end

augroup python
    au FileType python set smartindent smarttab nospell number
    au BufWinLeave *.py mkview
    au BufWinEnter *.py silent loadview
augroup end

augroup markdown
    au BufWinLeave *.md, mkview
    au BufWinEnter *.md, silent loadview
    au BufWinEnter *.md,*.notes, imap <C-l> <C-t>
    au BufWinEnter *.md,*.notes, imap <C-h> <C-d>
    au BufWinEnter *.md,*.notes, imap >> <C-t>
    au BufWinEnter *.md,*.notes, imap << <C-d>
    au FileType markdown set spell
    au FileType markdown set textwidth=78 complete+=k comments+=b:-,b:+,b:*,b:+,n:>
augroup end

" Disable spellcheck on quickfix, switch between quickfix lists with the arrow 
" keys
augroup quickfix
    au FileType qf, noremap ' <CR><C-W><C-P>j 
    au FileType qf, set nospell number
    au FileType qf, nnoremap <silent> <buffer> <right> :cnew<CR>
    au FileType qf, nnoremap <silent> <buffer> <left> :col<CR>
    au FileType qf, setlocal statusline=\ %n\ \ %f%=L%l/%L\ %P
augroup end

augroup msdocs
    au BufReadCmd *.docx,*.xlsx,*.pptx call zip#Browse(expand("<amatch>"))
    au BufReadCmd *.odt,*.ott,*.ods,*.ots,*.odp,*.otp,*.odg,*.otg call zip#Browse(expand("<amatch>"))
augroup end

augroup misc
    au BufWinEnter *.fugitiveblame,*.diff, set nospell number
    au BufWinEnter *.plist, call ReadPlist()
    au BufWinLeave *.txt,*.conf,.vimrc,*.notes mkview
    au BufWinEnter *.txt,*.conf,.vimrc,*.notes silent loadview
    au FileType make set diffopt-=iwhite
    au FileType vim set nospell
    au FileType mail set spell complete+=k nonu formatoptions+=a
    " par is much better at rewrapping mail
    au FileType mail if executable("par") | set formatprg=par | endif
    au FileType mail map <F8> :%g/^> >/d<CR>gg10j
    au BufWinEnter *vimChatRoster, set foldlevel=1
    au BufWinEnter *.nse set filetype=lua
    " What - like how does this even work
    au InsertLeave * hi! link CursorLine CursorLine 
    au InsertEnter * hi! link CursorLine Normal
augroup end

augroup syntax
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup end 

if (&ft=='help')
    set nospell
endif

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

" Toggle Vexplore
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

" Some quick bindings to edit binary plists
command -bar PlistXML :set binary | :1,$!plutil -convert xml1 /dev/stdin -o -
command -bar Plistbin :1,$!plutil -convert binary1 /dev/stdin -o -

fun ReadPlist()
    if getline("'[") =~ "^bplist"
        :PlistXML
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
