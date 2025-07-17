" 定义行数指示器高亮组（灰色背景，白色文字）
" TODO 兼容 color.lua
highlight FoldNumber guifg=#d18a2e guibg=#c4d6b4

function! FoldText()
	" [1] 获取并清理折叠行内容
	let line = getline(v:foldstart)
	let line = substitute(line, '^\t\+', '\=repeat(" ", len(submatch(0)) * &l:tabstop)', '')
	" 去除行尾空白
	let line = substitute(line, '\s*$', '', 'g')

	" [2] 计算窗口可用宽度（考虑 signcolumn/number/foldcolumn）
	let win_width = winwidth(0)
	" TODO ignore now (I set signcolumn to number)
	"let win_width -= &signcolumn
	if &number || &relativenumber
		let win_width -= max([&numberwidth, strlen(line('$')) + 1])
	endif
	" TODO ignore now (I don't use foldcolumn)
	"let win_width -= &foldcolumn

	" [3] 准备行数指示器
	let numOfLines = v:foldend - v:foldstart + 1
	" TODO 高亮无法显示
	"let numIndicator = '%#FoldNumber#' . numOfLines . ' LINES'	" 使用高亮组
	let numIndicator = numOfLines . ' LINES'

	" [4] 计算各部分宽度（考虑截断）
	" 减去高亮标记的虚拟宽度
	let indicator_width = strdisplaywidth(numIndicator)
	" 保留2空格作为最小间隙
	let max_line_width = win_width - indicator_width - 2
	" 硬截断
	" TODO 考虑当一行过长时, 用指示符提示这一点 (如 ...)
	if strdisplaywidth(line) > max_line_width
		if strdisplaywidth(line) <= 3
			let line = repeat('.', strdisplaywidth(line))
		else
			let line = strpart(line, 0, max_line_width-3)..'...'
		endif
	endif

	let padding = max([win_width - strdisplaywidth(line) - indicator_width, 1])

	" [5] 组合最终文本
	return line . repeat(' ', padding) . numIndicator
endfunction

set foldtext=FoldText()

"function FoldText()
"	let line = getline(v:foldstart)
"	let line = substitute(line, '^\t\+', '\=repeat(" ", len(submatch(0)) * &l:tabstop)', '')
"	let numOfLines = v:foldend - v:foldstart + 1
"	let numIndicator = '|'..numOfLines..' LINES|'
"	return line..numIndicator
"endfunction
"
"set foldtext=FoldText()

