return{
    "bakudankun/pico-8.vim",
	-- lazy-load on filetype
    ft = "pico8",
	config = function()
		vim.g.pico8_config = {
			imitate_console = false
		}
		--vim.cmd([[
		--let g:pico8_config = {}
		--let g:pico8_config.imitate_console = 0
		--]])
	end
}
