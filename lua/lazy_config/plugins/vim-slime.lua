return {
	'jpalardy/vim-slime',
	config = function(_, opts)
		vim.g.slime_target = "neovim"
		vim.g.slime_menu_config = true
		vim.g.slime_neovim_menu_order = {
			{ term_title = "Process: " },
			{ jobid = "Job ID: " },
			{ name = "Buffer: " },
		}

		-- 不设置的话, 缩进会乱, 导致报错
		vim.g.slime_python_ipython = 1

		-- ======== vim style mappings ========
		vim.g.slime_no_mappings = 1
		vim.keymap.set('x', '<Leader>s', '<Plug>SlimeRegionSend')
		vim.keymap.set('n', '<Leader>s', '<Plug>SlimeMotionSend')
		vim.keymap.set('n', '<Leader>ss', '<Plug>SlimeLineSend')
		vim.keymap.set('n', '<Leader>sf', '%SlimeSend<CR>', {silent = true})
	end
}
