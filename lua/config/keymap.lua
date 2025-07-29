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

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map('n', '<leader>', '<nop>')

map('n', '<leader>/', ":let @/='\\<'..input('Search word: ')..'\\>'<CR>")
map('n', '<leader>a', 'i<space><esc>la<space><esc>l')
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
map('n', '<leader>oc', ':setl cursorcolumn! cursorcolumn?<cr>')
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
map('n', '<leader>on', ':setl nu! rnu! nu?<cr>')
map('n', '<leader>ot', ':let &showtabline = 3-&showtabline | setl showtabline?<cr>')
map('n', '<leader>ow', ':setl wrap! wrap?<cr>')
map('n', '<leader>sv', ':source $MYVIMRC<cr>')
map('n', '<leader>w', '<c-w>')
map('v', '<leader>a', 'c<space><c-r>"<space><esc>')

-- ======== Insert 模式下的 "leader" ========

map('i', 'jl==', '<esc>vBdi<c-r>=<c-r>"<cr>')
map('i', 'jl=e', '<space><esc>yBEls=<c-r>=<c-r>0<cr>')

-- ======== 移 动 (motion) ========

map('c', '<c-a>', '<home>')
map('c', '<c-b>', '<left>')
map('c', '<c-f>', '<right>')
map('i', '<c-a>', '<home>')
map('i', '<c-b>', '<left>')
map('i', '<c-e>', '<end>')
map('i', '<c-f>', '<right>')
map('n', '<C-n>', '<C-i>')
map({'n', 'v', 'o'}, 'j', 'gj')
map({'n', 'v', 'o'}, 'k', 'gk')
map({'n', 'v', 'o'}, 'gj', 'j')
map({'n', 'v', 'o'}, 'gk', 'k')
map({'n', 'v', 'o'}, 'gH', '0')
map({'n', 'v', 'o'}, 'gL', '$')
map({'n', 'v', 'o'}, 'H', 'g0')
map({'n', 'v', 'o'}, 'L', 'g$')

-- ======== 编 辑 (edit) ========

map('c', '<c-l>', '<del>')
map('i', '<c-l>', '<del>')

-- 补全
map('i', '<C-o>', '<C-x><C-o>')

-- ======== 查看 (view) ========

map('n', '<Tab>', 'za')

-- ======== 窗口 (window) ========

map('n', '+', '<c-w>>')
map('n', '-', '<c-w>-')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '=', '<c-w>+')
map('n', '_', '<c-w><')

-- ======== esc 绑定 ========

map('i', 'jk', '<esc>')
map('t', 'jk', '<c-\\><c-n>')

