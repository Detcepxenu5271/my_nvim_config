local ts_ls_cmd = 'typescript-language-server'
if vim.fn.has('win32') then
	ts_ls_cmd = ts_ls_cmd..'.cmd'
end

return {
	cmd = { ts_ls_cmd, '--stdio' }
}
