return {
	"HUAHUAI23/nvim-quietlight",
	lazy = false,
	priority = 1000,
	pin = true, -- 修改过 palette, 不更新插件
	            -- 修改为:
				-- (暂时保留) gui.red._50: #aa3731 -> #c4453f
				-- gui.orange._0: #ab6526 -> #d18a2e
	config = function()
		-- nvim-quietlight 推荐的设置
		vim.cmd("highlight clear ColorColumn")
		require("nvim-quietlight").setup({
			ansi_terminal_colors = "colors1",  -- "colors1", "color2" or "colors3"
		})
	end
}
