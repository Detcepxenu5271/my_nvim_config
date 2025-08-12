return {{
	"rainzm/flash-zh.nvim",
	event = "VeryLazy",
	dependencies = "folke/flash.nvim",
	keys = {{
		"f",
		mode = {"n", "x", "o"},
		function()
			require("flash-zh").jump({
				chinese_only = false
			})
		end,
		desc = "Flash between Chinese"
	}}
}, {
	"folke/flash.nvim",
	event = "VeryLazy",
	---@type Flash.Config
	opts = {
		highlight = {
			--backdrop = false,
			matches = false
		},
		modes = {
			char = {
				keys = { "t", "T", ";", "," },
			}
		}
	},
	-- stylua: ignore
	keys = {
		--{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
		{ "F", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	},
}}
