---@brief
---
--- https://github.com/japhib/pico8-ls
---
--- Full language support for the PICO-8 dialect of Lua.

local util = require 'lspconfig.util'

-- DIRTY
-- filetypes in return can't override, so set by this:
--vim.lsp.config('pico8_ls', {
--	cmd = {},
--	filetypes = { 'pico8' },
--})

-- DIRTY
local pico8_ls_cmd
if vim.fn.has('win32') and string.find(vim.o.shell, 'bash') then
	pico8_ls_cmd = {'node', 'C:/msys64/home/22961/software/pico8-ls/server/out/server.js', '--stdio'}
else
	pico8_ls_cmd = {'pico8-ls', '--stdio'}
end

return {
	cmd = pico8_ls_cmd,
	-- cmd = { 'pico8-ls', '--stdio' },
	filetypes = { 'pico8' },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(util.root_pattern('*.p8')(fname))
	end,
	settings = {},
}
