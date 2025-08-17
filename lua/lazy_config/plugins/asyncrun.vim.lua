return {
	'skywind3000/asyncrun.vim',
	lazy = true,
	cmd = 'AsyncRun',
	config = function()
		-- use util.notify to exit
		--vim.g.asyncrun_exit = "lua require'util.notify'.flash_notify('AsyncRun Finished')"

		vim.api.nvim_create_augroup('plugin_asyncrun', { clear = true })
		vim.api.nvim_create_autocmd('User', {
			group = 'my_autocmd',
			pattern = 'AsyncRunStop',
			callback = function()
				if vim.g.asyncrun_status == 'success' then
					require('util.notify').flash_notify('AsyncRun Success', vim.log.levels.INFO)
				elseif vim.g.asyncrun_status == 'failure' then
					require('util.notify').flash_notify('AsyncRun Fail!', vim.log.levels.ERROR)
				end
			end,
		})
	end
}
