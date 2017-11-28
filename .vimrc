" Abbreviations {{{
abbr guys folks
abbr shruggie ¯\_(ツ)_/¯
abbr ty Thanks,
            \<CR>David
" }}}

" Keymappings {{{
"left/right arrows to switch buffers in normal mode
map <right> :bn<cr>
map <left> :bp<cr>
map <home> :rewind<cr>
map <end> :last<cr>
map g<Tab> :bn<CR>
" Make Y behave like C and D
nnoremap Y y$
" Use , and space in addition to \ for the leader
let mapleader = ","
nmap \ ,
nmap <space> ,
" save my pinky
nore ; :
" auto-format the current paragraph
nnoremap == :call WrapMerge()<CR>
" Get rid of jumping behavior when using these search functions
nnoremap * *<c-o>
nnoremap # #<c-o>
" Clear search pattern with \\
map <silent> <Leader>\ :noh<CR>
" fix spelling of last misspelled word
nmap <F1> [s1z=<C-o>
imap <F1> <Esc>[s1z=<C-o>a
nmap <Leader>fs [s1z=<C-o>
" Poor man's cscope - grep for symbol under cursor
nnoremap gr :grep '\b<cword>\b' *<CR>
" Clean up left side
nmap <F2> :set nonu foldcolumn=0<CR>:QuickfixsignsToggle<CR>
" Show netrw sidebar
map <silent> <F9> :Lexplore<CR>
nnoremap <silent> <F10> :TagbarToggle<CR>
set pastetoggle=<F11>
" jump to next quickfix item
map <F12> :cn<CR>
" preview the tag under the cursor
nmap <C-p> :exe "ptag" expand("<cword>")<CR>
" Toggle the quickfix window
nnoremap <silent> <C-c> :call ToggleQuickfix()<cr>
" Window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-l>k
" Keep selected blocks selected when shifting
vmap > >gv
vmap < <gv
" Move visual blocks up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" day+time / day+date
nmap <Leader>dt "=strftime("%c")<CR>P"
nmap <Leader>dd "=strftime("%y-%m-%d")<CR>P"
" Change to the directory of the current file
nmap cd :lcd %:h \| :pwd<CR>
" Fix whitespace
nmap <Leader>fw :StripWhitespace<CR>
" Quick exits
nmap zz ZZ
cmap w!! w !sudo tee > /dev/null %
" }}}

" Settings {{{
syntax on
filetype plugin on
filetype indent on
helptags ~/.vim/doc

if $DISPLAY != ""
    "set cursorline          " I like this, but damn is it slow
    set clipboard=unnamed
    set mouse=a             " Turn this off for console-only mode
    if !has('nvim')
        set ttymouse=xterm2
    endif
endif
set et                      " expand tabs
set diffopt+=iwhite,vertical,filler   " ignore whitespace in diffs
set hidden                  " allow hidden buffers
set noerrorbells vb t_vb=   " no bells
set number                  " line numbers
set viewdir=$HOME/.views    " keep view states out of my .vim
set pumheight=15            " trim down the completion popup menu
set shortmess+=atIoT        " save space in status messages
set scrolloff=3             " 3 lines of buffer before scrolling
set ignorecase              " case insensitive searches
set wildignorecase          " same for directories and ex commands
set smartcase               " unless you type uppercase explicitly
set smarttab                " use shiftwidth instead of tab stops
set wildmode=longest,list   " shows a list of candidates when tab-completing
set wildmenu                " use a more functional completion menu when tab-completing
set encoding=utf-8          " always use utf-8
set foldcolumn=0            " I never use this.
set nojoinspaces            " disallow two spaces after a period when joining
set formatoptions=qjnrtlmnc " auto-formatting style
set autoindent
set shiftround              " Round to the nearest shiftwidth when shifting
set linebreak               " When soft-wrapping long lines, break at a word
set comments-=s1:/*,mb:*,ex:*/
set comments+=fb:*,b:\\item
set formatlistpat=^\\s*\\([0-9]\\+\\\|[a-z]\\)[\\].:)}]\\s\\+
set grepprg=grep\ -R\ --exclude=\"*.aux\"\ --exclude=\"tags\"\ --exclude=\"*scope.out\"\ --color=always\ -nIH\ $*
set cpoptions=BFt
set completeopt=menuone,longest
autocmd Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
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
set titleold=""
set ttimeout
set ttimeoutlen=100         " Make it so Esc enters Normal mode right away
if has('nvim')
    set ttimeoutlen=-1
endif
set helpheight=0            " no minimum helpheight
set incsearch               " search incrementally
set showmatch               " show the matching terminating bracket
set suffixes=.out           " set priority for tab completion
set sidescroll=1            " soft wrap long lines
set lazyredraw ttyfast      " go fast
set errorfile=/tmp/errors.vim
set cscopequickfix=s-,c-,d-,i-,t-,e-        " omfg so much nicer
set foldlevelstart=0        " the default level of fold nesting on startup
set autoread                " Disable warning about file change to writable
set conceallevel=0          " Don't hide things by default
set wildignore+=*.bak,~*,*.o,*.aux,*.dvi,*.bbl,*.blg,*.orig,*.toc,*.fls
set wildignore+=*.loc,*.gz,*.tv,*.ilg,*.lltr,*.lov,*.lstr,*.idx,*.pdf
set wildignore+=*.fdb_latexmk,*.ind,*.cg,*.tdo,*.log,*.latexmain,*.out

" Use pipe cursor on insert
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"
let &t_EI = "\<esc>[1 q"
" Same in neovim
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

" colors
if $TERM == 'xterm-kitty'
    if exists('$TMUX')
        set t_Co=256
    else
        set termguicolors
    endif
else
    set t_Co=256
endif
colorscheme lx-truecolor
" }}}

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'AndrewRadev/id3.vim', { 'for': 'audio.flac' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'SolaWing/vim-objc-syntax', { 'for': 'objc' }
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
Plug 'ajh17/VimCompletesMe'
Plug 'ap/vim-buftabline'
Plug 'blindFS/vim-taskwarrior', { 'on': 'TW'}
Plug 'brookhong/cscope.vim'
Plug 'christianrondeau/vim-base64'
Plug 'd0c-s4vage/pct-vim', { 'on': ['PctInit', 'PctAudit', 'PctNotes', 'PctReport'] }
Plug 'fidian/hexmode', { 'on': 'Hexmode' }
Plug 'goldfeld/vim-seek'
Plug 'gorkunov/smartpairs.vim'
Plug 'guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
Plug 'jamessan/vim-gnupg'
Plug 'jiangmiao/auto-pairs'
Plug 'jremmen/vim-ripgrep', { 'on': 'Rg'}
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim', { 'on': ['GV', 'GV!'] } 
Plug 'junegunn/vim-fnr'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-slash'
Plug 'kergoth/vim-hilinks'
Plug 'lervag/vimtex', { 'for': 'latex' }
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle'}
Plug 'millermedeiros/vim-statline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rhysd/clever-f.vim'
Plug 'solarnz/thrift.vim', { 'for': 'thrift'}
Plug 'tomtom/quickfixsigns_vim'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'vim-utils/vim-man', { 'on': ['Man', 'Mangrep'] } 
Plug 'will133/vim-dirdiff', { 'on': 'DirDiff'}
call plug#end()

" Don't load plugins that have unmet dependencies
if !executable('task')
    let g:loaded_taskwarrior = 1
endif

if !has('python3')
    let g:loaded_pct = 1
endif

" netrw {{{
let g:netrw_liststyle=0
let g:netrw_browse_split=4
let g:netrw_winsize=25
let g:netrw_banner=0
"let g:netrw_list_hide='\(^\|\s\s\)\zs\.\S\+' "hide files by default
"let g:netrw_sort_sequence = '[\/]$,*,\%(' . join(map(split(&suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$'
" }}}

" quickfixsigns {{{
let g:quickfixsigns_classes=['qfl', 'loc', 'marks', 'vcsdiff', 'breakpoints']
let g:quickfixsigns_echo_balloon = 1
" Disable display of the ' and . marks, so the gutter will be disabled until
" manually set marks or quickfix/diff info is present.
let g:quickfixsigns#marks#buffer = split('abcdefghijklmnopqrstuvwxyz', '\zs')
let g:quickfixsign_use_dummy = 0
let g:quickfixsigns#vcsdiff#highlight = {'DEL': 'QuickFixSignsDiffDeleteLx', 'ADD': 'QuickFixSignsDiffAddLx', 'CHANGE': 'QuickFixSignsDiffChangeLx'}   "{{{2}}}"
" }}}

" buftabline {{{
let g:buftabline_show=1
" }}}

" clever-f {{{
let g:clever_f_mark_char_color="PreProc"
let g:clever_f_smart_case=1
" }}}

" ultisnips {{{
let g:UltiSnipsExpandTrigger = "<C-l>"
let g:UltiSnipsNoPythonWarning=1
" }}}

" cscope {{{
let g:cscope_interested_files = '\.java$\|\.php$\|\.h$\|\.hpp|\.cpp|\.c$|\.m$|\.swift$|\.py$|\.hs$'
let g:cscope_split_threshold = 99999
let g:cscope_auto_update = 0
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
" }}}

" Indentlines {{{
nmap \|\| :IndentLinesToggle<CR>
let g:indentLine_faster = 1
let g:indentLine_enabled = 0
" }}}

" ripgrep {{{
let g:rg_highlight = 1
" "}}}

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
let g:statline_show_encoding=0
" }}}

" tagbar {{{
let g:tagbar_iconchars = ['▸', '▾']
" }}}

" augroups {{{
augroup cjava
    au!
    au BufWinEnter *.[mCchly] set number comments+=s1:/*,mb:*,ex:*/
    au BufWinEnter,BufNewFile *.m,*.xm,*.xmi setfiletype objc
    au BufWinEnter,BufNewFile *.m,*.xm,*.xmi let c_no_curly_error = 1
    au BufWinEnter *.cpp,*.java,*.hs set number
    au BufWinLeave *.[mchly] mkview
    au BufWinEnter *.[mchly] silent loadview
    au BufWinLeave *.cpp,*.java,*.hs mkview
    au BufWinEnter *.cpp,*.java,*.hs silent loadview
augroup end

augroup html
    au!
    au FileType html set spell wrapmargin=5 wrapscan number
    au FileType html set wrapscan&
    au BufWinLeave *.htm* mkview
    au BufWinEnter *.htm* silent loadview
augroup end

augroup pythonphp
    au FileType python,php set smartindent smarttab number
    au BufWinLeave *.py,*.php mkview
    au BufWinEnter *.py,*.php silent loadview
augroup end

augroup markdown
    " Don't highlight underscores
    syn match markdownError "\w\@<=\w\@="
    au BufWinEnter *.notes set filetype=markdown
    au BufWinLeave *.md,*.notes, mkview
    au BufWinEnter *.md,*.notes, silent loadview
    au BufWinEnter *.md,*.notes, imap <C-l> <C-t>
    au BufWinEnter *.md,*.notes, imap <C-h> <C-d>
    au BufWinEnter *.md,*.notes, normal zR
    au BufWinEnter *.md,*.notes,*mutt*, imap >> <C-t>
    au BufWinEnter *.md,*.notes,*mutt*, imap << <C-d>
    au FileType markdown set spell textwidth=78 complete+=k comments+=b:-,b:+,b:*,b:+,n:>
augroup end

" Disable spellcheck on quickfix, switch between quickfix lists with the arrow
" keys
augroup quickfix
    au FileType qf, set number
    au FileType qf, noremap ' <CR><C-W><C-P>j
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
    au FileType git set foldlevel=99
    au FileType taskreport set nonu
    au BufWinEnter *.applescript set filetype=applescript
    au BufWinEnter *.nmap, set syntax=nmap
    au BufWinEnter *.scala, set filetype=scala
    au BufWinEnter *.proto, set filetype=proto
    au BufWinEnter *.dtrace, set filetype=D
    au BufWinEnter *.less, set filetype=css
    au BufWinEnter *.fugitiveblame,*.diff, set number
    au BufWinLeave *.txt,*.conf,.vimrc,*.notes mkview
    au BufWinEnter *.txt,*.conf,.vimrc,*.notes silent loadview
    au BufWinEnter .vimrc set foldmethod=marker
    au FileType json set conceallevel=0
    au FileType make set diffopt-=iwhite
    au FileType mail set spell complete+=k nonu comments+=b:-,b:+,b:*,b:+,n:>
    au FileType mail if executable("par") | set formatprg=par | endif
    au FileType mail map <F8> :%g/^> >/d<CR>gg10j
    au FileType mail StripWhitespace
    au BufWinEnter *.nse set filetype=lua
    " If a JS file has only one line, unminify it
    au FileType javascript if line('$')==1 | call Unminify() | endif
    " What - like how does this even work
    au InsertLeave * hi! link CursorLine CursorLine
    au InsertEnter * hi! link CursorLine Normal
    " Disable the 'warning, editing a read-only file' thing that
    " hangs the UI
    au FileChangedRO * se noreadonly
    au GUIEnter * set visualbell t_vb=
augroup end

" }}}

" Custom functions {{{
" Quickfix toggle

let g:quickfix_is_open = 0

function! ToggleQuickfix()
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

" wrap nicely
function! WrapMerge()
    set formatoptions-=w
    exec "normal gwip"
    set formatoptions+=w
endfunction

" Read in cookiefiles
command -bar Cookies call ReadCookies()
function ReadCookies()
    call system("cp Cookies.binarycookies /tmp/")
    %!python $HOME/bin/BinaryCookieReader.py /tmp/Cookies.binarycookies
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
    call system("$HOME/git/graudit/graudit -B -x 'cscope.*' -c0 -d " . a:db . " . | awk 'length($0) < 200' > /tmp/graudit.out")
    copen
    cf /tmp/graudit.out
endfunction
" }}}

if filereadable("~/.vimrc-local")
    source ~/.vimrc-local
endif
