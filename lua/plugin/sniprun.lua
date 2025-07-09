return {
	"michaelb/sniprun",
	branch = "master",

	build = "sh install.sh",
	-- do 'sh install.sh 1' if you want to force compile locally
	-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

	config = function()
		vim.api.nvim_set_keymap('v', '<leader>r', '<Plug>SnipRun', {silent = true})
		require("sniprun").setup({
			-- BUG 运行 `vim.print('foo')`
			--   预期: 因为 Lua_original 出错, fallback 到 Lua_nvim 执行
			--   实际: 虽然正常执行了, 但会显示很长的报错信息, 暂时没有找到办法关闭
			selected_interpreters = {'Lua_nvim'},
			interpreter_options = {
				Cpp_original = {
					compiler = "clang++"
				}
			},
			display = {
				"Classic",       --# display results in the command-line area
				"VirtualTextOk"  --# display ok results as virtual text (multiline is shortened)
			},
			snipruncolors = {
				--SniprunVirtualTextOk  = {bg="#66eeff",fg="#000000",ctermbg="Cyan",cterfg="Black"},
				--SniprunFloatingWinOk  = {fg="#66eeff",ctermfg="Cyan"},
				--SniprunVirtualTextErr = {bg="#881515",fg="#000000",ctermbg="DarkRed",cterfg="Black"},
				--SniprunFloatingWinErr = {fg="#881515",ctermfg="DarkRed"},
			},
		})
	end,
}
