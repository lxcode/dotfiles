" .typ is ambiguous (vim treats it as either SQL or Typst) and was resolving to
" neither under this config, so default it to Typst.
au BufRead,BufNewFile *.typ setfiletype typst
