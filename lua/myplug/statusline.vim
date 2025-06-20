"TODO 仿照 myplug/tabline.vim, 把 statusline 也写成函数
"hi StatuslineFaint guifg=lightgrey guibg=#705697
"hi StatuslineFaintNC guifg=lightgrey guibg=#c4b7d7

set statusline=

" -------- 左对齐部分 --------
" 文件全路径
set statusline+=%f
" buffer number 和 window number
set statusline+=[%n]
"set statusline+=.%{winnr()}
" 帮助文档
set statusline+=%h
" 只读状态和修改状态
set statusline+=%r%m

" -------- 右对齐部分 --------
set statusline+=%=\ 
" 当前字符的十六进制
set statusline+=\|%BH
" 列位置
" %v 是显示上的列位置 (例如一般英文字符 1 格, 中文字符 2 格)
" %c 是按字节的列位置
" 注: 行位置是 %l
set statusline+=\|%v
" 文件格式 (unix/dos...)
"set statusline+=\|%{&ff}
" 文件类型 (vim/cpp/json...)
set statusline+=\|%Y
" 当前百分比
set statusline+=\|%2p%%

