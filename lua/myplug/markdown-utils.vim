" ======== Markdown 标题跳转 ========

" 从当前链接跳转到 markdown 标题
" @param issplit 是否使用 split 打开文件 (如果是 false, 则用 edit)
" @param isvert (如果使用 split) 是否在垂直方向打开
" 链接格式: [链接名称](文件名#标题名)
"     文件名 (包含路径) 会在 path 中搜索
"     (注意: 期望将 path 设置为 ".,,**,workspace/**",
"      即先搜索文件所在路径, 再 downwards 搜索 pwd, 最后 downwards 搜索 workspace 设置的根目录)
"     标题名要求: 对应文件中任意级别的标题, 原样保留所有内容
"                 可以只匹配实际标题中间连续的一部分
"                 (例如 #章节小标题 可以匹配 ### 1.2 章节小标题)
"     如果链接中没有文件名, 则在当前文件搜索标题
"     如果链接中没有#标题名, 则只跳转到文件
function! GotoMarkdownHeader(issplit = 0, isvert = 0)
	" -------- 1. 提取 markdown 链接 --------

    " 获取光标所在行的链接内容 (格式：[text](path#anchor))
    let line = getline('.')
	" "\[.\{-}\]"            : 方括号和其中的链接名
	" "(...)"                : 链接内容
	" > "\(.\{-}\)"        \1: 文件名
	" > "\(#\(.\{-}\)\)\?" \2: #标题名称 (可以不存在)
	"   > "\(.\{-}\)"      \3: 标题名称
    let link_match = matchlist(line, '\[.\{-}\](\(.\{-}\)\(#\(.\{-}\)\)\?)')
    if empty(link_match)
		echohl ErrorMsg
        echo "Not on a Markdown link!"
		echohl NONE
        return
    endif

    " 提取文件名和锚点
    let target_file = link_match[1]  " 如 'dir/B.md'
    let anchor = link_match[3]       " 如 '标题 title 1'

    " 将锚点原样作为标题文本
	"XXX 替换 magic 符号 ('.', '*' 等)
    let header_text = anchor
	" 标题匹配模式, 可以只匹配标题中间连续的一部分
	let header_pattern = '^\#\{1,6}.\{-}' .. header_text .. '.\{-}$'

	" -------- 2. 搜索当前文件 (如果没有文件名) --------

	" 没有指定文件, 在当前文件搜索
	if empty(target_file)
		" w 选项是 wrap 搜索, 搜到结尾会折回开头
		" s 选项会在当前位置设置 ' mark, 修改 jumplist
		if !search(header_pattern, 'ws')
			echohl ErrorMsg
			echo "Header not found in current file: " .. header_text
			echohl NONE
			return
		endif
		" 居中
		normal! zz
		return
	endif

	" -------- 3. 跳转到链接文件/目录 (如果有文件名) --------

	" 需要跳转文件, 则当 issplit=false 时, 要检查当前文件是否被修改过
    if !a:issplit && &modified
		echohl WarningMsg
        echo "Warning: Current file has unsaved changes. Save it first!"
		echohl NONE
        return
    endif

    " 跳转到文件
	if a:issplit
		if a:isvert
			let open_cmd = 'vsplit'
		else
			let open_cmd = 'split'
		endif
	else
		let open_cmd = 'edit'
	endif
	let found_file = findfile(target_file, &path)
	" 不是文件, 可能是目录, 或不存在
    if !filereadable(found_file)
		let found_dir = finddir(target_file, &path)
		" 是目录, 打开, 并结束 (不继续搜索标题)
		if isdirectory(found_dir)
			execute open_cmd fnameescape(found_dir)
			return
		endif
		" 文件不存在
		echohl ErrorMsg
        echo "File/Dir not found: " .. target_file
		echohl NONE
		return
	endif
	execute open_cmd fnameescape(found_file)

	" -------- 4. 搜索标题 (如果指定了标题) --------

    " 搜索标题 (不区分大小写), 如果没有指定标题则只跳转到文件
	if !empty(link_match[2]) && !search(header_pattern, 'w')
		" 返回刚才的文件
		if a:issplit
			execute "close"
		else
			execute "normal! \<C-o>"
		endif
		echohl ErrorMsg
		echo "Header not found in target file: "..header_text
		echohl NONE
		return
	endif

	" 居中
	normal! zz
endfunction

" 仅在 markdown 文件中映射 gf, <c-w>f 等
augroup myplug_markdown_utils
    autocmd!
    autocmd FileType markdown nnoremap <buffer><silent> <LocalLeader>oo :call GotoMarkdownHeader()<CR>
    autocmd FileType markdown nnoremap <buffer><silent> <LocalLeader>os :call GotoMarkdownHeader(1)<CR>
    autocmd FileType markdown nnoremap <buffer><silent> <LocalLeader>ov :call GotoMarkdownHeader(1, 1)<CR>
augroup END

" ======== Markdown 格式化表格 ========

" 将上次 visual 模式下选中的内容按表格格式化
autocmd FileType markdown command! -buffer MarkdownTableFormat '<,'>!column -t -s '|' -o '|'

