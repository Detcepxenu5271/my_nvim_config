-- dependencies: Nerd Font

-- 引入自定义颜色模块
local C = require('util.color')
-- 自定义高亮的简写
local hi = vim.api.nvim_set_hl

-- 在 init.lua 中添加：
vim.opt.showmode = false	-- 关闭默认提示

-- TODO 不应该用这种兼容写法, 因为之前已经 require 了 util.color
local white = C:getcolor('ql_white') or '#f5f5f5'
local black = C:getcolor('ql_black') or '#14161b'
local green = C:getcolor('ql_green') or '#448c27'
local purple = C:getcolor('ql_lightpurple') or '#c4b7d7'
local orange = C:getcolor('ql_orange') or '#d18a2e'
local red = C:getcolor('ql_red') or '#aa3731'
local blue = C:getcolor('ql_blue') or '#4b69c6'

-- 定义各模式高亮组
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

local function mode_echo()
	local m = vim.api.nvim_get_mode().mode
	if mode_info[m] then
		vim.api.nvim_echo(mode_info[m], false, {})
	end
end

-- 模式切换处理
vim.api.nvim_create_autocmd("ModeChanged", {
	callback = mode_echo
})
