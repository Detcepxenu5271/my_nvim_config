---@brief
---
--- https://github.com/japhib/pico8-ls
---
--- Full language support for the PICO-8 dialect of Lua.

-- 原来的配置, 需要完整的 nvim-lspconfig 插件
--local util = require 'lspconfig.util'

return {
	cmd = { 'pico8-ls', '--stdio' },
	filetypes = { 'pico8' },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		-- 原来的配置, 需要完整的 nvim-lspconfig 插件
		--on_dir(util.root_pattern('*.p8')(fname))
		on_dir(vim.fs.dirname(fname))
	end,
	settings = {},
}
