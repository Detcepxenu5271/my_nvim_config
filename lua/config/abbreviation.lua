-- BUG Eatchar kinda sucks
--     Desc: When `:ca ptt ...`, Eatchar (lua version) will stall for seconds
--     Solve: use vim, rather than lua
vim.cmd([[
func! Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunc
]])

vim.keymap.set('ca', 'wsh', 'leftabove vertical')
vim.keymap.set('ca', 'wsj', 'belowright')
vim.keymap.set('ca', 'wsk', 'aboveleft')
vim.keymap.set('ca', 'wsl', 'rightbelow vertical')
--vim.keymap.set('ca', 'ptt', '<[^>]\\+><C-r>=lua Eatspace()<CR>', {desc = 'Pattern: Tag'})
vim.cmd([[cnorea ptt <[^>]\+><C-r>=Eatchar('\s')<CR>]])
