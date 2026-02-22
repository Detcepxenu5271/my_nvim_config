local function get_slash()
	return vim.o.shellslash and '/' or '\\'
end

local notmyplug_path = vim.fn.stdpath('config')..get_slash()..'lua'..get_slash()..'notmyplug'
local filename_cur = 'init.lua'

-- source all scripts from current directory, including single file (vim, lua) and directory (lua module)
for name, type in vim.fs.dir(notmyplug_path) do
	-- single file
	if type == 'file' and name ~= filename_cur then
		local root = vim.fn.fnamemodify(name, ':r')
		local ext = vim.fn.fnamemodify(name, ':e')
		if ext == 'lua' then
			require('notmyplug.'..root)
		elseif ext == 'vim' then
			vim.cmd('source '..notmyplug_path..get_slash()..name)
		end
	-- directory, treat as lua module
	elseif type == 'directory' then
		require('notmyplug.'..name)
	end
end
