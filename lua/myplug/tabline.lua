-- ======== Tabline with Mode Status ========

-- 引入自定义颜色模块
local C = require('util.color')
-- 自定义高亮的简写
local hi = vim.api.nvim_set_hl

local white = C:getcolor('ql_white')
local lightgray = C:getcolor('ql_lightgray')
local black = C:getcolor('ql_black')
local green = C:getcolor('ql_green')
local purple = C:getcolor('ql_lightpurple')
local orange = C:getcolor('ql_orange')
local brighter_orange = C:getcolor('ql_brighter_orange')
local red = C:getcolor('ql_red')
local blue = C:getcolor('ql_blue')

-- 定义各模式高亮组
vim.api.nvim_create_augroup('myplug_tabline', { clear = true })

vim.api.nvim_create_autocmd('ColorScheme', {
	group = 'myplug_tabline',
	callback = function()
		hi(0, "ModeNormal", { fg = lightgray, bg = blue })
		hi(0, "ModeNormalRev", { reverse = true, fg = lightgray, bg = blue })
		hi(0, "ModeInsert", { fg = lightgray, bg = green })
		hi(0, "ModeInsertRev", { reverse = true, fg = lightgray, bg = green })
		hi(0, "ModeVisual", { fg = lightgray, bg = orange })
		hi(0, "ModeVisualRev", { reverse = true, fg = lightgray, bg = orange })
		hi(0, "ModeCmdline", { fg = lightgray, bg = brighter_orange })
		hi(0, "ModeCmdlineRev", { reverse = true, fg = lightgray, bg = brighter_orange })
		hi(0, "ModeReplace", { fg = lightgray, bg = red })
		hi(0, "ModeReplaceRev", { reverse = true, fg = lightgray, bg = red })
		hi(0, "ModeOperatorPending", { fg = lightgray, bg = purple })
		hi(0, "ModeOperatorPendingRev", { reverse = true, fg = lightgray, bg = purple })
		hi(0, "ModeTerminal", { fg = lightgray, bg = black })
		hi(0, "ModeTerminalRev", { reverse = true, fg = lightgray, bg = black })
	end
})

-- direct string used for statusline format
local mode_info_str = {
	n = "%#ModeNormal# NOM %#ModeNormalRev#",
	i = "%#ModeInsert# INS %#ModeInsertRev#",
	v = "%#ModeVisual# VIS %#ModeVisualRev#",
	V = "%#ModeVisual# V-L %#ModeVisualRev#",
	[''] = "%#ModeVisual# V-B %#ModeVisualRev#",
	c = "%#ModeCmdline# CMD %#ModeCmdlineRev#",
	R = "%#ModeReplace# RPL %#ModeReplaceRev#",
	Rv = "%#ModeVirtualReplace# R-V %#ModeReplaceRev#",
	no = "%#ModeOperatorPending# OPD %#ModeOperatorPendingRev#",
	t = "%#ModeTerminal# TER %#ModeTerminalRev#",
	nt = "%#ModeNormal# TNO %#ModeNormalRev#",
}

-- ======== Tabline ========
-- TODO tab 显示不下的解决方案 (目前是右对齐, 左截断, 且不管当前 tab 位置)

local function tab_has_modified_buffers(tabnr)
	local tabinfo = vim.fn.gettabinfo(tabnr)
	if vim.tbl_isempty(tabinfo) then
		return false
	end
	for _, winid in ipairs(tabinfo[1].windows) do
		local bufnr = vim.fn.winbufnr(winid)
		if vim.bo[bufnr].modified then
			return true
		end
	end
	return false
end

local tab_names = {}

function _G.my_tabline()
	-- AI suggest use table rather than string
	local s = {}
	local current_tab = vim.fn.tabpagenr()
	-- for each tabpage
	for i = 1, vim.fn.tabpagenr('$') do
		-- ==== 0. Init For Highlight ====
		-- select the highlighting
		local tab_hi, tabnr_hi
		if i == current_tab then
			tab_hi = '%#TabLineSel#'
			-- TODO 为数字单独设置高亮
			tabnr_hi = '%#TabLineSel#'
		else
			tab_hi = '%#TabLine#'
			-- TODO 为数字单独设置高亮
			tabnr_hi = '%#TabLine#'
		end

		-- set the tab page number (for mouse clicks)
		table.insert(s, '%'..i..'T')

		local buflist = vim.fn.tabpagebuflist(i)
		local winnr = vim.fn.tabpagewinnr(i)

		-- begin seperator
		table.insert(s, tab_hi..' ')

		-- ==== 1. Tabpage Number ====
		table.insert(s, tabnr_hi..'['..i)
		if tab_has_modified_buffers(i) then
			table.insert(s, '+')
		end
		table.insert(s, ']')

		-- ==== 2. Tabpage Name ====
		-- highlight
		table.insert(s, tab_hi..' ')
		-- name
		if tab_names[i] == nil then
			-- current working director y
			local cwd = vim.fn.fnamemodify(vim.fn.getcwd(-1, i), ':t')
			table.insert(s, cwd..'/')
		else
			table.insert(s, tab_names[i])
		end
		-- number of buffers
		if #buflist > 1 then
			table.insert(s, '('..#buflist..')')
		end

		-- end seperator
		table.insert(s, ' ')
	end
	-- after last tab fill with TabLineFill
	table.insert(s, '%#TabLineFill#%T')
	-- right-align
	table.insert(s, '%=')
	-- mode status
	-- XXX The change of mode status will cause bad performance when repeating batch commands (e.g. :norm)
	-- table.insert(s, mode_info_str[vim.api.nvim_get_mode().mode])
	-- close tab label
	if vim.fn.tabpagenr('$') > 1 then
		table.insert(s, '%#TabLine#%999XX')
	end

	return table.concat(s)
end

-- @desc 为当前 tabpage 指定名字 (自定义)
-- @bang 清空所有 tabpage 的名字
-- @args 为空字符串时清空名字 (回到默认: 所在目录名)
--       不为空时表示要设置的名字
vim.api.nvim_create_user_command('TabpageNameSet', function(opts)
	-- vim.notify(vim.inspect(opts), vim.log.levels.INFO)
	local i = vim.fn.tabpagenr()
	if opts.bang == true then
		tab_names = {}
	else
		if opts.args == "" then
			tab_names[i] = nil
		else
			tab_names[i] = opts.args
		end
	end
end, {
	desc = 'Set name of current tabpage',
	bang = true,
	nargs = '?',
})

vim.opt.tabline = '%!v:lua.my_tabline()'

-- force redraw when mode changed
-- XXX The change of mode status will cause bad performance when repeating batch commands (e.g. :norm)
-- vim.api.nvim_create_autocmd('ModeChanged', {
-- 	group = 'myplug_tabline',
-- 	callback = function()
-- 		vim.cmd('redrawtabline')
-- 	end
-- })
