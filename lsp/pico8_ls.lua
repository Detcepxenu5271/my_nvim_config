---@brief
---
--- https://github.com/japhib/pico8-ls
---
--- Full language support for the PICO-8 dialect of Lua.

local util = require 'lspconfig.util'

-- DIRTY
-- filetypes in return can't override, so set by this:
vim.lsp.config('pico8_ls', {
	filetypes = { 'pico8' }
})

--return {
--  cmd = { 'pico8-ls', '--stdio' },
--  filetypes = { 'pico8' },
--  root_dir = function(bufnr, on_dir)
--    local fname = vim.api.nvim_buf_get_name(bufnr)
--    on_dir(util.root_pattern('*.p8')(fname))
--  end,
--}
