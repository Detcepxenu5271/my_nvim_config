-- @desc 删除指定模式的 buffer, 并输出删除的结果
--       默认包括 listed 和 unlisted buffer
-- @param pattern vim 风格的正则表达式模式
local function buf_delete_filter(pattern, force)
	local blist_all = vim.api.nvim_list_bufs()
	local msg = ''
	local blist_delete = {}
	for _, bnr in ipairs(blist_all) do
		local bname = vim.api.nvim_buf_get_name(bnr)
		if      vim.fn.buflisted(bnr) == 1
			and vim.fn.match(bname, pattern) >= 0
		then
			table.insert(blist_delete, bnr)
			msg = msg..bname..'\n'
		end
	end
	if #blist_delete == 0 then
		msg = msg..'No buffer matched\n'
		vim.notify(msg, vim.log.levels.INFO)
	else
		msg = 'Matched buffer(s):\n'..msg
		vim.notify(msg, vim.log.levels.INFO)
		local choice = vim.fn.confirm('Confirm delete:', "&Yes\n&No")
		if choice == 1 then
			-- delete (unlist) buffer
			for _, bnr in ipairs(blist_delete) do
				-- vim.api.nvim_buf_delete() support wipeout or unload
				vim.cmd('bdelete'..(force and '!' or '')..' '..bnr)
			end
		end
	end
end

vim.api.nvim_create_user_command('BufDelFilter', function (opts)
	buf_delete_filter(opts.args, opts.bang)
end, {
	desc = "Delete (unlist) buffer by filter pattern",
	bang = true,
	nargs = 1,
})

