" Abbreviations {{{
abbr guys folks
abbr shruggie ¯\_(ツ)_/¯
" }}}

" Keymappings {{{
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
nmap <space> ,
" save my pinky
nore ; :
" auto-format the current paragraph
nnoremap __ gwip
nnoremap -- :call WrapMerge()<CR>
" Get rid of jumping behavior when using these search functions
nnoremap * *<c-o>
nnoremap # #<c-o>
" Clear search pattern with \\
map <silent> <Leader>\ :noh<CR>
" correct spelling
nmap <F1> [s1z=<C-o>
imap <F1> <Esc>[s1z=<C-o>a
nmap <Leader>fs [s1z=<C-o>
" Poor man's cscope
nnoremap gr :grep '\b<cword>\b' *<CR>
" Clean up left side
nmap <F2> :set nonu foldcolumn=0<CR>:QuickfixsignsToggle<CR>
map <F8> :w<CR> :!make<CR>
map <silent> <F9> :call ToggleVExplorer()<CR>
nnoremap <silent> <F10> :TagbarToggle<CR>
set pastetoggle=<F11>
" jump to next quickfix item
map <F12> :cn<CR>
" preview the tag under the cursor
nmap <C-p> :exe "ptag" expand("<cword>")<CR>
nnoremap <silent> <C-c> :QFix<cr>
" Window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-l>k
" Keep selected blocks selected when shifting
vmap > >gv
vmap < <gv
nmap <Leader>x :call system("cd `dirname %` && urxvt")<CR>
nmap <Leader>dt "=strftime("%c")<CR>P"
nmap <Leader>dd "=strftime("%y-%m-%d")<CR>P"
" Change to the directory of the current file
nmap cd :lcd %:h \| :pwd<CR>
" Delete a vuln
" This works when I type it, but not here...
nmap dav ?%<CR>2d/%---\|\\vtitle<CR>
nmap <Leader>fw :StripWhitespace<CR>
" Base64 conversion
vnoremap <leader>64 c<c-r>=system('base64',@")<cr><esc>
vnoremap <leader>64d c<c-r>=system('base64 --decode',@")<cr><esc>
" Quick exits
nmap zz ZZ
" Open a small terminal
if has('nvim')
    nnoremap <leader>o :below 10sp term://$SHELL<cr>i
endif
" }}}

" Settings {{{
syntax on
filetype plugin on
filetype indent on
helptags ~/.vim/doc

if has('gui')
    set gcr=n:blinkon0          " don't blink the cursor in normal mode
    set guioptions=aAegiM       " get rid of useless stuff in the gui
    if has("gui_macvim")
        set guifont=Inconsolata:h18
        noremap <Leader>zo :set guifont=Inconsolata:h4<CR>
        noremap <Leader>zi :set guifont=Inconsolata:h18<CR>
    else
        set guifont=Inconsolata\ 14
    endif
endif
if has('gui_running')
    set ballooneval
    set balloondelay=100
endif

if $DISPLAY != ""
    "set cursorline          " I like this, but damn is it slow
    set clipboard=unnamed
    set mouse=a             " Turn this off for console-only mode
    set selectmode+=mouse	" Allow the mouse to select
    if !has('nvim')
        set ttymouse=xterm2
    endif
endif
set et                      " expand tabs
set diffopt+=iwhite,vertical,filler   " ignore whitespace in diffs
set hidden                  " allow hidden buffers
set noerrorbells vb t_vb=   " no bells
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
set foldcolumn=0            " I never use this.
set nojoinspaces            " disallow two spaces after a period when joining
if version >= 704
    set formatoptions=qjnrtlmnc " auto-formatting style
else
    set formatoptions=qnrtlmnc  " auto-formatting style minus j
endif
set autoindent
set shiftround              " Round to the nearest shiftwidth when shifting
set linebreak               " When soft-wrapping long lines, break at a word
set comments-=s1:/*,mb:*,ex:*/
set comments+=fb:*,b:\\item
set formatlistpat=^\\s*\\([0-9]\\+\\\|[a-z]\\)[\\].:)}]\\s\\+
set grepprg=grep\ -R\ --exclude=\"*.aux\"\ --exclude=\"tags\"\ --exclude=\"*scope.out\"\ --color=always\ -nIH\ $*
set cpoptions=BFt
set completeopt=menuone,longest
set tags=tags,./tags
set nobackup                " ugh, stop making useless crap
set nowritebackup           " same with overwriting
set directory=/tmp          " litter up /tmp, not the CWD
set nomodeline              " modelines are dumb
set tabstop=4 shiftwidth=4 softtabstop=4
set backspace=indent,eol,start
set ruler                   " show position in file
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)
set ttimeout
set ttimeoutlen=100         " Make it so Esc enters Normal mode right away
if has('nvim')
    set ttimeoutlen=-1
endif
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
set foldlevelstart=0        " the default level of fold nesting on startup
set autoread                " Disable warning about file change to writable
set conceallevel=0          " Don't hide things by default
if !has('nvim')
    set cryptmethod=blowfish    " in case I ever decide to use vim -x
endif

" Use pipe cursor on insert
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"
let &t_EI = "\<esc>[1 q"
" Same in neovim
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

"if exists('&autochdir')
"    " Change directory to first open file
"    set autochdir
"    set noautochdir
"endif

" colors
set t_Co=256                " use 256 colors
colorscheme lx-256-dark
" }}}

" Plugins
source ~/.vim/ftplugin/man.vim

" Don't load plugins that have unmet dependencies
if !executable('task')
    let g:loaded_taskwarrior = 1
endif


if !has('python3')
    let g:loaded_pct = 1
endif

" taskwarrior {{{
let g:task_rc_override = 'rc.defaultwidth=0'
let g:task_report_name = '-home'
" }}}

" netrw {{{
let g:netrw_liststyle=0
let g:netrw_browse_split=4
let g:netrw_winsize=25
let g:netrw_banner=0
let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+' "hide files by default
let g:netrw_sort_sequence = '[\/]$,*,\%(' . join(map(split(&suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$'
" }}}

" quickfixsigns {{{
let g:quickfixsigns_classes=['qfl', 'loc', 'marks', 'vcsdiff', 'breakpoints']
let g:quickfixsigns_echo_balloon = 1
" Disable display of the ' and . marks, so the gutter will be disabled until
" manually set marks or quickfix/diff info is present.
let g:quickfixsigns#marks#buffer = split('abcdefghijklmnopqrstuvwxyz', '\zs')
let g:quickfixsign_use_dummy = 0
" Aaaand we just found the limitations of manual fold markers
let g:quickfixsigns#vcsdiff#highlight = {'DEL': 'QuickFixSignsDiffDeleteLx', 'ADD': 'QuickFixSignsDiffAddLx', 'CHANGE': 'QuickFixSignsDiffChangeLx'}   "{{{2}}}"
" }}}

" buftabs {{{
let g:buftabs_only_basename=1
" }}}

" buftabline {{{
let g:buftabline_show=1
let g:buftabline_separators=1
" }}}

" clever-f {{{
let g:clever_f_mark_char_color="PreProc"
let g:clever_f_smart_case=1
" }}}

" cscope {{{
let g:cscope_interested_files = '\.java$\|\.php$\|\.h$\|\.hpp|\.cpp|\.c$|\.m$|\.swift$|\.py$'
let g:cscope_split_threshold = 99999
let g:cscope_auto_update = 0
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
" }}}

" Indentlines {{{
nmap \|\| :IndentLinesToggle<CR>
let g:indentLine_faster = 1
let g:indentLine_enabled = 0
" }}}

" Limelight {{{
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_guifg = '#777777'
let g:limelight_default_coefficient = 0.7
" }}}

" latex-box {{{
let g:tex_flavor="latex"
let g:tex_no_error = 1
let g:tex_conceal= ""
let g:tex_comment_nospell = 1
"let g:LatexBox_latexmk_options = "--disable-write18 --file-line-error --interaction=batchmode -pdflatex=lualatex -latex=lualatex"
let g:LatexBox_latexmk_options = "-xelatex --disable-write18 --file-line-error --interaction=batchmode"
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
let g:LatexBox_quickfix = 0
let g:LatexBox_fold_automatic = 0
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
    au BufWinEnter book.tex let g:LatexBox_latexmk_options = "-interaction=batchmode -draftmode"
    au BufWinEnter book.tex let g:LatexBox_fold_envs = 1
    if &diff
        let g:LatexBox_Folding = 0
        let g:LatexBox_fold_preamble = 0
        let g:LatexBox_fold_envs = 0
    else
        let g:LatexBox_Folding = 1
        let g:LatexBox_fold_preamble = 1
        let g:LatexBox_fold_envs = 1
    endif
"    au BufWritePost *.tex Latexmk
    au BufWinLeave *.tex,*.sty mkview
    au BufWinEnter *.tex,*.sty silent loadview
    au FileType tex syntax spell toplevel
    au FileType tex set spell textwidth=78 smartindent
    au FileType tex set formatoptions+=w
    au FileType tex imap <buffer> [[ \begin{
    au FileType tex imap <buffer> ]] <Plug>LatexCloseCurEnv
    au FileType tex imap <S-Enter> \pagebreak
    au FileType tex nmap tt i\texttt{<Esc>wEa}<Esc>
    au FileType tex source ~/.vim/ftplugin/quotes.vim
augroup end
" }}}

" supertab {{{
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
" }}}

" cctree {{{
if has("macunix")
    let g:CCTreeSplitProgCmd="/opt/local/bin/gsplit"
else
    let g:CCTreeSplitProgCmd="/usr/local/bin/gsplit"
endif
" }}}

" rainbow {{{
map <Leader>r :RainbowToggle<CR>
" }}}

" vimchat {{{
let g:vimchat_otr = 1
let g:vimchat_statusicon = 0
let g:vimchat_showPresenceNotification = -1
let g:vimchat_pync_enabled = 1
"map g<Tab> gt
" }}}

" FZF {{{
set rtp+=~/.fzf
set rtp+=/usr/local/opt/fzf
nmap <C-e> :Files<CR>
nmap <C-g> :GFiles<CR>
nmap <leader>m :History<CR>
nmap <leader>e :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>b :BTags<CR>
nmap <C-]> :call fzf#vim#tags(expand('<cword>'), {'options': '--exact --select-1 --exit-0'})<CR>

let g:fzf_tags_command = '/usr/local/bin/ctags -R'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

command! -bang -nargs=* F
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!tags" --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" }}}


" statline {{{
let g:statline_fugitive=1
let g:statline_trailing_space=0
let g:statline_mixed_indent=0
let g:statline_filename_relative=1
" }}}

" clang {{{
let g:clang_complete_enable = 1
let g:clang_library_path='/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib'
let g:clang_user_options='-fblocks -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -D__IPHONE_OS_VERSION_MIN_REQUIRED=40300'
let g:clang_complete_copen = 1
let g:clang_snippets = 1
let g:clang_use_library = 1
let g:clang_format#detect_style_file = 1
" }}}

" tagbar {{{
let g:tagbar_iconchars = ['▸', '▾']
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
" }}}

" augroups {{{
augroup cjava
    au!
    au BufNewFile *.c r ~/.vim/templates/template.c
    au BufWinEnter *.[mCchly] set nospell number comments+=s1:/*,mb:*,ex:*/
    au BufWinEnter,BufNewFile *.m,*.xm,*.xmi setfiletype objc
    au BufWinEnter,BufNewFile *.m,*.xm,*.xmi let c_no_curly_error = 1
    au BufWinEnter *.cpp,*.java,*.hs set nospell number
    au BufWinLeave *.[mchly] mkview
    au BufWinEnter *.[mchly] silent loadview
    au BufWinLeave *.cpp,*.java,*.hs mkview
    au BufWinEnter *.cpp,*.java,*.hs silent loadview
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

augroup php
    au FileType php set smartindent smarttab nospell number
    au BufWinLeave *.php mkview
    au BufWinEnter *.php silent loadview
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
    au BufWinEnter quickfix call GrepColors()
    au BufWinEnter qf:list call GrepColors()
augroup end

augroup msdocs
    au BufReadCmd *.docx,*.xlsx,*.pptx call zip#Browse(expand("<amatch>"))
    au BufReadCmd *.odt,*.ott,*.ods,*.ots,*.odp,*.otp,*.odg,*.otg call zip#Browse(expand("<amatch>"))
augroup end

augroup misc
    au FileType netrw silent! unmap <buffer> --
    au BufWinEnter *.applescript set filetype=applescript
    au BufWinEnter *.nmap, set syntax=nmap
    au BufWinEnter *.scala, set filetype=scala
    au BufWinEnter *.proto, set filetype=proto
    au BufWinEnter *.dtrace, set filetype=D
    au BufWinEnter *.less, set filetype=css
    au BufWinEnter *.fugitiveblame,*.diff, set nospell number
    au BufWinLeave *.txt,*.conf,.vimrc,*.notes mkview
    au BufWinEnter *.txt,*.conf,.vimrc,*.notes silent loadview
    au BufWinEnter .vimrc set foldmethod=marker
    au FileType json set conceallevel=0
    au FileType make set diffopt-=iwhite
    au FileType vim set nospell
    au FileType mail set spell complete+=k nonu
    " par is much better at rewrapping mail
    au FileType mail if executable("par") | set formatprg=par | endif
    au FileType mail map <F8> :%g/^> >/d<CR>gg10j
    au FileType mail StripWhitespace
    au FileType mail,text let b:delimitMate_autoclose = 0
    au BufWinEnter *vimChatRoster, set foldlevel=1
    au BufWinEnter *.nse set filetype=lua
    " If a JS file has only one line, unminify it
    au FileType javascript if line('$')==1 | call Unminify() | endif
    au FileType help set nospell
    " What - like how does this even work
    au InsertLeave * hi! link CursorLine CursorLine
    au InsertEnter * hi! link CursorLine Normal
    " Disable the 'warning, editing a read-only file' thing that
    " hangs the UI
    au FileChangedRO * se noreadonly
    au GUIEnter * set visualbell t_vb=
augroup end

augroup syntax
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup end
" }}}

" Custom functions {{{
" Quickfix toggle

function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

"nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
"nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>

command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
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

" wrap nicely
function! WrapMerge()
    set formatoptions-=w
    exec "normal gwip"
    set formatoptions+=w
endfunction

" clear quickfix
command -bar Qfc call setqflist([])

" Read in cookiefiles
command -bar Cookies call ReadCookies()
function ReadCookies()
    call system("cp Cookies.binarycookies /tmp/")
    %!python $HOME/bin/BinaryCookieReader.py /tmp/Cookies.binarycookies
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
" highlighting intact. Detects Linux due to the different escape sequences of
" GNU grep.
command -bar GrepColors call GrepColors()
function GrepColors()
    set conceallevel=3
    set cocu=nv

    if system('uname')=~'Linux'
        syn region ansiRed start="\e\[01;31m"me=e-2 end="\e\[m"me=e-3 contains=ansiConceal
        syn match ansiConceal contained conceal	"\e\[\(\d*;\)*\d*m"
        syn match ansiStop		conceal "\e\[m"
   elseif system('uname')=~'FreeBSD'
       syn region ansiRed start="\e\[01;31m"me=e-2 end="\e\[00m"me=e-5 contains=ansiConceal
       syn match ansiConceal contained conceal    "\e\[\(\d*;\)*\d*m"
       syn match ansiStop        conceal "\e\[00m\e\[K"
    else
        syn region ansiRed start="\e\[01;31m\e\[K"me=e-2 end="\e\[m"me=e-3 contains=ansiConceal
        syn match ansiConceal contained conceal	"\e\[\(\d*;\)*\d*m\e\[K"
        syn match ansiStop		conceal "\e\[m\e\[K"
    endif

    hi ansiRed    ctermfg=197   guifg=#FF005F  cterm=none         gui=none
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
    call system("$HOME/Tools/graudit/graudit -x 'cscope.*' -c0 -d " . a:db . " . | awk 'length($0) < 200' > /tmp/graudit.out")
    copen
    cf /tmp/graudit.out
endfunction
" }}}

let $ADMIN_SCRIPTS = "/scripts"

if filereadable($ADMIN_SCRIPTS . "/master.vimrc")
    source $ADMIN_SCRIPTS/master.vimrc
endif

if filereadable($ADMIN_SCRIPTS . "/vim/biggrep.vim")
    source $ADMIN_SCRIPTS/vim/biggrep.vim
endif

" Why do you turn this off
set hlsearch
