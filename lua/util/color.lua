-- 自定义颜色

local M = {}

M.colornames = {
	-- from nvim-quietlight
	-- TODO 改为 palette 的颜色名称
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
	folded_green = '#c4d6b4',
	scratch_backgound_yellow = '#f7f3e6',
	-- pico-8 palette
	pico8_0 = '#000000', -- black
	pico8_1 = '#1D2B53', -- dark blue
	pico8_2 = '#7E2553', -- dark magenta
	pico8_3 = '#008751', -- dark green
	pico8_4 = '#AB5236', -- brown
	pico8_5 = '#5F574F', -- dark grey
	pico8_6 = '#C2C3C7', -- light grey
	pico8_7 = '#FFF1E8', -- white
	pico8_8 = '#FF004D', -- red
	pico8_9 = '#FFA300', -- orange
	pico8_10 = '#FFEC27', -- yellow
	pico8_11 = '#00E436', -- green
	pico8_12 = '#29ADFF', -- blue
	pico8_13 = '#83769C', -- grey purple
	pico8_14 = '#FF77A8', -- pink
	pico8_15 = '#FFCCAA', -- light orange
}

function M.getcolor(self, name)
	-- TODO 检查颜色是否存在
	return self.colornames[name]
end

return M

