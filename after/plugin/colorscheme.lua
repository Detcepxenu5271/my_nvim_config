-- TODO 做成自定义配色方案

-- 引入自定义颜色模块
local C = require('util.color')
-- 自定义高亮的简写
local hi = vim.api.nvim_set_hl

-- ======== colorscheme ========

-- custom to nvim-quietlight
vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = 'quietlight',
	callback = function()
		-- 基本
		hi(0, 'NormalNC', {bg = '#e8e8e8'})
		hi(0, 'EndOfBuffer', {fg = C:getcolor('ql_lightgrey'), bg = 'NONE'})
		hi(0, 'NonText', {fg = '#e4e4fc'})
		-- 浮动窗口
		hi(0, 'NormalFloat', {fg = C:getcolor('ql_black'), bg = C:getcolor('ql_lightgrey')})
		hi(0, 'Pmenu', {link = 'NormalFloat'})
		hi(0, 'PmenuSel', {fg = C:getcolor('ql_black'), bg = C:getcolor('ql_lightpurple')})
		hi(0, 'PmenuMatch', {bold = true, fg = C:getcolor('ql_red')})
		--hi(0, 'PmenuMatchSel', {bg = C:getcolor('ql_lightgrey')})
		-- 各种状态栏
		-- TODO Diagnostic 能否结合 link
		hi(0, 'LineNr', {fg = C:getcolor('ql_black'), bg = C:getcolor('ql_verylightgrey')})
		hi(0, 'SignColumn', {bg = C:getcolor('ql_lightgrey')})
		hi(0, 'TabLineSel', {bold = true, fg = C:getcolor('ql_black'), bg = C:getcolor('ql_lightpurple')})
		hi(0, 'TabLineFill', {bg = C:getcolor('ql_lightgrey')})
		-- 光标
		-- TODO Visual 的 #a1a8b1 颜色
		hi(0, 'CursorLineNr', {fg = C:getcolor('ql_white'), bg = C:getcolor('ql_green')})
		hi(0, 'Visual', {fg = C:getcolor('ql_white'), bg = '#a1a8b1'})
		--hi(0, 'VisualNOS', {link = 'CursorLine'})
		-- 搜索
		hi(0, 'Search', {fg = C:getcolor('ql_black'), bg = C:getcolor('highlight_yellow')})
		hi(0, 'Substitute', {link = 'Search'})
		-- Diagnostic
		hi(0, 'DiagnosticError', {bold = true, fg = '#cc0000', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticWarn', {bold = true, fg = '#ca7602', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticInfo', {bold = true, fg = '#448c27', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticHint', {bold = true, fg = '#a1a8b1', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticOk', {bold = true, fg = 'NvimDarkGreen', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignError', {bold = true, fg = '#cc0000', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignWarn', {bold = true, fg = '#ca7602', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignInfo', {bold = true, fg = '#448c27', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignHint', {bold = true, fg = '#a1a8b1', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignOk', {bold = true, fg = 'NvimDarkGreen', bg = C:getcolor('ql_lightgrey')})
		-- 折叠
		hi(0, 'Folded', {bg = C:getcolor('folded_green')})
		-- diff
		-- hi(0, 'DiffAdd', {fg = C:getcolor('ql_white'), bg = C:getcolor('ql_green')})
		-- hi(0, 'DiffDelete', {fg = C:getcolor('ql_white'), bg = C:getcolor('ql_red')})
		-- hi(0, 'DiffChange', {fg = C:getcolor('ql_white'), bg = C:getcolor('ql_purple')})
		-- hi(0, 'DiffText', {fg = C:getcolor('ql_black'), bg = C:getcolor('highlight_yellow')})
		hi(0, 'DiffAdd', {fg = C:getcolor('ql_black'), bg = '#c7efcc'})
		hi(0, 'DiffDelete', {fg = C:getcolor('ql_black'), bg = '#ffc1c2'})
		hi(0, 'DiffChange', {fg = C:getcolor('ql_black'), bg = '#c1ebff'})
		hi(0, 'DiffText', {fg = C:getcolor('ql_black'), bg = '#ffa300'})
		-- 编程语言
		hi(0, 'Exception', {fg = C:getcolor('ql_brighter_red')})
		hi(0, '@type.builtin', {fg = C:getcolor('ql_brighter_red')})
		hi(0, '@parameter', {fg = C:getcolor('ql_orange')}) -- 被 @property.json link
		-- 错误, 警告
		hi(0, 'WarningMsg', {fg = C:getcolor('warning_yellow')})
		-- LSP
		-- Signature 对当前参数的高亮, 改为更显眼的红色
		hi(0, 'LspReferenceRead', {bg = C:getcolor('ql_lightpurple')})
		hi(0, 'LspReferenceText', {bg = C:getcolor('ql_lightpurple')})
		hi(0, 'LspReferenceWrite', {bg = C:getcolor('ql_lightpurple')})
		hi(0, 'LspSignatureActiveParameter', {bg = C:getcolor('ql_lightpurple')})
		-- BUG 如果不加, 切换 colorscheme 时, 这个会被设成 NvimLightGrey2
		hi(0, '@variable', {fg = 'NvimDarkGrey2'})
		-- @markup
		-- heading: 参考 nvim-orgmode 插件
		hi(0, '@markup.heading.1.markdown', {link = 'Title'})
		hi(0, '@markup.heading.2.markdown', {link = 'Constant'})
		hi(0, '@markup.heading.3.markdown', {link = 'Identifier'})
		hi(0, '@markup.heading.4.markdown', {link = 'Statement'})
		hi(0, '@markup.heading.5.markdown', {link = 'PreProc'})
		hi(0, '@markup.heading.6.markdown', {link = 'Type'})
		hi(0, '@markup.list', {link = 'Keyword'})
		hi(0, '@markup.list.unchecked', {link = 'Function'})
		hi(0, '@markup.list.checked', {link = 'Comment'})
		-- quickfix
		hi(0, 'qfLineNr', {fg = C:getcolor('warning_yellow')})
		-- scratch buffer
		hi(0, 'ScratchNormal', {bg = C:getcolor('scratch_backgound_yellow')})
		hi(0, 'ScratchEndOfBuffer', {fg = C:getcolor('ql_lightgrey'), bg = C:getcolor('scratch_backgound_yellow')})
		-- [package] termdebug
		hi(0, 'debugBreakpoint', {bg = C:getcolor('pico8_8')})
		-- [plugin] flash.nvim
		hi(0, 'FlashLabel', {fg = C:getcolor('pico8_7'), bg = C:getcolor('pico8_14')})
		-- [dirty]
		-- clear TermCursor, because when entering builtin-terminal, the outside cursor color will be changed
		hi(0, 'TermCursor', {})
	end
})

local colorscheme_fallback = {
	{'quietlight', 'light'},
	{'myshine', 'light'},
	{'shine', 'light'},
	{'default', 'light'},
}
for _, item in ipairs(colorscheme_fallback) do
	local scheme = item[1]
	local bg = item[2]
	if pcall(vim.cmd.colorscheme, scheme) then
		vim.o.background = bg
		break
	end
end

--vim.cmd('colorscheme quietlight')
--vim.o.background = 'light'

-- set terminal color
if vim.o.background == 'light' then
	-- Catppuccin Latte
	vim.g.terminal_color_0 = "#5C5F77"   -- black
	vim.g.terminal_color_8 = "#6C6F85"   -- brightBlack

	vim.g.terminal_color_1 = "#D20F39"   -- red
	vim.g.terminal_color_9 = "#D20F39"   -- brightRed

	vim.g.terminal_color_2 = "#40A02B"   -- green
	vim.g.terminal_color_10 = "#40A02B"  -- brightGreen

	vim.g.terminal_color_3 = "#DF8E1D"   -- yellow
	vim.g.terminal_color_11 = "#DF8E1D"  -- brightYellow

	vim.g.terminal_color_4 = "#1E66F5"   -- blue
	vim.g.terminal_color_12 = "#1E66F5"  -- brightBlue

	vim.g.terminal_color_5 = "#EA76CB"   -- purple
	vim.g.terminal_color_13 = "#EA76CB"   -- brightPurple

	vim.g.terminal_color_6 = "#179299"   -- cyan
	vim.g.terminal_color_14 = "#179299"  -- brightCyan

	vim.g.terminal_color_7 = "#ACB0BE"   -- white
	vim.g.terminal_color_15 = "#BCC0CC"  -- brightWhite
end
