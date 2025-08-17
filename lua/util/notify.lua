local M = {}

-- set up highlight
-- TODO better way to deal with highlight
vim.api.nvim_set_hl(0, 'NotifyINFOBg', { fg = '#14161B', bg = '#ddebf7' })
vim.api.nvim_set_hl(0, 'NotifyERRORBg', { fg = '#14161B', bg = '#ffccff' })

function M.get_persistent_bufnr()
	if M.persistent_bufnr then
		-- vim.api.nvim_buf_set_lines(M.persistent_bufnr, 0, -1, false, {})
		return M.persistent_bufnr
	else
		M.persistent_bufnr = vim.api.nvim_create_buf(false, true)
		return M.persistent_bufnr
	end
end

--- @param msg string 要显示的消息
--- @param level? integer 消息层级, 默认 vim.log.levels.INFO
--- @param duration? integer 持续时间, 单位毫秒 (ms), 默认 3000
--- TODO 支持一直显示, 通过特定按键关闭
--- TODO 可选显示位置
--- TODO 可选消息类型 (使用不同颜色等)
function M.flash_notify(msg, level, duration)
	level = level or vim.log.levels.INFO
	duration = duration or 3000
	local buf = M.get_persistent_bufnr()
	-- TODO 根据整个屏幕的宽度计算
	local width = math.min(50, #msg + 4)
	local win = vim.api.nvim_open_win(buf, false, {
		relative = 'editor',
		width = width,
		height = 1,
		col = (vim.o.columns - width) / 2, -- 居中
		row = 1,
		style = 'minimal',
		border = 'rounded',
	})
	local normalnc_highlight = 'NotifyINFOBg'
	if level == vim.log.levels.ERROR then
		normalnc_highlight = 'NotifyERRORBg'
	end
	vim.api.nvim_set_option_value('winhighlight', 'NormalNC:'..normalnc_highlight, { scope = 'local', win = win })
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { msg })
	vim.defer_fn(function ()
		vim.api.nvim_win_close(win, true)
	end, duration)
end

return M
