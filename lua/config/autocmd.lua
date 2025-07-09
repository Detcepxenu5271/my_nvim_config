
vim.cmd([[
augroup config_autocmd
	autocmd!
	autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup='Visual', timeout=500}
	" 进入新 tab 页时, 自动切换 tab directory
	" 去除开头的协议头 (如 file://, oil://)
	" BUG 使用 fzf-lua 的 CTRL-T 在新标签页打开文件时, directory 切换不生效
	"     (推测是因为实际逻辑是先建立新的空buffer, 再打开目标buffer)
	"     :tab sb 也会, 暂时不用了, 改为用映射 <leader>dt 手动切换, 并注意管理 pwd
	"autocmd TabNewEntered * exe 'tc' fnamemodify(substitute(expand('%:p'), '^\w\+://', '', ''), ':h')
augroup END
]])
