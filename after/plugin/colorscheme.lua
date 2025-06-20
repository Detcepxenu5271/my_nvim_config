-- 引入自定义颜色模块
local C = require('util.color')
-- 自定义高亮的简写
local hi = vim.api.nvim_set_hl

-- ======== colorscheme ========

vim.api.nvim_create_autocmd('ColorScheme', {
	pattern = 'quietlight',
	callback = function()
		-- 搜索
		hi(0, 'Search', {fg = C:getcolor('ql_black'), bg = C:getcolor('highlight_yellow')})
		hi(0, 'Substitute', {link = 'Search'})
		-- 各种状态栏
		-- TODO Diagnostic 能否结合 link
		hi(0, 'LineNr', {fg = C:getcolor('ql_black'), bg = C:getcolor('ql_verylightgrey')})
		hi(0, 'SignColumn', {bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignError', {bold = true, fg = '#cc0000', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignWarn', {bold = true, fg = '#ca7682', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignInfo', {bold = true, fg = '#448c27', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignHint', {bold = true, fg = '#a1a8b1', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'DiagnosticSignOk', {bold = true, fg = 'NvimDarkGreen', bg = C:getcolor('ql_lightgrey')})
		hi(0, 'TabLineSel', {bold = true, fg = C:getcolor('ql_black'), bg = C:getcolor('ql_lightpurple')})
		hi(0, 'TabLineFill', {bg = C:getcolor('ql_lightgrey')})
		-- 光标
		-- TODO Visual 的 #a1a8b1 颜色
		hi(0, 'CursorLineNr', {fg = C:getcolor('ql_white'), bg = C:getcolor('ql_green')})
		hi(0, 'Visual', {fg = C:getcolor('ql_white'), bg = '#a1a8b1'})
		--hi(0, 'VisualNOS', {link = 'CursorLine'})
		-- 折叠
		hi(0, 'Folded', {bg = C:getcolor('folded_green')})
		-- 浮动窗口
		hi(0, 'NormalFloat', {fg = C:getcolor('ql_black'), bg = C:getcolor('ql_lightgrey')})
		hi(0, 'Pmenu', {link = 'NormalFloat'})
		hi(0, 'PmenuMatch', {bold = true, fg = C:getcolor('ql_red')})
		--hi(0, 'PmenuMatchSel', {bg = C:getcolor('ql_lightgrey')})
		hi(0, 'PmenuMatchSel', {bg = C:getcolor('ql_lightgrey')})
		-- 错误, 警告
		hi(0, 'WarningMsg', {fg = C:getcolor('warning_yellow')})
		-- LSP
		-- 浅绿: #c1f5b0 (原来设为 fg 的颜色)
		hi(0, 'LspReferenceRead', {bg = C:getcolor('ql_lightpurple')})
		hi(0, 'LspReferenceText', {bg = C:getcolor('ql_lightpurple')})
		hi(0, 'LspReferenceWrite', {bg = C:getcolor('ql_lightpurple')})
		-- quickfix
		hi(0, 'qfLineNr', {fg = C:getcolor('warning_yellow')})
	end
})

vim.opt.background = 'light'
vim.cmd('colorscheme quietlight')

