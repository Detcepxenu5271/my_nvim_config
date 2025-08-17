"TODO 仿照 myplug/tabline.vim, 把 statusline 也写成函数
"hi StatuslineFaint guifg=lightgrey guibg=#705697
"hi StatuslineFaintNC guifg=lightgrey guibg=#c4b7d7

"BUG 如果将窗口分成左右两边，左边的状态栏内容较长，需要在%<处截断，此时在左边窗口内移动光标，状态栏的右半部分（%=之后的部分）经常会在右边窗口的状态栏开头重复出现一次，覆盖了右边窗口状态栏的部分内容
"    发现: 当 %= 左边过长被截断, 右边的长度发生变化时, 就可能触发该 BUG
"    发现: 大概率是中文 (宽度大于1的字符) 问题, 暂时没找到好的解决办法
function! MyStatusLine()
	let s:statusline = ''

	let s:wid = win_getid()
	let s:isnofile = getbufvar(winbufnr(g:statusline_winid), "&buftype") == "nofile"
	if s:wid == g:statusline_winid
		" -------- 左对齐部分 --------
		" buffer number 和 window number
		" nofile use `` rather than []
		if s:isnofile
			let s:statusline ..= '`%n`'
		else
			let s:statusline ..= '[%n]'
		endif
		" 文件全路径, 从这里截断 (保证 bufnr 显示)
		let s:statusline ..= '%<%f'
		"let s:statusline..=.%{winnr()}
		" 帮助文档
		"let s:statusline ..= '%h'
		" 只读状态和修改状态
		let s:statusline ..= '%r%m'

		" -------- 右对齐部分 --------
		let s:statusline ..= '%= '
		" 当前字符的十六进制
		let s:statusline ..= '|%B'
		" 列位置
		" %v 是显示上的列位置 (例如一般英文字符 1 格, 中文字符 2 格)
		" %c 是按字节的列位置
		" 注: 行位置是 %l
		let s:statusline ..= '|%v'
		" 文件格式 (unix/dos...)
		"let s:statusline..=|%{&ff}
		" 文件类型 (vim/cpp/json...)
		let s:statusline ..= '|%Y'
		" 当前百分比
		let s:statusline ..= '|%2p%%'
	else
		if s:isnofile
			let s:statusline ..= '`%n`'
		else
			let s:statusline ..= '[%n]'
		endif
		let s:statusline ..= '%<%f'
		"let s:statusline ..= '%h'
		let s:statusline ..= '%r%m'
	endif
	
	return s:statusline
endfunction

set statusline=%!MyStatusLine()

