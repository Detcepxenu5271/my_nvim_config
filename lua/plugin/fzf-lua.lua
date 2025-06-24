return {
	"ibhagwan/fzf-lua",
	enabled = false,

	event = "VeryLazy",

	-- optional for icon support
	--dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	dependencies = { "echasnovski/mini.icons" },

	-- ?这里的配置无效, 需要用 require("fzf-lua").setup { ... }
	--opts = { },

	config = function()
		local fzf_lua = require("fzf-lua")
		vim.keymap.set('n', "<leader>f", '<nop>')
		vim.keymap.set('n', "<leader>ff", fzf_lua.files, {desc = "Find Files"})
		vim.keymap.set('n', "<leader>fb", fzf_lua.buffers, {desc = "Find Buffers"})
		vim.keymap.set('n', "<leader>fl", fzf_lua.live_grep, {desc = "Live Grep"})
		vim.keymap.set('n', "<leader>f:", fzf_lua.commands, {desc = "Commands"})
		vim.keymap.set('n', "<leader>fh", fzf_lua.command_history, {desc = "History of Commands"})
		vim.keymap.set('n', "<leader>fo", fzf_lua.oldfiles, {desc = "Old Files"})
		vim.keymap.set('n', "<leader>fc", function ()
			fzf_lua.files({ cwd = "~/.config/nvim" })
		end, {desc = "Config Files"})
		vim.keymap.set('n', '<leader>fr', fzf_lua.resume, {desc = "Resume"})
		fzf_lua.setup({
			-- 使用该配置时, fzf窗口立刻闪退
			--"hide",
			keymap = {
				builtin = {
					true,
					["<C-H>"] = "hide",
					["<C-K>"] = "toggle-preview",
					["<C-F>"] = "preview-page-down",
					["<C-B>"] = "preview-page-up",
				},
				fzf = {
					true,
					["ctrl-k"] = "toggle-preview",
					["ctrl-f"] = "preview-page-down",
					["ctrl-b"] = "preview-page-up",
				}
			}
		})
	end
}
