function! PreviewColor(color)
	if !IsValidColorName(a:color) && !IsValidHexColor(a:color)
		echohl ErrorMsg
		echo a:color." is not a valid color!"
		echohl NONE
		return
	endif
	" 提示文本 (类型是字符串列表)
	if a:color =~ '^#'
		let text = ['Color Preview:',
			\ 'Hex: '.a:color,
			\ '',
			\ 'Press q to close'
			\ ]
	else
		let text = ['Color Preview:',
			\ 'Name: '.a:color,
			\ 'Hex: '.v:colornames[a:color],
			\ '',
			\ 'Press q to close'
			\ ]
	endif
	" 设置预览颜色变量 color 和对比色变量 contrast_color
	" 添加单引号, 处理颜色名有空格的情况 (例如 'light red')
	"     (最好还是不要有空格)
	"     在单引号括起的字符串中, '' 表示单引号本身
	let color=''''.a:color.''''
	let contrast_color=''''.GetContrastColor(a:color).''''
	" 设置临时高亮组, 作为 popup 的 highlight (wincolor)
	execute 'hi TEMPCOLOR guifg='.contrast_color.' guibg='.color
	" 设置 filter 函数, 过滤特定按键, 用于按 q 关闭窗口
	let popid= popup_dialog(text, #{
		\ highlight: 'TEMPCOLOR',
        \ filter: 'PreviewColorFilter',
		\})
endfunction

function! IsValidColorName(color)
    " 检查是否为有效颜色名
    return has_key(v:colornames, a:color)
endfunction

function! IsValidHexColor(color)
	" 检查是否为有效十六进制颜色
	" =~? 表示用正则匹配, 且忽略大小写
	return a:color =~? '^#[0-9a-f]\{6}$'
endfunction

function! PreviewColorFilter(id, key)
	if a:key == 'q'
		call popup_close(a:id)
		return 1
	endif
    return 0
endfunction

function! GetContrastColor(color)
	if IsValidColorName(a:color)
		let color = v:colornames[a:color]
	elseif IsValidHexColor(a:color)
		let color = a:color
	else
		echohl ErrorMsg
		echo a:color." is not a valid color!"
		echohl NONE
		" 这里理论上不应该执行到
		return '#ffffff'
	endif

    " 提取 RGB 值（支持 '#RRGGBB' 格式）
    let r = str2nr(color[1:2], 16)
    let g = str2nr(color[3:4], 16)
    let b = str2nr(color[5:6], 16)

    " 计算相对亮度（公式：W3C WCAG 2.0）
    let luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255

    " 根据亮度返回黑色或白色
    return luminance > 0.5 ? 'quietlight_black' : 'quietlight_white'
endfunction

command! -nargs=1 ColorPreview call PreviewColor(<f-args>)
