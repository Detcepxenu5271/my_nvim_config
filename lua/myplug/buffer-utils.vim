" -------- buffer make & set --------

" @bn buffer number (get from "bufnr()" function)
function! BufMakeHidden(bn)
	call setbufvar(a:bn, '&bufhidden', 'hide')
endfunction

function! BufMakeScratch(bn)
	" 注: 如果是设置, 默认会修改 local, 不修改 global
	call setbufvar(a:bn, '&buftype', 'nofile')
	call setbufvar(a:bn, '&bufhidden', 'hide')
	call setbufvar(a:bn, '&buflisted', 0)
	call setbufvar(a:bn, '&swapfile', 0)
	" BUG 对同一个 buffer 重复调用当前函数, 会创建多个相同的 autocmd
	exe 'autocmd BufWinEnter <buffer='..a:bn..'> setl winhighlight=Normal:ScratchNormal,EndOfBuffer:ScratchEndOfBuffer'
	" 不管用, 因为选项是 local to window 而不是 local to buffer
	"call setbufvar(a:bn, '&wincolor', 'ScratchNormal')
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
	call BufMakeScratch(bufnr('_scratch_'))
endif

" edit scratch buffer
nnoremap <leader>es :sb _scratch_<cr>
nnoremap <leader>Es :vert sb _scratch_<cr>

