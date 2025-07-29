vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.HINT] = '󰌵',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.WARN] = '',
		}
	}
})

-- use gKgK to go into the float window
vim.keymap.set('n', 'gK', function()
	vim.diagnostic.open_float()
end, { desc = 'Toggle diagnostic float' })

vim.api.nvim_create_user_command('DiagnosticsToggle', function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

