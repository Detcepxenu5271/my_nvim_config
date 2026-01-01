local M = {}

-- TODO use error() rather than assert()
function M.arrange(n, m)
	assert(n >= 0 and (0 <= m and m <= n), "param range failure")
	local res = 1
	for i = n-m+1, n do
		res = res * i
	end
	return res
end

function M.combine(n, m)
	assert(n >= 0 and (0 <= m and m <= n), "param range failure")
	if m > n-m then m = n-m end
	return M.arrange(n, m) / M.arrange(m, m)
end

function M.setup()
	vim.keymap.set("v", "<Leader>=v", [[s<C-r>=<C-r>"<Cr><Esc>]], {desc = "Evaluate Vim Expression"})
	vim.keymap.set("v", "<Leader>=l", [[s<C-r>=luaeval('<C-r>"')<Cr><Esc>]], {desc = "Evaluate Lua Expression"})

	vim.g.A = M.arrange
	vim.g.C = M.combine
end

return M
