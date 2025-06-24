-- 自定义颜色

local M = {}

M.colornames = {
	-- from nvim-quietlight
	-- TODO 改为 palette 的颜色
	ql_black = '#14161b',
	ql_white = '#f5f5f5',
	ql_lightgrey = '#d3d3d3',
	ql_verylightgrey = '#e8e8e8',
	ql_purple = '#7a3e9d',
	ql_lightpurple = '#c4b7d7',
	ql_darkpurple = '#705697',
	ql_green = '#448c27',
	ql_lightgreen = '#c1f5b0',
	ql_verylightgreen = '#e4f6d4',
	ql_red = '#aa3731',
	ql_blue = '#4b69c6',
	ql_orange = '#ab6526',
	ql_brighter_red = '#c4453f', -- brighter red_50
	ql_brighter_orange = '#d18a2e', -- brighter orange_0
	-- others
	highlight_yellow = '#f0c674',
	warning_yellow = '#ca7602',
	--warning_yellow = '#ff922b',
	folded_green = '#c4d6b4'
}

function M.getcolor(self, name)
	-- TODO 检查颜色是否存在
	return self.colornames[name]
end

return M
