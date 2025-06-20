" -------- buffer make & set --------

function! BufMakeHidden(bname)
	if type(a:bname) == v:t_number
		let bn = a:bname
	else
		let bn = bufnr(fnameescape(a:bname))
	endif
	call setbufvar(bn, '&bufhidden', 'hide')
endfunction

function! BufMakeScratch(bname)
	if type(a:bname) == v:t_number
		let bn = a:bname
	else
		let bn = bufnr(fnameescape(a:bname))
	endif
	" 注: 如果是设置, 默认会修改 local, 不修改 global
	call setbufvar(bn, '&buftype', 'nofile')
	call setbufvar(bn, '&bufhidden', 'hide')
	call setbufvar(bn, '&swapfile', 0)
	" 不管用, 因为选项是 local to window 而不是 local to buffer
	"call setbufvar(bn, '&wincolor', 'ScratchNormal')
endfunction

function! BufSetTempView()
	" 只读, 退出不提示保存, 无交换文件
	" 类型为 nofile, 关闭窗口时 wipe buffer
	setl readonly nomodified noswapfile buftype=nofile bufhidden=wipe
endfunction

" -------- scratch buffer --------

" 添加 _scratch_ 缓冲区 (当前 vim 共用)
if !bufexists('_scratch_')
	badd _scratch_
	call BufMakeScratch('_scratch_')
endif

" edit scratch buffer
nnoremap <leader>es :sb _scratch_<cr>
nnoremap <leader>Es :vert sb _scratch_<cr>

