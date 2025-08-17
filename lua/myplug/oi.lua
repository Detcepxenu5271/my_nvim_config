-- OI (Olympiad in Informatics)

local M = {}

-- ======== 测试某目录下所有输入输出文件 ========

-- 用指定目录下所有输入输出文件测试某程序
--- @param prog string 程序名
--- @param dir string 目录名
--- @param ext_in? string 输入文件扩展名, 默认 in
--- @param ext_out? string 输出文件扩展名, 默认 out
local function test_in_and_out(prog, dir, ext_in, ext_out)
	ext_in = ext_in or "in"
	ext_out = ext_out or "out"
	local pat_in = "\\."..ext_in.."$"
	local prog_out = prog.."."..ext_out

	for name, type in vim.fs.dir(dir) do
		local in_name = dir..'/'..name
		if vim.fn.match(in_name, pat_in) >= 0 and type == 'file' then
			vim.fn.system(prog.." <"..in_name.." >"..prog_out)
			-- print(prog.." <"..in_name.." >"..prog_out)

			local out_name = vim.fn.fnamemodify(in_name, ':r')..'.'..ext_out
			local diff_ret = vim.fn.system("diff -ZB "..prog_out.." "..out_name)
			-- print("diff "..prog_out.." "..out_name)
			if vim.v.shell_error ~= 0 then
				vim.notify("[TEST "..in_name.."]:\n"..diff_ret)
				break
			end
		end
	end
end

-- don't use local, because M is local
function M.setup()
	-- ======== build and run mappings ========
	vim.cmd([[
	augroup myplug_oi
		au!
		au FileType cpp nnoremap <buffer> <LocalLeader>bb :Bclangpp<cr>
		au FileType cpp nnoremap <buffer> <LocalLeader>bd :Bclangpp!<cr>
		au FileType cpp nnoremap <buffer> <LocalLeader>rr :R<cr>
		au FileType cpp nnoremap <buffer> <LocalLeader>rs :R < s1.in<cr>
		au FileType cpp nnoremap <buffer> <LocalLeader>rs1 :R < s1.in<cr>
		au FileType cpp nnoremap <buffer> <LocalLeader>rs2 :R < s2.in<cr>
		au FileType cpp nnoremap <buffer> <LocalLeader>rs3 :R < s3.in<cr>
		au FileType cpp nnoremap <buffer> <LocalLeader>rs4 :R < s4.in<cr>
	augroup END
	]])

	vim.api.nvim_create_user_command('TestInOut', function (opt)
		-- <f-args>: dir, [ext_in], [ext_out]
		if #opt.fargs < 1 or #opt.fargs > 3 then
			vim.notify('Usage: TestInOut <dir> [ext_in] [ext_out]', vim.log.levels.ERROR)
			return
		end
		local prog = '~/.tmp/'..vim.fn.expand('%:t:r')
		test_in_and_out(prog, opt.fargs[1], opt.fargs[2], opt.fargs[3])
	end, {
		nargs = '*',
	})
end

return M
