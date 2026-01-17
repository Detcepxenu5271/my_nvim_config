-- vim.lsp.enable('lua_ls')
-- vim.lsp.enable('vimls')
-- vim.lsp.enable('clangd')

-- 创建 LspEnable 命令
vim.api.nvim_create_user_command('LspEnable', function(opts)
	local server_name = opts.args
	if server_name == '' then
		print("Usage: LspEnable <server_name>")
		return
	end

	-- 执行启用操作
	local ok, err = pcall(function()
		vim.lsp.enable(server_name)
	end)

	if not ok then
		vim.notify("Fail to enable LSP: " .. tostring(err), vim.log.levels.ERROR)
	else
		vim.notify("Enabled LSP: " .. server_name, vim.log.levels.INFO)
	end
end, {
	nargs = 1,	-- 接受 1 个参数
	complete = function(ArgLead, CmdLine, CursorPos)
		-- 补全列表
		-- TODO 自动获取
		local servers = {'clangd', 'lua_ls', 'ts_ls', 'vimls', 'pico8_ls', 'pylsp'}

		-- 过滤匹配项
		local matches = {}
		for _, server in ipairs(servers) do
			if string.find(server, '^' .. ArgLead) then
				table.insert(matches, server)
			end
		end

		return matches
	end,
	desc = "Enable specific LSP server with completion support"
})

vim.api.nvim_create_augroup('my_lsp_attach', {clear = true})

vim.api.nvim_create_autocmd('LspAttach', {
	group = 'my_lsp_attach',
	callback = function (event)
		vim.keymap.set('n', 'grd', vim.lsp.buf.definition, {buffer = true})
		vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, {buffer = true})
	end
})

