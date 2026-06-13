-- lua module, collect temporary thoughts and tools to be quickly used and tested for future work

M = {}

---@desc Run script with shebang
---@param script string Full script to run, first line is shebang (starts with #!)
---@return string stdin or stderr (if not empty)
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

---@desc Preview the given latex code, requires pdflatex on PATH
---      designed to preview math code, so use standalone
---@param latex_text string Text of latex code (including $ or $$)
function M.latex_preview(latex_text)
	local cache_dir = vim.fn.stdpath('cache')
	local tmp_name = cache_dir .. '/latex_preview.tex'
	local pdf_name = cache_dir .. '/latex_preview.pdf'
	local tmp_fd = io.open(tmp_name, 'w')
	if tmp_fd == nil then
		error("Can't create temp file", 0)
		return 1
	end
	tmp_fd:write('\\documentclass[border=2pt,varwidth]{standalone}\n')
	tmp_fd:write('\\usepackage{amsmath,amssymb}\n')
	tmp_fd:write('\\begin{document}\n')
	tmp_fd:write(latex_text)
	tmp_fd:write('\n\\end{document}\n')
	tmp_fd:close() -- !!IMPORTANT!!
	local obj = vim.system({
		'pdflatex',
		'-jobname=latex_preview',
		'-interaction=nonstopmode',
		'-output-directory=' .. cache_dir,
		tmp_name
	}, { text = true }):wait()
	if obj.code ~= 0 then
		print('stdout:\n'..(obj.stdout or ''))
		print('stderr:\n'..(obj.stderr or ''))
		error('pdflatex failed', 0)
		return 1
	end
	if vim.fn.has('win32') == 1 then
		-- os.execute('start '..pdf_name)
		os.execute('start "" "' .. pdf_name .. '"')
	else
		vim.ui.open(pdf_name)
	end
end

function M.setup()
	vim.keymap.set('v', '<Leader>r', function()
		vim.cmd([[norm! y'>]])
		vim.fn.setreg('"', M.run_script(vim.fn.getreg('"')))
		vim.cmd([[iput "]])
	end)
	-- universal preview keymap, only math for now
	vim.keymap.set('n', '<Leader>p', function()
		-- inline math surrounded by "\(" and "\)" only
		vim.cmd([[norm! ?\\(<Cr>y/\\)/e<Cr>]])
		-- TODO keeppattern
		local keys = vim.api.nvim_replace_termcodes("?\\\\(<Cr>y/\\\\)/e<Cr>", true, false, true)
		-- use flag 'x' to empty queue (until typehead is empty), otherwise register read is the old one
		vim.api.nvim_feedkeys(keys, 'nx', false)
		M.latex_preview(vim.fn.getreg('"'))
	end)
	vim.keymap.set('v', '<Leader>p', function()
		vim.cmd([[norm! y]])
		M.latex_preview(vim.fn.getreg('"'))
	end)
	vim.api.nvim_create_user_command('HelpTagsRefresh', 'helptags $MYVIMRC/../doc', {desc = "Generate tags for help file in my config's doc"})
end

return M
