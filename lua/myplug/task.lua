local M = {}

local tmpbin_dir = vim.fn.expand('~')..'/.tmp'

---TODO reuse terminal
---@desc build current (vim's current-file) single source file with cc
---@param flags? string compile flags
---@param cc? string C compiler command (gcc, g++, clang...)
---@param isdebug? bool use debug mode
---@param force_term? bool forced terminal usage
---@return int error code, 0 is normal
local function single_build_with_cc(flags, cc, isdebug, force_term)
	-- ======== 构造编译命令 ========

	local cur_file = vim.fn.expand('%:p')
	local out_name = vim.fn.expand('%:t:r')

	if isdebug then
		flags = flags .. ' -g -fstandalone-debug -DDEBUG'
	end

	local compile_cmd = string.format(
		cc..' -Wall %s -o "%s/%s" "%s"',
		flags,
		tmpbin_dir, out_name,
		cur_file
	)

	-- ======== 选择运行命令的方式 ========

	if not force_term then
		local ok, _ = pcall(vim.cmd.AsyncRun, compile_cmd)
		if ok then
			return
		end
	end

	vim.api.nvim_command('5new | terminal '..compile_cmd)
	-- 返回代码窗口
	vim.cmd('wincmd p')
	--vim.api.nvim_command("startinsert")

	return 0
end

---@desc run current (vim's current-file) single source file's corresponding binary
---      (pair with single_build_with_xxx function)
---@param flags? string compile flags
---@return int error code, 0 is normal
local function single_binary_run(flags)
	local bin_name = vim.fn.expand('%:t:r')

	local run_cmd = string.format(
		'"%s/%s" %s',
		tmpbin_dir, bin_name,
		flags
	)

	vim.api.nvim_command('10new | terminal '..run_cmd)
	vim.api.nvim_command('startinsert')

	return 0
end

-- languages' key is used in autogroup's pattern (match)
-- so it must be acceptable filetype
M.languages = {}

M.languages.c = {
	build = function(flags)
		return single_build_with_cc(flags, 'clang', false, false)
	end,
	build_debug = function(flags)
		return single_build_with_cc(flags, 'clang', true, false)
	end,
	run = function(flags)
		return single_binary_run(flags)
	end,
}

M.languages.cpp = {
	build = function(flags)
		return single_build_with_cc(flags, 'clang++', false, false)
	end,
	build_debug = function(flags)
		return single_build_with_cc(flags, 'clang++', true, false)
	end,
	run = function(flags)
		return single_binary_run(flags)
	end,
}

function M.setup()
	local myplug_task_group = vim.api.nvim_create_augroup("MyplugTask", {
		clear = true
	})

	
	local languages = {}
	local i = 0
	for k,v in pairs(M.languages) do
		i = i+1
		languages[i] = k
	end
	vim.api.nvim_create_autocmd("FileType", {
		pattern = languages,
		group = myplug_task_group,
		callback = function(ev)
			vim.api.nvim_buf_create_user_command(0, 'B', function(opts)
				if not opts.bang then
					M.languages[ev.match].build(opts.args)
				else
					M.languages[ev.match].build_debug(opts.args)
				end
			end, {
				desc = "Build current source file",
				bang = true,
				nargs = '?'
			})
			vim.api.nvim_buf_create_user_command(0, 'R', function(opts)
				M.languages[ev.match].run(opts.args)
			end, {
				desc = "Run current source file (corresponding binary or as script, depends on filetype)",
				bang = false,
				nargs = '?'
			})
			vim.keymap.set('n', '<LocalLeader>bb', ':B<cr>', {buffer = true})
			vim.keymap.set('n', '<LocalLeader>bd', ':B!<cr>', {buffer = true})
			vim.keymap.set('n', '<LocalLeader>r', ':R<cr>', {buffer = true})
		end

	})
end

return M
