" Abbreviations {{{
iabbr guys folks
iabbr shruggie ¯\_(ツ)_/¯
iabbr ty Thanks,
            \<CR>David
" }}}

" Keymappings {{{
" Use , and space in addition to \ for the leader
let mapleader = ","
map \ ,
map <space> ,
"left/right arrows to switch buffers in normal mode
map <right> :bn<cr>
map <left> :bp<cr>
map <home> :rewind<cr>
map <end> :last<cr>
map g<Tab> :bn<CR>
" Make Y behave like C and D
nnoremap Y y$
" Yank to OS clipboard
vmap <Leader>y "*y
nnoremap <Leader>Y "*y$
" Delete to blackhole register
nnoremap <leader>d "_d
" save my pinky
nore ; :
" Performance seems to have improved
set cursorline
" auto-format the current paragraph
nnoremap == gqip
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
nnoremap rg :execute 'Rg' expand('<cword>')<CR>
" Show netrw sidebar
map <silent> <F9> :Lexplore<CR>
nnoremap <silent> <F10> :TagbarToggle<CR>
" jump to next quickfix item
map <F12> :cn<CR>
" use the g] behavior by default, i.e. list all tags if there are multiple
nnoremap <C-]> g<C-]>
" Keep selected blocks selected when shifting
vmap > >gv
vmap < <gv
" Move visual blocks up and down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" Repeat actions on all lines of a block
vnoremap . :normal .<CR>
" Keep the contents of the paste buffer when pasting in visual mode
xnoremap p pgvy
" Change to the directory of the current file
nmap cd :lcd %:h \| :pwd<CR>
" Fix whitespace
nmap <Leader>fw :StripWhitespace<CR>
" Fast quit
nmap Q :qa!<CR>
" Write using sudo
cmap w!! w !sudo tee > /dev/null %
" Reflow JSON / YAML
nmap =j :%!jq .<CR>
nmap =y :%!jq -r yamlify<CR>:set filetype=yaml<CR>
" Faster fugitive
cnoreabbrev git Git
" }}}

" Settings {{{
filetype plugin on
filetype indent on
syntax on
helptags ~/.vim/doc

set mouse=a
set ttymouse=sgr
set spelllang=en_us,cjk,pt
set diffopt+=iwhite,vertical,filler   " ignore whitespace in diffs
set hidden                  " allow hidden buffers
set noerrorbells vb t_vb=   " no bells
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
set fillchars+=vert:│       " Prettier vertical splits
set foldcolumn=0            " I never use this.
set nojoinspaces            " disallow two spaces after a period when joining
set formatoptions=qjnrtlmnc " auto-formatting style
set autoindent
set breakindent briopt+=list:2 " Visually indent wrapped lines in bullet lists etc
set shiftround              " Round to the nearest shiftwidth when shifting
set linebreak               " When soft-wrapping long lines, break at a word
set grepprg=grep\ -R\ --exclude=\"*.aux\"\ --exclude=\"tags\"\ --exclude=\"*scope.out\"\ --color=always\ -nIH\ $*
set cpoptions=BFt
set completeopt=menuone,longest
autocmd Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
set tags=tags,./tags
set nobackup                " stop making useless crap
set nowritebackup           " same with overwriting
set directory=/tmp          " litter up /tmp, not the CWD
set nomodeline              " modelines are dumb
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
set backspace=indent,eol,start
set title
set helpheight=0            " no minimum helpheight
set incsearch               " search incrementally
set hlsearch                " show search matches
set showmatch               " show the matching terminating bracket
set sidescroll=1            " soft wrap long lines
set lazyredraw ttyfast      " go fast
set errorfile=/tmp/errors.vim
set foldlevelstart=0        " the default level of fold nesting on startup
set autoread                " Disable warning about file change to writable
set conceallevel=0          " Don't hide things by default
set laststatus=2            " Always show a statusline
set wildignore+=*.bak,~*,*.o,*.aux,*.dvi,*.bbl,*.blg,*.orig,*.toc,*.fls
set wildignore+=*.loc,*.gz,*.tv,*.ilg,*.lltr,*.lov,*.lstr,*.idx,*.pdf
set wildignore+=*.fdb_latexmk,*.ind,*.cg,*.tdo,*.log,*.latexmain,*.out,*.toc

" Use pipe cursor on insert
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[3 q"
let &t_EI = "\<esc>[1 q"

" truecolor {{{
set termguicolors
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"
" }}}

" lists {{{

"set formatlistpat=^\\s*\\([0-9]\\+\\\|[a-z]\\)[\\].:)}]\\s\\+
set formatlistpat=^\\s*[\\[({]\\?=\\([0-9]\\+\\\|[a-zA-Z]\\+\\)[\\]:.)}]\\s\\+\\\|^\\s*[-–+o*•]\\s\\+
" }}}


" Plugins {{{
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/id3.vim'
Plug 'andymass/vim-matchup'
Plug 'ap/vim-buftabline'
Plug 'christianrondeau/vim-base64'
Plug 'darfink/vim-plist'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'fidian/hexmode', { 'on': 'Hexmode' }
Plug 'godlygeek/tabular'
Plug 'goerz/jupytext.vim'
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'itchyny/lightline.vim'
Plug 'jamessan/vim-gnupg'
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'justinmk/vim-sneak'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'md-img-paste-devs/md-img-paste.vim'
Plug 'preservim/tagbar', { 'on': 'TagbarToggle'}
Plug 'psf/black', { 'for': 'python' }
Plug 'rafamadriz/friendly-snippets'
Plug 'romainl/vim-qf'
"Plug 'tomtom/quickfixsigns_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'will133/vim-dirdiff', { 'on': 'DirDiff' }
Plug 'yegappan/lsp'

Plug 'catppuccin/vim', { 'as': 'catppuccin' }

" Use these if debugging color themes/hightlighting
" Plug 'kergoth/vim-hilinks'
" Plug 'guns/xterm-color-table.vim', { 'on': 'XtermColorTable' }
call plug#end()

colorscheme catppuccin_mocha
" Use undercurls
hi SpellLocal ctermbg=NONE cterm=undercurl ctermul=blue
hi SpellBad ctermbg=NONE cterm=undercurl ctermul=red

" black {{{
let g:black_use_virtualenv = 0
" }}}

" tagbar {{{
let g:tagbar_ctags_bin="/opt/homebrew/bin/ctags"
" }}}

" vim-qf {{{
nnoremap <C-c> <Plug>(qf_qf_toggle)
" }}}
"
" quickfixsigns {{{
let g:quickfixsigns_classes=['qfl', 'loc', 'marks', 'vcsdiff', 'breakpoints']
let g:quickfixsigns#marks#buffer = split('abcdefghijklmnopqrstuvwxyz', '\zs')
let g:quickfixsign_use_dummy = 0
" }}}


" md-img-paste {{{
autocmd FileType markdown,tex nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'
autocmd FileType tex let g:PasteImageFunction = 'g:LatexPasteImage'
" }}}

" better-whitespace {{{
let g:better_whitespace_ctermcolor=236
let g:better_whitespace_guicolor="#303030"
let g:better_whitespace_filetypes_blacklist=['mail', 'xxd']
" }}}

" lsp {{{
let lspOpts = #{autoHighlightDiags: v:true,
    \ diagSignErrorText: '🔺',
    \ diagSignHintText: '●',
    \ showDiagOnStatusLine: v:true,
    \ ignoreMissingServer: v:true,
    \ snippetSupport: v:true,
    \ vsnipSupport: v:true,
    \ autoPopulateDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [
        \ #{ filetype: ['c', 'cpp'], path: 'clangd', args: ['--background-index', '--clang-tidy'] },
        \ #{ filetype: 'python', path: 'pylsp' },
        \ #{ filetype: ['javascript', 'typescript'], path: 'javascript-typescript-stdio' },
        \ #{ filetype: ['go', 'gomod'], path: 'gopls', args: ['serve'], syncInit: v:true },
        \ #{ filetype: 'swift', path: 'sourcekit-lsp'},
        \ #{ filetype: ['tex', 'bib'], path: 'texlab'},
        \ #{ filetype: 'vim', path: 'vim-language-server', args: ['--stdio'] },
        \ #{ filetype: 'rust', path: 'rust-analyzer', syncInit: v:true },
\]

autocmd User LspSetup call LspAddServer(lspServers)
map gr :LspPeekReferences<cr>
map gs :LspHover<cr>
map gR :LspRename<cr>
map gl :LspDiagShow<cr>
map <C-]> :LspGotoDefinition<cr>
" }}}

" copilot {{{
let g:copilot_filetypes = {
        \ '*': v:false,
        \ 'python': v:true,
        \ 'go': v:true,
        \ 'javascript': v:true,
        \ 'typescriptreact': v:true,
        \ 'lua': v:true,
        \ }
" }}}

" slime {{{
let g:slime_target = "dtach"
let g:slime_vimterminal_config = {"term_finish": "close"}
let g:slime_no_mappings = 1
nnoremap <Leader>s :SlimeSend1 ipython --matplotlib<CR>
nnoremap <Leader>r :IPythonCellRun<CR>
nnoremap <Leader>c :IPythonCellExecuteCellJump<CR>
" }}}

" jupytext {{{
let g:jupytext_fmt = 'py:percent'
" }}}

" buftabline {{{
let g:buftabline_show=1
let g:buftabline_indicators=1
let g:buftabline_separators=1
" }}}

" sneak {{{
let g:sneak#s_next = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
map gS <Plug>Sneak_,
" }}}

" FZF {{{
set rtp+=~/.fzf
nmap <C-e> :Files<CR>
nmap <C-g> :GFiles<CR>
nmap <leader>m :History<CR>
nmap <leader>e :Files<CR>
nmap <Leader>t :Tags<CR>
nmap <Leader>b :BTags<CR>
nnoremap <localleader>lt :call vimtex#fzf#run()<cr>

let g:fzf_tags_command = '/opt/homebrew/bin/ctags -R'

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = { 'ctrl-q': function('s:build_quickfix_list') }

command! -bang -nargs=* F
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --fixed-strings --smart-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!tags" --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
" }}}

" lightline
let g:lightline = {
    \ 'colorscheme': 'catppuccin_macchiato',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
    \   'right': [ [ 'lineinfo' ],
    \              [ 'percent' ],
    \              [ 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead',
    \ },
    \ }
" }}}

" vimtex {{{
" Ignore usually useless messages
let g:vimtex_quickfix_ignore_filters = [
            \ 'soulutf8',
            \ 'polyglossia Warning',
            \]
let g:vimtex_quickfix_autoclose_after_keystrokes = 2
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_format_enabled = 1
let g:vimtex_fold_enabled = 1
let g:vimtex_fold_manual = 1
let g:tex_comment_nospell = 1
let g:matchup_override_vimtex = 1
let g:vimtex_view_skim_reading_bar = 1
let g:vimtex_complete_enabled = 1
let g:vimtex_view_method='skim'
let g:tex_no_error = 1
let g:tex_flavor='latex'
" }}}

" augroups {{{

augroup filetypes
    au BufReadPre *.docx silent set ro
    au BufEnter *.docx silent set modifiable
    au BufEnter *.docx silent  %!pandoc --columns=78 -f docx -t markdown "%"
    au BufWinEnter *.applescript set filetype=applescript
    au BufWinEnter *.nmap, set syntax=nmap
    au BufWinEnter *.jsonl, set filetype=json | hi Error none
    au BufWinEnter *.cki,*.vdj set filetype=json number
    au BufWinEnter *.ics set filetype=icalendar
    au BufWinEnter .visidatarc set filetype=python
    au BufWinEnter *.jq set filetype=javascript
    au BufWinEnter *.cls,*.cbx,*.bbx set filetype=tex
    au BufWinEnter,BufNewFile *.m,*.xm,*.xmi set filetype=objc | let c_no_curly_error = 1
    au FileType python,php set smartindent | set number
    au FileType c,cpp,go set number
    au FileType git set foldlevel=99
    au FileType taskreport set nonu
    au FileType vim set foldmethod=marker
    au FileType make set diffopt-=iwhite
    au FileType markdown set spell | hi Error none
    au FileType mail set spell nonu
    au FileType tex,bib set number spell | setlocal fo+=1p
    au FileType tex,markdown noremap j gj
    au FileType tex,markdown noremap k gk
    au FileType tex,markdown noremap gj j
    au FileType tex,markdown noremap gk k
    au FileType tex imap [[ \begin{
    au BufWinEnter *.md normal zR
augroup end

augroup misc
    " Disable the 'warning, editing a read-only file' thing
    au FileChangedRO * se noreadonly
augroup end

augroup views
    au BufWinLeave *.[mchly],*.cpp,*.java,*.hs,*.htm*,*.py,*.php,*.md,*.txt,*.conf,.vimrc,*.tex,*.sty,*.ipynb,*.bib,*.go mkview
    au BufWinEnter *.[mchly],*.cpp,*.java,*.hs,*.htm*,*.py,*.php,*.md,*.txt,*.conf,.vimrc,*.tex,*.sty,*.ipynb,*.bib,*.go silent loadview
augroup end

" Disable spellcheck on quickfix, switch between quickfix lists with the arrow
" keys
augroup quickfix
    au FileType qf set nospell
    au FileType qf, nnoremap <silent> <buffer> <right> :cnew<CR>
    au FileType qf, nnoremap <silent> <buffer> <left> :col<CR>
    au BufReadPost quickfix call GrepColors()
    au BufWinEnter quickfix call GrepColors()
    au BufWinEnter qf:list call GrepColors()
augroup end

" }}}

" I use this to highlight the match from grep, but keep quickfix syntax
" highlighting intact. Detects Linux due to the different escape sequences of
" GNU grep.
command -bar GrepColors call GrepColors()
function GrepColors()
    setlocal conceallevel=3
    setlocal cocu=nv

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

if filereadable(glob("~/.vimrc-local"))
    source ~/.vimrc-local
endif
