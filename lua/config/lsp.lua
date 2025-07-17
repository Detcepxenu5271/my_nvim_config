vim.api.nvim_create_augroup('my_lsp_attach', {clear = true})

vim.api.nvim_create_autocmd('LspAttach', {
	group = 'my_lsp_attach',
	callback = function (event)
		vim.keymap.set('n', 'grd', vim.lsp.buf.definition, {buffer = true})
		vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, {buffer = true})
	end
})

