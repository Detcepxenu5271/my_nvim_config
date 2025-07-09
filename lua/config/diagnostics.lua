-- to display diagnostics manually:
-- :lua vim.diagnostic.open_float()
-- :lua vim.diagnostic.setloclist()
-- fuzzy finder plugin usually can search diagnostics as well

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

-- open float to show diagnostics
vim.keymap.set('n', 'gK', function()
	vim.diagnostic.open_float()
end, { desc = 'Toggle diagnostic float' })

-- toggle virtual_lines to show diagnostics
vim.api.nvim_create_user_command('DiagnosticsToggle', function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })
