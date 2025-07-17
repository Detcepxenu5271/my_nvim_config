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

