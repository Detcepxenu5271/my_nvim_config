-- Eat a char that matches pattern
-- from map.txt (2. Abbreviations)
-- BUG Eatchar kinda sucks
--     Desc: When `:ca ptt ...`, Eatchar (lua version) will stall for seconds
--     Solve: use vim, rather than lua
vim.cmd([[
func! Eatchar(pat)
	let c = nr2char(getchar(0))
	return (c =~ a:pat) ? '' : c
endfunc
]])

