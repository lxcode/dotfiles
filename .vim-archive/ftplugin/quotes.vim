	" TexQuotes: inserts `` or '' instead of "
	" Taken from texmacro.vim by Benji Fisher <benji@e-math.AMS.org>
    " Then modified from vim-latex by lxcode.
	function! s:TexQuotes()
		let l = line(".")
		let c = col(".")
		let restore_cursor = l . "G" . virtcol(".") . "|"
		normal! H
		let restore_cursor = "normal!" . line(".") . "Gzt" . restore_cursor
		execute restore_cursor
		" In math mode, or when preceded by a \, just move the cursor past the
		" already-inserted " character.
		if synIDattr(synID(l, c, 1), "name") =~ "^texMath"
			\ || (c > 1 && getline(l)[c-2] == '\')
			return "\<Right>"
		endif
		" Find the appropriate open-quote and close-quote strings.
		let open = "``"
		let close = "''"
		let boundary = '\|'

		" Eventually return q; set it to the default value now.
		let q = open
		let pattern = 
			\ escape(open, '\~') .
			\ boundary .
			\ escape(close, '\~') .
			\ '\|^$\|"'

		while 1	" Look for preceding quote (open or close), ignoring
			" math mode and '\"' .
			call search(pattern, "bw")
			if synIDattr(synID(line("."), col("."), 1), "name") !~ "^texMath"
				\ && strpart(getline('.'), col('.')-2, 2) != '\"'
				break
			endif
		endwhile
		
		" Now, test whether we actually found a _preceding_ quote; if so, is it
		" an open quote?
		if ( line(".") < l || line(".") == l && col(".") < c )
			if strpart(getline("."), col(".")-1) =~ '\V\^' . escape(open, '\')
			    let q = close
			endif
		endif

		" Return to line l, column c:
		execute restore_cursor
		" Start with <Del> to remove the " put in by the :imap .
		return "\<Del>" . q

	endfunction

inoremap <buffer> <silent> " "<Left><C-R>=<SID>TexQuotes()<CR>

" vim:fdm=marker:ff=unix:noet:ts=4:sw=4:nowrap
