local map = vim.keymap.set

-- TODO desc

-- ======== Leader ========

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 建议: <leader>t 留作临时映射用, 例如临时设置 <leader>ta 等

map('n', '<space>', '<nop>')

-- 类似 set xxx 功能的设置
map('n', '<leader><leader>h', ':noh<cr>', {silent = true})
map('n', '<leader><leader>t', ':let &showtabline = 3-&showtabline<cr>')
map('n', '<leader><leader>w', ':set wrap!<cr>')

-- 在当前字符前后插入空格
map('n', '<leader>a', 'i<space><esc>la<space><esc>l')
map('v', '<leader>a', 'c<space><c-r>"<space><esc>')

-- <leader>e? edit file (实际行为一般是 split)
-- split 方向: e 是 horizontal, E 是 vertical
map('n', '<leader>ev', ':sp $MYVIMRC<cr>')
map('n', '<leader>Ev', ':vs $MYVIMRC<cr>')
map('n', '<leader>eb', ':buffers<cr>:sb<space>')
map('n', '<leader>Eb', ':buffers<cr>:vert sb<space>')
map('n', '<leader>er', ':browse oldfiles<cr>')
-- <leader>s? source file
map('n', '<leader>sv', ':source $MYVIMRC<cr>')

-- window
map('n', '<leader>w', '<c-w>')

-- 按整个单词 (whole word) 搜索
map('n', '<leader>/', ":let @/='\\<'..input('Search word: ')..'\\>'<CR>")

-- directory (lc 当前目录)
-- 注: 使用 %:p, 当前文件为目录时, 会以 '/' 结尾, %:p:h 只会去掉该结尾
--     pwd 是用来显示一下当前目录
-- 当前文件所在目录
map('n', '<leader>dd', ':lc %:p:h | pwd<cr>')
-- 工作区目录, 需要 $ws 变量
-- TODO workspace (myplug), 还有 ew, Ew, sw
map('n', '<leader>dw', ':lc $ws | pwd<cr>')

-- ======== Insert 模式下的 "leader" ========

-- jl 是 Insert 模式下自定义操作的 leader

-- 计算当前表达式, 刚输完表达式后使用, 会占用 0 寄存器
-- TODO 写成插件?
--      先设置成自定义命令, 再绑定快捷键
--      当前无法处理表达式开头紧挨其他字符的情况 (如方括号内的表达式)
-- fixed 如果表达式末尾紧挨着其他字符, 现在也可以正常求值
--       原: inoremap jl= <esc>yiWEa=<c-r>=<c-r>0<cr>
-- jl== 替换为结果
-- jl=e 添加计算结果 (保留 expression)
map('i', 'jl==', '<esc>vBdi<c-r>=<c-r>"<cr>')
map('i', 'jl=e', '<space><esc>yBEls=<c-r>=<c-r>0<cr>')

-- ======== 移 动 (motion) ========

map({'n', 'v', 'o'}, 'H', '0')
map({'n', 'v', 'o'}, 'L', '$')
map({'n', 'v', 'o'}, 'gH', 'g0')
map({'n', 'v', 'o'}, 'gL', 'g$')

-- insert 和 cmdline, 部分操作修改成和一般 shell 行为一致
-- <c-a>, <c-e>: home, end
-- <c-b>, <c-f>: left, right
-- <c-h>, <c-l>: backspace, delete (自定义的)
map('i', '<c-a>', '<home>')
map('i', '<c-b>', '<left>')
map('i', '<c-f>', '<right>')
map('i', '<c-e>', '<end>')
map('c', '<c-a>', '<home>')
map('c', '<c-b>', '<left>')
map('c', '<c-f>', '<right>')

-- ======== 编 辑 (edit) ========

map('i', '<c-l>', '<del>')
map('c', '<c-l>', '<del>')

-- ======== 窗口 (window) ========

-- 切换当前窗口
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- 改变大小
-- = 默认是执行 'equalprg' 命令或内置格式化
-- 如果想使用原来的行为, 可以用 normal! 命令
map('n', '=', '<c-w>+')
map('n', '-', '<c-w>-')
map('n', '+', '<c-w>>')
map('n', '_', '<c-w><')

-- ======== esc 绑定 ========

map('i', 'jk', '<esc>')
-- 禁用, 练习 jk 绑定
--map('i', '<esc>', '<nop>')
--map('i', '<c-[>', '<nop>')
-- 终端
map('t', 'jk', '<c-\\><c-n>')

