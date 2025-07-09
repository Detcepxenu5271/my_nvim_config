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
		-- if use other file explorer, false this and set lazy = true
		default_file_explorer = true,
		-- default false
		watch_for_changes = true,
		buf_options = {
			buflisted = false,
			bufhidden = "hide"
		},
		win_options = {
			winbar = "%!v:lua.get_oil_winbar()"
		},
		keymaps = {
			["<LocalLeader>s"] = { "actions.select", opts = { horizontal = true } },
			["<LocalLeader>v"] = { "actions.select", opts = { vertical = true } },
			["<C-h>"] = false,
			["<C-l>"] = false,
		},
		preview_win = {
			update_on_cursor_moved = false,
			preview_method = "load",
			win_options = {
				-- unlist buffer but not wipe, so reopen will use the same bufnr
				bufhidden = "delete"
			}
		}
	},
	-- Optional dependencies
	dependencies = {
		{ "echasnovski/mini.icons", opts = {} }
	},
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	--cmd = 'Oil'
}
