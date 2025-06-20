-- TODO c (only cpp now)

-- all binary (executable) files are generated to tmp dir, and used from it
local tmpbin_dir = vim.fn.expand('~')..'/.tmp'

-- TODO reuse terminal
local function build_with_clangpp(flags, isdebug)
	--local cur_dir = vim.fn.expand('%:p:h')
	local cur_file = vim.fn.expand('%:p')
	local out_name = vim.fn.expand('%:t:r')

	if isdebug then
		flags = flags .. '-g -fstandalone-debug -DDEBUG'
	end

	local compile_cmd = string.format(
		"clang++ -Wall %s -o '%s/%s' '%s'",
		flags,
		tmpbin_dir, out_name,
		cur_file
	)

	vim.api.nvim_command("5new | terminal "..compile_cmd)
	-- 返回代码窗口
	vim.cmd('wincmd p')
	--vim.api.nvim_command("startinsert")
end

local function run(flags)
	--local cur_dir = vim.fn.expand('%:p:h')
	local bin_name = vim.fn.expand('%:t:r')

	local run_cmd = string.format(
		"'%s/%s' %s",
		tmpbin_dir, bin_name,
		flags
	)

	vim.api.nvim_command("10new | terminal "..run_cmd)
	vim.api.nvim_command("startinsert")
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
			build_with_clangpp(opts.args, opts.bang)
		end, {
			desc = "Build current source file with clang++",
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
		vim.keymap.set('n', '<leader>bb', ':Bclangpp<cr>', {buffer = true})
		vim.keymap.set('n', '<leader>bd', ':Bclangpp!<cr>', {buffer = true})
		vim.keymap.set('n', '<leader>r', ':R<cr>', {buffer = true})
		-- TODO build and run: use one window to show, or build silently unless fail
		--vim.keymap.set('n', '<leader>br', function (opts)
		--	build_with_clangpp('', false)
		--	run('')
		--end, {buffer = true})
	end
})
