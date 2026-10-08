return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		image = {
			enabled = true,
			doc = {
				-- inline math has 2 problems:
				-- 1. too thin / low resolution to see clearly
				-- 2. multi-line render is weird (overlapping)
				--    目前结论: 不用 inline. issue 相关条目都没人修
				--    更新结论 [2026-09-24]: org 会有 overlapping, 原因可能主要是 nvim-orgmode 会把 \begin{aligned} 直接当成 latex 环境, 导致在 math 块中使用时重复渲染
				-- inline = true,
				-- float = true,
			},
		},
	},
}
