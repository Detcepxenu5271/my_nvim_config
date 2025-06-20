" ======== build ========

" clang/clang++, 编译单文件, 不带/带调试选项
" %:t 编译当前文件
" -o %:t:r 输出二进制文件的名称为: 当前文件名去除后缀
" -Wall 警告信息
" read -n 1 -s 读取一个字符后退出, 有输入提示, 不显示输入
" 旧: cd %:h 进入当前文件所在目录 (便于处理重定向/文件读写的相对路径)
"command! -nargs=? Bclang :terminal ++rows=10 ++shell ++close cd %:h && clang %:t -o %:t:r -Wall <args> ; read -p "按任意键继续..." -n 1 -s
" 新: 以 vim 的当前路径作为相对路径的开始 (需要通过 :lc 命令手动切换), 后同
command! -nargs=? Bclang :terminal ++rows=10 ++shell ++close clang % -o %:r -Wall <args> ; read -p "按任意键继续..." -n 1 -s
" -g 生成调试信息
" -fstandalone-debug (为了让 string 等类型的变量可以被 lldb 输出)
" -DDEBUG 自定义的 DEBUG 选项, 用于 #ifdef
command! -nargs=? BDclang :terminal ++rows=10 ++shell ++close clang % -o %:r -Wall -g -fstandalone-debug -DDEBUG <args> ; read -p "按任意键继续..." -n 1 -s
command! -nargs=? Bclangpp :terminal ++rows=10 ++shell ++close clang++ % -o %:r -Wall <args> ; read -p "按任意键继续..." -n 1 -s
command! -nargs=? BDclangpp :terminal ++rows=10 ++shell ++close clang++ % -o %:r -Wall -g -fstandalone-debug -DDEBUG <args> ; read -p "按任意键继续..." -n 1 -s

" 运行单文件 (例如 xxx.cpp 对应的可执行文件 xxx)
" 不在配置文件里设置映射, 推荐使用时临时映射, 以处理要输入特定参数的情况
" 例如可以执行 :nnoremap <leader>Rs :R < s1.in<cr>
" 旧: 在 terminal 中进入可执行文件所在路径, 这样进行输入输出重定向时, 就以文件所在路径作为相对路径
"command! -nargs=? R :terminal ++rows=10 ++shell ++close cd %:h && ./%:t:r <args> ; read -p "按任意键继续..." -n 1 -s
" 新: 保持使用 :lc 切换 (vim中) 当前路径的习惯, 以 vim 的当前路径作为相对路径
command! -nargs=? R :terminal ++rows=10 ++shell ++close /usr/bin/time -f "[Real: \%es]" %:p:r <args> ; read -p "[Press Any Key to Quit...]" -n 1 -s

