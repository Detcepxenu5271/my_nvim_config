" help of format string: stl-%!

function! TabHasModifiedBuffers(tabnr)
	let tabinfo = gettabinfo(a:tabnr)
	if empty(tabinfo) | return 0 | endif

	return len(filter(tabinfo[0].windows, 'getbufvar(winbufnr(v:val), "&modified")')) > 0
endfunction

" modified from MyTabLine() in tabpage.txt
function! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		" select the highlighting
		if i+1 == tabpagenr()
			let tab_hi = '%#TabLineSel#'
			" TODO 为数字单独设置高亮
			let tabnr_hi = '%#TabLineSel#'
		else
			let tab_hi = '%#TabLine#'
			" TODO 为数字单独设置高亮
			let tabnr_hi = '%#TabLine#'
		endif

		" set the tab page number (for mouse clicks)
		let s ..= '%' .. (i+1) .. 'T'

		let buflist = tabpagebuflist(i+1)
		let winnr = tabpagewinnr(i+1)

		" begin seperator
		let s ..= tab_hi .. ' '
		" tabpage number and number of buffers
		let s ..= tabnr_hi .. '[' .. (i+1)
		if TabHasModifiedBuffers(i+1) | let s ..= '+' | endif
		let s ..= ']'
		" current working director y
		let s ..= tab_hi .. ' ' .. fnamemodify(getcwd(winnr, i+1), ':t') .. '/'
		let s ..= (len(buflist) > 1 ? '('..len(buflist)..')' : '')
		" current file name
		"let s ..= fnamemodify(bufname(buflist[winnr-1]), ':t') .. ' '
		" end seperator
		let s ..= ' '
	endfor

	" after the last tab fill with TabLineFill and reset tab page nr
	let s ..= '%#TabLineFill#%T'
	" right-align
	let s ..= '%='
	" the label to close the current tab page
	if tabpagenr('$') > 1
		let s ..= '%#TabLine#%999XX'
	endif

	return s
endfunction

set tabline=%!MyTabLine()
