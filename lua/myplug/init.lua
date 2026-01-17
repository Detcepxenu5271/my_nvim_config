local myplug_path = vim.fn.stdpath('config')..'/lua/myplug'

-- ==========================
-- | sourced/setup at start |
-- ==========================

-- basic utils
vim.cmd('source '..myplug_path..'/buffer-utils.vim')
require'myplug.buffer-utils'
require'myplug.misc-utils'

-- language utils
vim.cmd('source '..myplug_path..'/markdown-utils.vim')
require'myplug.cxx-utils'

-- UI
vim.cmd('source '..myplug_path..'/statusline.vim')
require'myplug.tabline'
vim.cmd('source '..myplug_path..'/foldtext.vim')

-- others
require'myplug.workspace-vim_compatible'

-- temp
require'myplug.temp'.setup()

-- ====================
-- | setup at runtime |
-- ====================
-- check the "补全列表"

vim.api.nvim_create_user_command('MyplugSetup', function (opts)
	local plug_name = opts.args
	if plug_name == '' then
		vim.notify("Usage: MyplugSetup <plug_name>", vim.log.levels.ERROR)
		return
	end

	local ok, err = pcall(require('myplug.'..plug_name).setup)

	if not ok then
		vim.notify('Fail to setup myplug: '..tostring(err), vim.log.levels.ERROR)
	else
		vim.notify('Setup myplug: '..plug_name, vim.log.levels.INFO)
	end
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLine, CursorPos)
		-- 补全列表
		local plugs = {'oi'}

		-- 过滤匹配项
		local matches = {}
		for _, plug in ipairs(plugs) do
			if string.find(plug, '^' .. ArgLead) then
				table.insert(matches, plug)
			end
		end

		return matches
	end,
	desc = "Setup myplug",
})
