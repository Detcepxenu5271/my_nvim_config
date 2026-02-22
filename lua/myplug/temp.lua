-- lua module, collect temporary thoughts and tools to be quickly used and tested for future work

M = {}

--@desc Run script with shebang
--@param script string Full script to run, first line is shebang (starts with #!)
--@return string stdin or stderr (if not empty)
function M.run_script(script)
	-- locate the first newline (end of shebang)
	local first_nl, _ = string.find(script, "\n")
	if first_nl == nil then
		return "[ERROR] Input must contain at least a newline"
	end
	-- split shebang and script body
	local shebang = string.sub(script, 0, first_nl-1)
	-- check if shebang is legal
	if string.sub(shebang, 1, 2) ~= '#!' then
		return "[ERROR] illegal shebang"
	end
	local body = string.sub(script, first_nl+1)
	-- split command and arguments from shebang
	local cmd = vim.split(string.sub(shebang, 3), '%s+', {trimempty=true})
	-- add stdin argument
	table.insert(cmd, '-')
	-- run script synchronously
	local obj = vim.system(cmd, {
		stdin = body,
		text = true,
	}):wait()
	return obj.stderr ~= "" and obj.stderr or obj.stdout
end

function M.setup()
	vim.keymap.set('v', '<Leader>r', function()
		vim.cmd([[norm! y'>]])
		vim.fn.setreg('"', M.run_script(vim.fn.getreg('"')))
		vim.cmd([[iput "]])
	end)
	vim.api.nvim_create_user_command('HelpTagsRefresh', 'helptags $MYVIMRC/../doc', {desc = "Generate tags for help file in my config's doc"})
end

return M
