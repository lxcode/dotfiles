"left/right arrows to switch buffers in normal mode
map <right> :bn<cr>
map <left> :bp<cr>
map <home> :rewind<cr>
map <end> :last<cr>
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
nmap -- gwip
nmap __ gqip
" Get rid of jumping behavior when using these search
nnoremap * *<c-o>
nnoremap # #<c-o>
" Clear search pattern with C-/ (only works in terminal)
map <silent>  :noh<CR>
map <silent> <Leader>/ :noh<CR>
" correct spelling
nmap <F1> [s1z=<C-o>
imap <F1> <Esc>[s1z=<C-o>a
map <F4> :w<CR> :!lacheck %<CR>
noremap <F5> :GundoToggle<CR>
map <F8> :w<CR> :!make<CR>
map <silent> <F9> :call ToggleVExplorer()<CR>
map <silent> <F10> :TagbarToggle<CR>
nnoremap <silent> <F10> :TagbarToggle<CR>
" jump to next quickfix item
map <F12> :cn<CR>
" preview the tag under the cursor
nmap <C-p> :exe "ptag" expand("<cword>")<CR>
nnoremap <silent> <C-c> :call QuickfixToggle()<cr>
set pastetoggle=<F11> 
" Window movement
nnoremap <C-j> <C-W>w
nnoremap <C-k> <C-W>W
" Keep selected blocks selected when shifting
vmap > >gv
vmap < <gv
" Insert a single character with space
nmap <Space> :exec "normal i".nr2char(getchar())."\e"<CR>
nmap <Leader>x :call system("cd `dirname %` && urxvt")<CR>
" Change to the directory of the current file
nmap cd :lcd %:h \| :pwd<CR>
" Delete a vuln
" This works when I type it, but not here...
nmap dav ?%<CR>2d/%---\|\\vtitle<CR>


syntax on
filetype plugin on
filetype indent on
helptags ~/.vim/doc

if has('gui')
    set gcr=n:blinkon0          " don't blink the cursor in normal mode
    set guioptions=aAegiM       " get rid of useless stuff in the gui
    if has("gui_macvim")
        set guifont=Inconsolata:h18
        set clipboard=unnamed
    else
        set guifont=Inconsolata\ 14
    endif
endif
if has('gui_running')
    set ballooneval
    set balloondelay=100
endif
if $DISPLAY != "" 
    set cursorline          " I like this, but damn is it slow
    set mouse=a             " Turn this off for console-only mode
    set selectmode+=mouse	" Allow the mouse to select
endif 
set et                      " expand tabs
set diffopt+=iwhite,vertical,filler   " ignore whitespace in diffs
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
"set hlsearch                " highlight all search matches
set nojoinspaces            " disallow two spaces after a period when joining
set formatoptions=qnrtlm    " auto-formatting style for bullets and comments
set autoindent
set shiftround              " Round to the nearest shiftwidth when shifting
set linebreak               " When soft-wrapping long lines, break at a word
set comments-=s1:/*,mb:*,ex:*/
set comments+=fb:*,b:\\item
set formatlistpat=^\\s*\\([0-9]\\+\\\|[a-z]\\)[\\].:)}]\\s\\+
set grepprg=grep\ -R\ --exclude=\"*scope.out\"\ --color=always\ -nIH\ $* " need to make this portable
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
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
set ttimeout
set ttimeoutlen=100         " Make it so Esc enters Normal mode right away
set helpheight=0            " no minimum helpheight
set incsearch               " search incrementally
set showmatch               " show the matching terminating bracket
set suffixes=.out           " set priority for tab completion
set wildignore+=*.bak,~*,*.o,*.aux,*.dvi,*.bbl,*.blg,*.orig,*.toc,*.fls
set wildignore+=*.loc,*.gz,*.tv,*.ilg,*.lltr,*.lov,*.lstr,*.idx,*.pdf
set wildignore+=*.fdb_latexmk,*.ind,*.cg,*.tdo,*.log,*.latexmain
set sidescroll=1            " soft wrap long lines
set lazyredraw ttyfast      " go fast
set errorfile=/tmp/errors.vim
set cscopequickfix=s-,c-,d-,i-,t-,e-        " omfg so much nicer
set foldlevelstart=2        " the default level of fold nesting on startup
set cryptmethod=blowfish    " in case I ever decide to use vim -x
"set updatecount=100 updatetime=3600000		" saves power on notebooks

if exists('&autochdir')
    " Change directory to first open file
    set autochdir
    set noautochdir
endif

" colors
set t_Co=256                " use 256 colors
colorscheme lx-256-dark

" 33ms startup penalty!
source ~/.vim/ftplugin/man.vim

"netrw
if !has("gui_macvim")
    " this is all broken on macvim
    let g:netrw_liststyle=3
endif
let g:netrw_browse_split=4
let g:netrw_winsize=25
let g:netrw_banner=0
"let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+' "hide files by default

" quickfixsigns
let g:quickfixsigns_classes=['qfl', 'loc', 'marks', 'vcsdiff', 'breakpoints']
" Disable display of the ' and . marks, so the gutter will be disabled until
" manually set marks or quickfix/diff info is present.
let g:quickfixsigns#marks#buffer = split('abcdefghijklmnopqrstuvwxyz', '\zs')

" buftabs
let g:buftabs_only_basename=1

"latex
let g:tex_flavor="latex"
let g:tex_no_error = 1
let g:tex_comment_nospell = 1
"let g:LatexBox_latexmk_options = "-pdflatex=lualatex -latex=lualatex"
let g:LatexBox_latexmk_options = "-xelatex"
let g:LatexBox_build_dir = "$HOME/.build"
" Work around the fact that cmdline macvim doesn't support server mode
if has("gui_macvim")
    let g:LatexBox_latexmk_async = 1
else
    if has("macunix")
        let g:LatexBox_latexmk_async = 1
    else 
        let g:LatexBox_latexmk_async = 0
    endif
endif
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
    " The NoStarch style is a bit crufty and needs pdflatex
    au BufWinEnter book.tex let g:LatexBox_latexmk_options = "" 
    au BufWinEnter book.tex let g:LatexBox_fold_envs = 1
"    au BufWritePost *.tex Latexmk
    au BufWinLeave *.tex,*.sty mkview
    au BufWinEnter *.tex,*.sty silent loadview
    au FileType tex syntax spell toplevel 
    au FileType tex set spell textwidth=78 smartindent
    au FileType tex set comments+=b:\\item formatoptions-=q formatoptions+=w foldlevelstart=6
    au FileType tex imap <buffer> [[ \begin{
    au FileType tex imap <buffer> ]] <Plug>LatexCloseCurEnv
    au FileType tex imap <S-Enter> \pagebreak
    au FileType tex nmap tt i{\tt <Esc>wEa}<Esc>
    au FileType tex source ~/.vim/ftplugin/quotes.vim
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
if has("macunix")
    let g:CCTreeSplitProgCmd="/opt/local/bin/gsplit"
else
    let g:CCTreeSplitProgCmd="/usr/local/bin/gsplit"
endif

" rainbow
map <Leader>r :RainbowToggle<CR>

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
" CtrlP tjump
nnoremap <c-]> :CtrlPtjump<cr>

" statline
let g:statline_fugitive=1
let g:statline_trailing_space=0
let g:statline_mixed_indent=0

" gundo
let g:gundo_close_on_revert=1

" clang
let g:clang_complete_enable = 1
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
let g:clang_user_options='-fblocks -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator6.1.sdk -D__IPHONE_OS_VERSION_MIN_REQUIRED=40300'
let g:clang_complete_copen = 1
let g:clang_snippets = 1
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

let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }

augroup cjava
    au!
    au BufNewFile *.c r ~/.vim/templates/template.c
    au BufWinEnter *.[mCchly] set nospell comments+=s1:/*,mb:*,ex:*/
    au BufRead,BufNewFile *.m,*.xm setfiletype objc
    au BufRead,BufNewFile *.m,*.xm let c_no_curly_error = 1
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
    au BufWinEnter *.notes set filetype=markdown
    au BufWinLeave *.md,*.notes, mkview
    au BufWinEnter *.md,*.notes, silent loadview
    au BufWinEnter *.md,*.notes, imap <C-l> <C-t>
    au BufWinEnter *.md,*.notes, imap <C-h> <C-d>
    au BufWinEnter *.md,*.notes,*mutt*, imap >> <C-t>
    au BufWinEnter *.md,*.notes,*mutt*, imap << <C-d>
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
    au BufReadPost quickfix call GrepColors()
augroup end

augroup msdocs
    au BufReadCmd *.docx,*.xlsx,*.pptx call zip#Browse(expand("<amatch>"))
    au BufReadCmd *.odt,*.ott,*.ods,*.ots,*.odp,*.otp,*.odg,*.otg call zip#Browse(expand("<amatch>"))
augroup end

augroup misc
    au BufWinEnter *.nmap, set syntax=nmap
    au BufWinEnter *.scala, set filetype=scala
    au BufWinEnter *.dtrace, set filetype=D
    au BufWinEnter *.fugitiveblame,*.diff, set nospell number
    au BufWinEnter *.plist, call ReadPlist()
    au BufWinLeave *.txt,*.conf,.vimrc,*.notes mkview
    au BufWinEnter *.txt,*.conf,.vimrc,*.notes silent loadview
    au FileType make set diffopt-=iwhite
    au FileType vim set nospell
    au FileType mail set spell complete+=k nonu
    " par is much better at rewrapping mail
    au FileType mail if executable("par") | set formatprg=par | endif
    au FileType mail map <F8> :%g/^> >/d<CR>gg10j
    au FileType mail,text let b:delimitMate_autoclose = 0
    au BufWinEnter *vimChatRoster, set foldlevel=1
    au BufWinEnter *.nse set filetype=lua
    " If a JS file has only one line, unminify it
    au FileType javascript if line('$')==1 | call Unminify() | endif
    au FileType help set nospell
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

" Quickfix toggle
let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        bot copen
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
        set filetype=xml
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

" I use this to highlight the match from grep, but keep quickfix syntax
" highlighting intact. This is for BSD grep.
command -bar GrepColors call GrepColors()
function GrepColors()
    set conceallevel=3
    set cocu=nv
    syn region ansiRed start="\e\[01;31m\e\[K"me=e-2 end="\e\[m"me=e-3 contains=ansiConceal
    syn match ansiConceal contained conceal	"\e\[\(\d*;\)*\d*m\e\[K"
    hi ansiRed    ctermfg=197   guifg=#FF005F  cterm=none         gui=none
    syn match ansiStop		conceal "\e\[m\e\[K"
    hi! link ansiStop NONE
endfunction

" Simple re-format for minified Javascript
command! Unminify call Unminify()
function! Unminify()
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction

command! -nargs=1 Graudit call Graudit(<f-args>)
function! Graudit(db)
    call system("$HOME/Tools/graudit/graudit -x 'cscope.*' -c0 -d " . a:db . " . > /tmp/graudit.out")
    copen
    cf /tmp/graudit.out
endfunction
