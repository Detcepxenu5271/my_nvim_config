local M = {}

function M.combine(n, m)
	local item1 = 1
	local item2 = 1
	local item3 = 1
	for i = 2, n do
		item1 = item1 * i
		if i == m then
			item3 = item1
		end
		if i == n-m then
			item2 = item1
		end
	end
	return item1 / item2 / item3
end

-- use command to register vim.g.C as require('util.math').combine
-- (and so on)

return M
