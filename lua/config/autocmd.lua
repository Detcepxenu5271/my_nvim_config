vim.api.nvim_create_augroup('my_autocmd', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
	group = 'my_autocmd',
	pattern = '*',
	callback = function()
		vim.hl.on_yank {higroup='Visual', timeout=500}
	end,
	desc = 'highlight on yank'
	-- TODO "silent!" not implemented
	--      AI recommend use pcall
})

vim.api.nvim_create_autocmd('InsertEnter', {
	group = 'my_autocmd',
	pattern = '*',
	callback = function()
		if vim.wo.number then
			vim.opt_local.relativenumber = false
		end
	end,
	desc = 'use norelativenumber in insert mode'
})

vim.api.nvim_create_autocmd('InsertLeave', {
	group = 'my_autocmd',
	pattern = '*',
	callback = function()
		if vim.wo.number then
			vim.opt_local.relativenumber = true
		end
	end,
	desc = 'use relativenumber in normal mode'
})

