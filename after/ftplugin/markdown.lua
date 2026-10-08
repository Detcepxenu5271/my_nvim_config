-- code block's conceal will make it invisible when folded
-- but without conceal, the image/math rendering will overlap with source code
vim.opt_local.conceallevel = 2

vim.keymap.set('n', '<LocalLeader>b', 'viWv`>a**<Esc>`<i**<Esc>', {buffer = true})
vim.keymap.set('n', '<LocalLeader>i', 'viWv`>a*<Esc>`<i*<Esc>', {buffer = true})
vim.keymap.set('n', '<LocalLeader>s', 'viWv`>a~~<Esc>`<i~~<Esc>', {buffer = true})

vim.keymap.set('v', '<LocalLeader>b', 'v`>a**<Esc>`<i**<Esc>', {buffer = true})
vim.keymap.set('v', '<LocalLeader>i', 'v`>a*<Esc>`<i*<Esc>', {buffer = true})
vim.keymap.set('v', '<LocalLeader>s', 'v`>a~~<Esc>`<i~~<Esc>', {buffer = true})
vim.keymap.set('v', '<LocalLeader>c', 'v`>a`<Esc>`<i`<Esc>', {buffer = true})
vim.keymap.set('v', '<LocalLeader>m', 'v`>a$<Esc>`<i$<Esc>', {buffer = true})

vim.keymap.set('i', 'jlc', '``<Left>', {buffer = true})
vim.keymap.set('i', 'jlm', '$$<Left>', {buffer = true})

if vim.treesitter.language.add('markdown') then
	vim.treesitter.start(0, 'markdown')
	vim.opt_local.foldmethod = 'expr'
	vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
	vim.opt_local.foldlevel = 1
	-- 会导致 list 没有缩进
	-- vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end
