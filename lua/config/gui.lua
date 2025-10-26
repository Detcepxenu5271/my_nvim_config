-- neovide config
if vim.g.neovide then
	vim.o.guifont = 'UbuntuMono Nerd Font,LXGW WenKai Mono:h15'
	vim.g.neovide_opacity = 0.9
	vim.g.neovide_normal_opacity = 0.9
	-- Animations
	vim.g.neovide_position_animation_length = 0.15 -- 0.15
	vim.g.neovide_cursor_animation_length = 0 -- 0.150
	vim.g.neovide_cursor_trail_size = 0 -- 1.0
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_scroll_animation_far_lines = 1 -- 1
	vim.g.neovide_scroll_animation_length = 0.3 -- 0.3
	-- IME (输入法)
	-- ?BUG: 只显示候选词结果, 不显示输入过程
	vim.g.neovide_input_ime = true
end
