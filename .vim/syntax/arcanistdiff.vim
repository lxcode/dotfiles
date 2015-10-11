if has('spell')
    syn spell toplevel
endif

syn match arcanistdiffSummary "^Summary:"
syn match arcanistdiffTestPlan "^Test Plan:"
syn match arcanistdiffReviewers "^Reviewers:"
syn match arcanistdiffSubscribers "^Subscribers:"
syn match   arcanistdiffComment "^#.*"

" The first line should only span one line.
syn match   arcanistdiffFirstLine   "\%^[^#].*" nextgroup=arcanistdiffBlank skipnl
syn match   arcanistdiffSimpleSummary   "^.\{0,50\}"
    \ contained containedin=arcanistdiffFirstLine
    \ nextgroup=arcanistdiffOverflow contains=@Spell

syn match   arcanistdiffOverflow    ".*" contained contains=@Spell
syn match   arcanistdiffBlank   "^[^#].*" contained contains=@Spell

hi def link arcanistdiffSummary Special
hi def link arcanistdiffTestPlan Special
hi def link arcanistdiffReviewers Special
hi def link arcanistdiffSubscribers Special

hi def link arcanistdiffSimpleSummary Keyword
hi def link arcanistdiffBlank   Error
hi def link arcanistdiffComment Comment
