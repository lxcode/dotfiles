" based on tir_black color scheme
" which was Based on ir_black from: http://blog.infinitered.com/entries/show/8

set background=dark
hi clear

if exists("syntax_on")
 syntax reset
endif

let colors_name = "lx-256-dark"

" General colors
"hi Normal guifg=#a8a8a8 guibg=black ctermfg=white ctermbg=NONE
hi Normal guifg=#d0d0d0 guibg=#242424 ctermfg=252 ctermbg=234
hi NonText guifg=#070707 guibg=black ctermfg=0

hi Cursor guifg=black guibg=#5fafff ctermfg=0 ctermbg=15
hi LineNr guifg=#3D3D3D guibg=#101010 ctermfg=239 ctermbg=NONE

hi VertSplit guifg=#000000 guibg=#202020 ctermfg=235 ctermbg=60 
hi StatusLine guifg=#1a1a1a guibg=#808080 ctermfg=233 ctermbg=60
hi StatusLineNC guifg=#080808 guibg=#202020 ctermfg=240 ctermbg=235

hi Folded guifg=#a0a8b0 guibg=#384048 ctermfg=grey ctermbg=60
hi FoldColumn guibg=#202020 guifg=darkgrey
hi Title guifg=#f6f3e8 gui=bold ctermfg=187 cterm=bold
hi Visual guibg=#262D51 ctermbg=60

hi TabLineSel ctermfg=blue
hi TabLineFill ctermbg=black cterm=none
hi TabLine ctermfg=magenta ctermbg=black cterm=none

hi SpecialKey guifg=#808080 guibg=#343434 ctermfg=8 ctermbg=236

hi WildMenu guifg=black guibg=#cae682 ctermfg=0 ctermbg=195
hi PmenuSbar guifg=black guibg=white ctermfg=0 ctermbg=15

hi Error gui=undercurl ctermfg=203 ctermbg=none cterm=underline guisp=#FF6C60
hi ErrorMsg guifg=white guibg=#FF6C60 gui=bold ctermfg=white ctermbg=203 cterm=bold
hi WarningMsg guifg=white guibg=#FF6C60 gui=bold ctermfg=white ctermbg=203 cterm=bold
hi SpellBad cterm=underline ctermbg=none ctermfg=203
hi SpellCap cterm=underline
hi SpellRare cterm=underline
hi SpellLocal cterm=underline

hi DiffAdd ctermbg=17 guibg=#2a0d6a
hi DiffDelete ctermfg=234 ctermbg=60 cterm=none	 guifg=#242424	guibg=#3e3969	gui=none
hi DiffText	ctermbg=53	cterm=none guibg=#73186e gui=none
hi DiffChange ctermbg=237	guibg=#382a37

hi ModeMsg guifg=black guibg=#C6C5FE gui=bold ctermfg=0 ctermbg=189 cterm=bold

if version >= 700 " Vim 7.x specific colors
 hi CursorLine guibg=#1c1c1c gui=none ctermbg=235 cterm=none
 hi CursorColumn guibg=#1c1c1c gui=none ctermbg=234 cterm=none
 hi MatchParen guifg=#f6f3e8 guibg=#857b6f gui=bold ctermfg=white ctermbg=darkgray 
 hi Pmenu guifg=#f6f3e8 guibg=#444444 ctermfg=white ctermbg=242 
 hi PmenuSel guifg=#000000 guibg=#cae682 ctermfg=0 ctermbg=195 
 hi Search guifg=#000000 guibg=#875f87 ctermfg=232  ctermbg=96 
endif

" Syntax highlighting
hi Comment guifg=#767676 ctermfg=244 gui=italic
hi String guifg=#A8FF60 ctermfg=155 
hi Number guifg=#FF73FD ctermfg=207 

hi Keyword guifg=#96CBFE ctermfg=117 
hi PreProc guifg=#e5786d ctermfg=173 
hi Conditional guifg=#6699CC ctermfg=110 

hi Todo guifg=#000000 guibg=#cae682 ctermfg=0 ctermbg=195 
hi Constant guifg=#99CC99 ctermfg=151 

hi Identifier guifg=#C6C5FE ctermfg=189
hi Function guifg=#FFD2A7 ctermfg=223 
hi Type guifg=#FFFFB6 ctermfg=229 
hi Statement guifg=#6699CC ctermfg=110

hi Special guifg=#E18964 ctermfg=173
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

highlight default link CCTreeHiSymbol  Title
highlight default link CCTreeHiMarkers Visual

