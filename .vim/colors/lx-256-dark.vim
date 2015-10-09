" based on tir_black color scheme
" which was Based on ir_black from: http://blog.infinitered.com/entries/show/8

set background=dark
hi clear

if exists("syntax_on")
 syntax reset
endif

let colors_name = "lx-256-dark"

" General colors
hi Normal guifg=#d0d0d0 guibg=#242424 ctermfg=252 ctermbg=NONE
hi NonText guifg=#070707 guibg=black ctermfg=0

hi Cursor guifg=black guibg=#5fafff ctermfg=0 ctermbg=15
hi LineNr ctermfg=102 ctermbg=237 guifg=#90908a guibg=#3c3d37

hi VertSplit guifg=#000000 guibg=#202020 ctermfg=235 ctermbg=60
hi StatusLine guifg=#1a1a1a guibg=#808080 ctermfg=232 ctermbg=60 cterm=reverse gui=reverse
hi StatusLineNC guifg=#080808 guibg=#202020 ctermfg=233 ctermbg=235

hi Folded guifg=#a0a8b0 guibg=#384048 ctermfg=grey ctermbg=60
hi FoldColumn guibg=#202020 guifg=darkgrey
hi Title guifg=#f6f3e8 gui=bold ctermfg=187 cterm=bold
hi Visual guibg=#262D51 ctermbg=60

hi TabLineSel ctermfg=blue
hi TabLineFill ctermbg=black cterm=none guifg=#000000
hi TabLine ctermfg=magenta ctermbg=black cterm=none

hi SpecialKey guifg=#808080 guibg=#343434 ctermfg=8 ctermbg=236

hi WildMenu guifg=black guibg=#cae682 ctermfg=0 ctermbg=195
hi PmenuSbar guifg=black guibg=white ctermfg=0 ctermbg=15

hi Error gui=undercurl ctermfg=203 ctermbg=NONE  cterm=underline guisp=#FF6C60
"hi ErrorMsg guifg=white guibg=#FF6C60 gui=bold ctermfg=white ctermbg=203 cterm=bold
hi ErrorMsg ctermfg=231 ctermbg=197 guifg=#f8f8f0 guibg=#f92672
hi WarningMsg guifg=white guibg=#FF6C60 gui=bold ctermfg=white ctermbg=203 cterm=bold
hi SpellBad cterm=underline ctermbg=none ctermfg=203
hi SpellCap cterm=underline
hi SpellRare cterm=underline
hi SpellLocal cterm=underline

hi DiffAdd ctermbg=17 guibg=#2a0d6a
hi DiffDelete ctermfg=234 ctermbg=60 cterm=none	 guifg=#242424	guibg=#3e3969	gui=none
hi DiffText	ctermbg=53 cterm=none guibg=#73186e gui=none
hi DiffChange ctermbg=55 guibg=#5f00af

hi ModeMsg guifg=black guibg=#C6C5FE gui=bold ctermfg=0 ctermbg=189 cterm=bold

if version >= 700 " Vim 7.x specific colors
    " hi CursorLine guibg=#1c1c1c gui=none ctermbg=235 cterm=none
    hi CursorLine ctermfg=NONE ctermbg=237 cterm=NONE guifg=NONE guibg=#3c3d37 gui=NONE
    hi CursorColumn guibg=#1c1c1c gui=none ctermbg=234 cterm=none
    hi MatchParen guifg=#df00ff guibg=#242424 gui=bold ctermfg=magenta ctermbg=none
    hi Pmenu guifg=#f6f3e8 guibg=#444444 ctermfg=white ctermbg=242
    hi PmenuSel guifg=#000000 guibg=#cae682 ctermfg=0 ctermbg=195
    hi Search guifg=#f6f3e8 guibg=#8700df ctermfg=white ctermbg=92
    hi SignColumn guibg=black ctermbg=232
endif

" Syntax highlighting
hi Comment guifg=#767676 ctermfg=244 gui=italic
hi String guifg=#5fffff ctermfg=123
hi Number ctermfg=141 guifg=#ae81ff

hi Keyword guifg=#96CBFE ctermfg=117
hi PreProc guifg=#ff5f87 ctermfg=204
hi Conditional guifg=#6699CC ctermfg=110

hi Todo guifg=#000000 guibg=#cae682 ctermfg=0 ctermbg=195
hi Constant guifg=#99CC99 ctermfg=151

hi Identifier guifg=#8787ff ctermfg=105 CTERM=NONE
" This is linked to Identifier by default, but that looks awful
hi mailQuoted2 guifg=#585858 ctermfg=240
hi Function guifg=#FFD2A7 ctermfg=223
hi Type guifg=#FFDFFF ctermfg=225
hi Statement guifg=#6699CC ctermfg=110
"hi Statement ctermfg=197 guifg=#f92672

hi Special guifg=#df8787 ctermfg=174
hi Delimiter guifg=#00A0A0 ctermfg=37
hi Operator guifg=white ctermfg=white

hi link Character Constant
hi link Boolean Constant
hi link Float Number
hi link Repeat Statement
hi link Label Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link SpecialComment Special
hi link Debug Special

" Special for Ruby
hi rubyRegexp guifg=#B18A3D ctermfg=brown
hi rubyRegexpDelimiter guifg=#FF8000 ctermfg=brown
hi rubyEscape guifg=white ctermfg=cyan
hi rubyInterpolationDelimiter guifg=#00A0A0 ctermfg=blue
hi rubyControl guifg=#6699CC ctermfg=blue "and break, etc
hi rubyStringDelimiter guifg=#336633 ctermfg=lightgreen
hi link rubyClass Keyword
hi link rubyModule Keyword
hi link rubyKeyword Keyword
hi link rubyOperator Operator
hi link rubyIdentifier Identifier
hi link rubyInstanceVariable Identifier
hi link rubyGlobalVariable Identifier
hi link rubyClassVariable Identifier
hi link rubyConstant Type

" Special for Java
hi link javaScopeDecl Identifier
hi link javaCommentTitle javaDocSeeTag
hi link javaDocTags javaDocSeeTag
hi link javaDocParam javaDocSeeTag
hi link javaDocSeeTagParam javaDocSeeTag

hi javaDocSeeTag guifg=#CCCCCC ctermfg=darkgray
hi javaDocSeeTag guifg=#CCCCCC ctermfg=darkgray

" Special for XML
hi link xmlTag Keyword
hi link xmlTagName Conditional
hi link xmlEndTag Identifier

" Special for HTML
hi link htmlTag Keyword
hi link htmlTagName Conditional
hi link htmlEndTag Identifier

" Special for Javascript
hi link javaScriptNumber Number

" Special for CSharp
hi link csXmlTag Keyword

" For taglist
hi MyTagListFileName guifg=#a0a8b0 guibg=#384048 ctermfg=grey ctermbg=60

" For cctree
highlight default link CCTreeHiSymbol  Title
highlight default link CCTreeHiMarkers Visual

" For quickfixsigns
hi QuickFixSignsDiffAddLx    ctermfg=0 ctermbg=27 guifg=black  guibg=#0000ff
hi QuickFixSignsDiffDeleteLx ctermfg=0 ctermbg=161 guifg=black guibg=#df005f
hi QuickFixSignsDiffChangeLx ctermfg=0 ctermbg=68 guifg=black  guibg=#5f87df

" For whitespace
highlight ExtraWhitespace ctermbg=236

" For buftabline
hi BufTabLineActive ctermbg=0 guibg=black
hi BufTabLineHidden ctermfg=242 guifg=#666666
hi BufTabLineActive ctermfg=248
