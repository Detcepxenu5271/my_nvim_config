-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local dir = require("oil").get_current_dir(bufnr)
	if dir then
		return vim.fn.fnamemodify(dir, ":~")
	else
		-- If there is no current directory (e.g. over ssh), just show the buffer name
		return vim.api.nvim_buf_get_name(0)
	end
end

return {
	'stevearc/oil.nvim',
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,
		win_options = {
			number = false,
			relativenumber = false,
		},
		watch_for_changes = true,
		-- don't use winbar, show current directory by statusline
		--win_options = {
		--	winbar = "%!v:lua.get_oil_winbar()"
		--},
		keymaps = {
			["<LocalLeader>s"] = { "actions.select", opts = { horizontal = true } },
			["<LocalLeader>v"] = { "actions.select", opts = { vertical = true } },
			["<LocalLeader>t"] = { "actions.select", opts = { tab = true } },
			["<C-h>"] = false,
			["<C-l>"] = false,
			["<C-s>"] = false,
			["<C-t>"] = false
		},
	},
	-- Optional dependencies
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	--dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	--cmd = 'Oil'
}

