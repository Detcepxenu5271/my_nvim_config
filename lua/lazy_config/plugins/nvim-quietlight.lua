return {
	"HUAHUAI23/nvim-quietlight",
	enabled = true,
	lazy = false,
	priority = 1000,
	config = function()
		-- nvim-quietlight 推荐的设置
		--vim.cmd("highlight clear ColorColumn")
		require("nvim-quietlight").setup({
			ansi_terminal_colors = "colors1",  -- "colors1", "color2" or "colors3"
			syntax = {
				-- 红色还有 Exception 和 @type.builtin, 在 after/plugin/colorscheme.lua 设置
				constants = { fg = '#d18a2e' }, -- 更鲜艳的橙色
				numbers = { fg = '#d18a2e' },
				functions = { fg = '#c4453f' }, -- 更鲜艳的红色
				conditionals = { bold = true, italic = true, fg = '#006633' }, -- 深绿色+粗斜体 (原 gray_180, 和文本的黑色几乎一样)
			}
		})
		-- set term color manually
		-- TODO 还不够 (绿色背景蓝色字会看不见)
		vim.g['terminal_color_0'] = '#f5f5f5'
		vim.g['terminal_color_1'] = '#c43e3a'
		vim.g['terminal_color_2'] = '#3a8b4a'
		vim.g['terminal_color_3'] = '#c68a32'
		vim.g['terminal_color_4'] = '#3a7bc8'
		vim.g['terminal_color_5'] = '#8a4eb3'
		vim.g['terminal_color_6'] = '#00b4a0'
		vim.g['terminal_color_7'] = '#a8a19f'
		vim.g['terminal_color_8'] = '#999999'
		vim.g['terminal_color_9'] = '#e74c3c'
		vim.g['terminal_color_10'] = '#2ecc71'
		vim.g['terminal_color_11'] = '#f39c12'
		vim.g['terminal_color_12'] = '#3498db'
		vim.g['terminal_color_13'] = '#9b59b6'
		vim.g['terminal_color_14'] = '#1abc9c'
		vim.g['terminal_color_15'] = '#ffffff'
	end
}
