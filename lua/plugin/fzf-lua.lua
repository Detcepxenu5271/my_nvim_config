return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	--dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	-- dependencies = { "echasnovski/mini.icons" },

	-- lazy loading
	lazy = true,
	cmd = 'FzfLua',
	keys = {
		{ "<leader>ff", function() require("fzf-lua").files() end, desc = "Find Files" },
		{ "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Find Buffers" },
		{ "<leader>fl", function() require("fzf-lua").live_grep() end, desc = "Live Grep" },
		{ "<leader>f:", function() require("fzf-lua").commands() end, desc = "Commands" },
		{ "<leader>fh", function() require("fzf-lua").command_history() end, desc = "History" },
		{ "<leader>fo", function() require("fzf-lua").oldfiles() end, desc = "Old Files" },
		{ "<leader>fc", function() require("fzf-lua").files({ cwd = "~/.config/nvim" }) end, desc = "Config Files" },
	},

	opts = {},
	config = function()
		--local fl = require('fzf-lua')
		--vim.keymap.set('n', '<leader>ff', fl.files)
		--vim.keymap.set('n', '<leader>fb', fl.buffers)
		--vim.keymap.set('n', '<leader>fl', fl.live_grep)
		--vim.keymap.set('n', '<leader>f:', fl.commands)
		--vim.keymap.set('n', '<leader>fh', fl.command_history)
		--vim.keymap.set('n', '<leader>fo', fl.oldfiles)
		--vim.keymap.set('n', '<leader>fc', function () fl.files({cwd = '~/.config/nvim'}) end)
	end
}
