" ======== shell ========

function! ShellExecuteSilent(cmd)
	let ret = system(a:cmd)
	if v:shell_error
		echohl ErrorMsg
		echo "shell cmd ERROR! output:"
		echohl NONE
		echo ret
	endif
endfunction

command! -nargs=1 ShellExecuteSilent call ShellExecuteSilent(<f-args>)

nnoremap <leader>! :ShellExecuteSilent 

" ======== diff ========

function! DiffWithSaved()
	" record filetype
	let ft=&filetype
	" diff current file
	diffthis
	setl wrap
	" read saved file (content) in new vertical window
	vnew | read # | normal! 1Gdd
	" set options for temp file
	call BufSetTempView()
	" diff saved file and set filetype
	diffthis
	setl wrap
	execute 'set filetype='.ft
endfunction

command! DiffWithSaved call DiffWithSaved()

" 使用 shell 的 diff 命令比较当前文件和上次保存的区别
command! DiffWithSavedShell w !diff --color % -

" ======== search ========

" 在 $HOME/.vim 中搜索文件内容
command! -nargs=1 SearchVimFiles !find $HOME/.vim \( -path "*backup" -o -path "*plugged" -o -path "*.git" -o -path "*autoload" \) -prune -o -type f -not \( -name ".netrwhist" -o -name "*.swp" \) -exec grep -PH --color <args> {} \;

