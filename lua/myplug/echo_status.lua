-- Dependences: util.color
-- BUG 切换 colorscheme 后, 有时会出现显示异常, 模式状态的颜色全变为黑白

-- 引入自定义颜色模块
local C = require('util.color')
-- 自定义高亮的简写
local hi = vim.api.nvim_set_hl

-- 在 init.lua 中添加:
vim.opt.showmode = false -- 关闭默认提示

local white = C:getcolor('ql_white')
local black = C:getcolor('ql_black')
local green = C:getcolor('ql_green')
local purple = C:getcolor('ql_lightpurple')
local orange = C:getcolor('ql_orange')
local red = C:getcolor('ql_red')
local blue = C:getcolor('ql_blue')

-- 定义各模式高亮组
vim.api.nvim_create_augroup('myplug_echo_status', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
	group = 'myplug_echo_status',
	callback = function()
		hi(0, "ModeNormal", { fg = white, bg = blue })
		hi(0, "ModeNormalRev", { reverse = true, fg = white, bg = blue })
		hi(0, "ModeInsert", { fg = white, bg = green })
		hi(0, "ModeInsertRev", { reverse = true, fg = white, bg = green })
		hi(0, "ModeVisual", { fg = white, bg = orange })
		hi(0, "ModeVisualRev", { reverse = true, fg = white, bg = orange })
		hi(0, "ModeReplace", { fg = white, bg = red })
		hi(0, "ModeReplaceRev", { reverse = true, fg = white, bg = red })
		hi(0, "ModeOperatorPending", { fg = white, bg = purple })
		hi(0, "ModeOperatorPendingRev", { reverse = true, fg = white, bg = purple })
		hi(0, "ModeTerminal", { fg = white, bg = black })
		hi(0, "ModeTerminalRev", { reverse = true, fg = white, bg = black })
	end
})

-- 模式输出信息, 用于作为 nvim_echo 的参数
local mode_info = {
	n = {
		{ " NORMAL ", "ModeNormal" },
		{ "", "ModeNormalRev" },
	},
	i = {
		{ " INSERT ", "ModeInsert" },
		{ "", "ModeInsertRev" },
	},
	v = {
		{ " VISUAL ", "ModeVisual" },
		{ "", "ModeVisualRev" },
	},
	V = {
		{ " V-LINE ", "ModeVisual" },
		{ "", "ModeVisualRev" },
	},
	[''] = {
		{ " V-BLOCK ", "ModeVisual" },
		{ "", "ModeVisualRev" },
	},
	R = {
		{ " REPLACE ", "ModeReplace" },
		{ "", "ModeReplaceRev" },
	},
	no = {
		{ " OPENDING ", "ModeOperatorPending" },
		{ "", "ModeOperatorPendingRev" },
	},
	t = {
		{ " TERM ", "ModeTerminal" },
		{ "", "ModeTerminalRev" },
	},
}

local function echo_status()
	local content = {}
	local m = vim.api.nvim_get_mode().mode
	-- 跳过没有处理的 mode
	-- (修复 bug: 按 ':' 进入 Command-line 模式时, 没有显示 ':' 符号)
	if mode_info[m] == nil then
		return
	end
	for _, v in pairs(mode_info[m]) do
		table.insert(content, v)
	end
	if vim.bo.filetype == 'org' and package.loaded['orgmode'] then
		table.insert(content, { orgmode.statusline(), "Normal" })
	end
	vim.api.nvim_echo(content, false, {})
end

-- 模式切换处理
vim.api.nvim_create_autocmd("ModeChanged", {
	callback = echo_status
})

