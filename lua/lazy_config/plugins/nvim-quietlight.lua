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
	end
}
