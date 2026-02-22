local map = vim.keymap.set

-- ======== META ========

map('n', 'M', function()
	vim.cmd([[
		exe 'tabe' stdpath('data')..'/meta.txt'
		exe 'tc' stdpath('data')
		setl foldmethod=indent
	]])
end, {desc = 'Meta Command'})

-- ======== Leader ========
-- 优先使用 Leader 类映射, 避免过多改变默认按键映射

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map('n', '<leader>', '<nop>')

map('n', '<leader>/', ":let @/='\\<'..input('Search word: ')..'\\>'<CR>")
-- search inside Visual area
map('v', '<leader>/', "<Esc>`</\\%V")
map('n', '<leader>d', '<nop>')
map('n', '<leader>dd', [[:exe "lc" substitute(expand('%:p:h'), '^\w\+://', '', '') | pwd<cr>]])
map('n', '<leader>dt', [[:exe "tc" substitute(expand('%:p:h'), '^\w\+://', '', '') | pwd<cr>]])
map('n', '<leader>dw', ':tc $ws | pwd<cr>')
map('n', '<leader>E', '<nop>')
map('n', '<leader>e', '<nop>')
map('n', '<leader>eb', ':buffers<cr>:sb<space>')
map('n', '<leader>Eb', ':buffers<cr>:vert sb<space>')
map('n', '<leader>er', ':browse oldfiles<cr>')
map('n', '<leader>ev', ':sp $MYVIMRC<cr>')
map('n', '<leader>Ev', ':vs $MYVIMRC<cr>')
map('n', '<Leader>I', ':Inspect<CR>')
map('n', '<leader>o', '<nop>')
map('n', '<leader>oc', function ()
	local state = (vim.o.cursorline and 1 or 0) + (vim.o.cursorcolumn and 1 or 0)
	state = (state + 1) % 3
	if state == 0 then
		vim.o.cursorline = false; vim.o.cursorcolumn = false
	elseif state == 1 then
		vim.o.cursorline = true; vim.o.cursorcolumn = false
	else
		vim.o.cursorline = true; vim.o.cursorcolumn = true
	end
end)
map('n', '<leader>oh', ':noh<cr>', {silent = true})
map('n', '<leader>on', function()
	if vim.wo.number then
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.showbreak = vim.go.showbreak
	else
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
		vim.opt_local.showbreak = "NONE"
	end
end)
map('n', '<leader>ot', ':let &showtabline = 3-&showtabline | setl showtabline?<cr>')
map('n', '<leader>ow', ':setl wrap! wrap?<cr>')
map('n', '<leader>w', '<c-w>')

-- ======== Insert 模式下的 "leader" ========
-- 用 jl 作为 leader

-- 原: 需要 setup util.math
-- 现: 设计上 util 要在脚本中主动调用, 而表达式求值常用, 直接附带
map('i', 'jl==', '<esc>vBdi<c-r>=<c-r>"<cr>')
map('i', 'jl=e', '<space><esc>yBEls=<c-r>=<c-r>0<cr>')
map("v", "<Leader>=v", [[s<C-r>=<C-r>"<Cr><Esc>]], {desc = "Evaluate Vim Expression"})
map("v", "<Leader>=l", [[s<C-r>=luaeval('<C-r>"')<Cr><Esc>]], {desc = "Evaluate Lua Expression"})

-- ======== 移 动 (motion) ========
-- 类 Emacs 的 insert & commandline 模式
-- 用 C-n 代替 C-i
-- H/L 设为 0/$, 因为行首/尾移动频繁
-- hjkl 默认在显示的行 (display line) 上移动, 而不是实际的行 (交换 j 和 gj 等的行为)

map({'i', 'c'}, '<c-a>', '<home>')
-- use <expr> because function return the key rather than execute it
map({'i'}, '<C-e>', function() return vim.fn.pumvisible() == 0 and '<End>' or '<C-e>' end, { expr = true, })
map({'i'}, '<c-b>', '<left>')
map({'i'}, '<c-f>', '<right>')
map({'c'}, '<c-b>', function() return vim.fn.pumvisible() == 0 and '<Left>' or '<Up>' end, { expr = true, })
map({'c'}, '<c-f>', function() return vim.fn.pumvisible() == 0 and '<Right>' or '<Down>' end, { expr = true, })
-- pair of <C-o> (older) and <C-n> (newer), since <C-i> and <Tab> may be the same, and I map <Tab> to za
map('n', '<C-n>', '<C-i>')
map({'n', 'v', 'o'}, 'j', function() return vim.v.count == 0 and 'gj' or 'j' end, { expr = true, })
map({'n', 'v', 'o'}, 'k', function() return vim.v.count == 0 and 'gk' or 'k' end, { expr = true, })
map({'n', 'v', 'o'}, 'gj', 'j')
map({'n', 'v', 'o'}, 'gk', 'k')
map({'n', 'v', 'o'}, 'gH', '0')
map({'n', 'v', 'o'}, 'gL', '$')
map({'n', 'v', 'o'}, 'H', 'g0')
map({'n', 'v', 'o'}, 'L', 'g$')

-- ======== 编 辑 (edit) ========
-- 类 Emacs 的 insert & commandline 模式
-- omni 和 tag 补全不需要 C-x 前缀
-- visual 模式下 gt 设为 Title Case

map({'i', 'c'}, '<c-l>', '<del>')

-- 补全
-- map('i', '<C-o>', '<C-x><C-o>')
map('i', '<C-]>', '<C-x><C-]>')
-- change to title case
map('v', 'gt', [[:keepp s/\v%V<lt>(.)(\w*)/\u\1\L\2/g<CR>]], { silent = true, })

-- ======== 查看 (view) ========
-- Tab 用来切换折叠

map('n', '<Tab>', 'za')

-- ======== 窗口 (window) ========
-- C-h/j/k/l 移动 focus
-- =-+_ (加减号及其 Shift) 调整窗口大小

map('n', '<c-h>', '<c-w>h')
-- 终端中, <C-H> 和 <BS> 可能是一个键码
map('n', '<BS>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '=', '<c-w>+')
map('n', '-', '<c-w>-')
map('n', '+', '<c-w>>')
map('n', '_', '<c-w><')

-- ======== esc 绑定 ========
-- jk

map('i', 'jk', '<esc>')
-- Maybe only use <C-\><C-n> is better in terminal mode
-- map('t', 'jk', '<c-\\><c-n>')

