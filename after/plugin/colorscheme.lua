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
		hi(0, 'EndOfBuffer', {fg = C:getcolor('ql_lightgrey'), bg = 'NONE'})
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
		-- @markup
		-- heading: 参考 nvim-orgmode 插件
		hi(0, '@markup.heading.1.markdown', {link = 'Title'})
		hi(0, '@markup.heading.2.markdown', {link = 'Constant'})
		hi(0, '@markup.heading.3.markdown', {link = 'Identifier'})
		hi(0, '@markup.heading.4.markdown', {link = 'Statement'})
		hi(0, '@markup.heading.5.markdown', {link = 'PreProc'})
		hi(0, '@markup.heading.6.markdown', {link = 'Type'})
		hi(0, '@markup.list', {link = 'Keyword'})
		-- quickfix
		hi(0, 'qfLineNr', {fg = C:getcolor('warning_yellow')})
		-- scratch buffer
		-- TODO 现在只是暂时设置
		hi(0, 'ScratchNormal', {bg = '#f7f3e6'})
		hi(0, 'ScratchEndOfBuffer', {bg = '#f7f3e6'})
	end
})

-- TODO 如果找不到, 使用 myshine
vim.opt.background = 'light'
vim.cmd('colorscheme quietlight')

