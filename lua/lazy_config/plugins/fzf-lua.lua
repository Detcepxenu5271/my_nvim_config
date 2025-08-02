return {
	"ibhagwan/fzf-lua",

	event = "VeryLazy",

	-- optional for icon support
	--dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	dependencies = { "echasnovski/mini.icons" },

	-- ?这里的配置无效, 需要用 require("fzf-lua").setup { ... }
	--opts = { },

	config = function()
		local fzf_lua = require("fzf-lua")
		-- file
		vim.keymap.set('n', "<leader>f", '<nop>')
		vim.keymap.set('n', "<leader>ff", fzf_lua.files,
			{desc = "Find Files (PWD)"})
		-- config
		vim.keymap.set('n', "<leader>fc", function ()
			fzf_lua.files({ cwd = vim.fn.stdpath('config') })
		end, {desc = "Config Files"})
		-- orgfiles
		vim.keymap.set('n', "<leader>fof", function ()
			fzf_lua.files({ cwd = '~/orgfiles' })
		end, {desc = "Org Files"})
		vim.keymap.set('n', '<leader>foo', ':FzfLua live_grep search_paths=~/orgfiles<CR>\\*+ <C-g>',
			{desc = 'Org nOtes (Headlines)'})
		vim.keymap.set('n', '<leader>fog', function ()
			fzf_lua.live_grep({ search_paths = '~/orgfiles' })
		end, {desc = "Org grep"})
		-- buffer
		vim.keymap.set('n', "<leader>fb", fzf_lua.buffers,
			{desc = "Find Buffers"})
		-- grep
		vim.keymap.set('n', "<leader>fg", fzf_lua.live_grep,
			{desc = "Live Grep"})
		-- lsp
		vim.keymap.set('n', "<leader>fls", fzf_lua.lsp_document_symbols,
			{desc = "Lsp Document Symbols"})
		-- commands
		vim.keymap.set('n', "<leader>f:", fzf_lua.commands,
			{desc = "Commands"})
		-- history
		vim.keymap.set('n', "<leader>fh", '<nop>')
		vim.keymap.set('n', "<leader>fh:", fzf_lua.command_history,
			{desc = "History of Commands"})
		vim.keymap.set('n', "<leader>fh/", fzf_lua.command_history,
			{desc = "History of Search"})
		vim.keymap.set('n', "<leader>fhf", fzf_lua.oldfiles,
			{desc = "History of Files (Old Files)"})
		-- resume
		vim.keymap.set('n', '<leader>fr', fzf_lua.resume,
			{desc = "Resume"})
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

