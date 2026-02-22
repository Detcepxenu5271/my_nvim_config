-- TODO c (only cpp now)

-- all binary (executable) files are generated to tmp dir, and used from it
-- only support linux by default (for other platforms or custom path, change this variable)
local tmpbin_dir = vim.fn.expand('~')..'/.tmp'

--- TODO reuse terminal
---@param flags? string compile flags
---@param ispp? bool use clang++ (true) or clang (false)
---@param isdebug? bool use debug mode
---@param force_term? bool forced terminal usage
local function build_with_clang(flags, ispp, isdebug, force_term)
	-- ======== 构造编译命令 ========

	--local cur_dir = vim.fn.expand('%:p:h')
	local cur_file = vim.fn.expand('%:p')
	local out_name = vim.fn.expand('%:t:r')

	if isdebug then
		flags = flags .. ' -g -fstandalone-debug -DDEBUG'
	end

	local compile_cmd = string.format(
		'clang'..(ispp and '++' or '')..' -Wall %s -o "%s/%s" "%s"',
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
end

local function run(flags)
	--local cur_dir = vim.fn.expand('%:p:h')
	local bin_name = vim.fn.expand('%:t:r')

	local run_cmd = string.format(
		'"%s/%s" %s',
		tmpbin_dir, bin_name,
		flags
	)

	vim.api.nvim_command('10new | terminal '..run_cmd)
	vim.api.nvim_command('startinsert')
end

-- ======== autogroup ========

-- 获取的是 autogroup 的 id
local cxx_utils_group = vim.api.nvim_create_augroup("CxxUtils", {
	clear = true  -- 可选：是否清除同名的已有组
})

-- ======== commands ========

-- Qcpp (quick cpp)
vim.api.nvim_create_user_command('Qcpp', 'tabe ~/.tmp/quick.cpp', {})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {'cpp'},
	group = cxx_utils_group,
	callback = function ()
		-- Bclangpp
		vim.api.nvim_buf_create_user_command(0, 'Bclangpp', function (opts)
			build_with_clang(opts.args, true, opts.bang, false)
		end, {
			desc = "Build current source file with clang++",
			bang = true,
			nargs = '?'
		})
		vim.api.nvim_buf_create_user_command(0, 'TermBclangpp', function (opts)
			build_with_clang(opts.args, true, opts.bang, true)
		end, {
			desc = "Build current source file with clang++ (forced terminal usage)",
			bang = true,
			nargs = '?'
		})
		-- R
		vim.api.nvim_buf_create_user_command(0, 'R', function (opts)
			run(opts.args)
		end, {
			desc = "Run current source file's corresponding binary",
			bang = false,
			nargs = '?'
		})
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {'c'},
	group = cxx_utils_group,
	callback = function ()
		-- Bclang
		vim.api.nvim_buf_create_user_command(0, 'Bclang', function (opts)
			build_with_clang(opts.args, false, opts.bang, false)
		end, {
			desc = "Build current source file with clang",
			bang = true,
			nargs = '?'
		})
		vim.api.nvim_buf_create_user_command(0, 'TermBclang', function (opts)
			build_with_clang(opts.args, true, opts.bang, true)
		end, {
			desc = "Build current source file with clang (forced terminal usage)",
			bang = true,
			nargs = '?'
		})
		-- R
		vim.api.nvim_buf_create_user_command(0, 'R', function (opts)
			run(opts.args)
		end, {
			desc = "Run current source file's corresponding binary",
			bang = false,
			nargs = '?'
		})
	end
})

-- ======== keymaps ========

vim.api.nvim_create_autocmd('FileType', {
	pattern = {'cpp'},
	group = cxx_utils_group,
	callback = function ()
		-- TODO consider use B rather than b
		vim.keymap.set('n', '<LocalLeader>bb', ':Bclangpp<cr>', {buffer = true})
		vim.keymap.set('n', '<LocalLeader>bd', ':Bclangpp!<cr>', {buffer = true})
		vim.keymap.set('n', '<LocalLeader>r', ':R<cr>', {buffer = true})
	end
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {'c'},
	group = cxx_utils_group,
	callback = function ()
		-- TODO consider use B rather than b
		vim.keymap.set('n', '<LocalLeader>bb', ':Bclang<cr>', {buffer = true})
		vim.keymap.set('n', '<LocalLeader>bd', ':Bclang!<cr>', {buffer = true})
		vim.keymap.set('n', '<LocalLeader>r', ':R<cr>', {buffer = true})
	end
})
