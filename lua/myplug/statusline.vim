"TODO 仿照 myplug/tabline.vim, 把 statusline 也写成函数
"hi StatuslineFaint guifg=lightgrey guibg=#705697
"hi StatuslineFaintNC guifg=lightgrey guibg=#c4b7d7

function MyStatusLine()
	let s:statusline = ''

	if win_getid() == g:statusline_winid
		" -------- 左对齐部分 --------
		" 文件全路径
		let s:statusline ..= '%f'
		" buffer number 和 window number
		let s:statusline ..= '[%n]'
		"let s:statusline..=.%{winnr()}
		" 帮助文档
		"let s:statusline ..= '%h'
		" 只读状态和修改状态
		let s:statusline ..= '%r%m'

		" -------- 右对齐部分 --------
		let s:statusline ..= '%= '
		" 当前字符的十六进制
		let s:statusline ..= '|%BH'
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
		let s:statusline ..= '%f'
		let s:statusline ..= '[%n]'
		"let s:statusline ..= '%h'
		let s:statusline ..= '%r%m'
	endif
	
	return s:statusline
endfunction

set statusline=%!MyStatusLine()
