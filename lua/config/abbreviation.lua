--cnoreabbr lv leftabove vnew
--cnoreabbr rv rightbelow vnew
--cnoreabbr tn topleft new
--cnoreabbr bn botright new

-- window split left/right/above/below
-- only split in current big window
vim.keymap.set('ca', 'wsh', 'leftabove vertical')
vim.keymap.set('ca', 'wsj', 'belowright')
vim.keymap.set('ca', 'wsk', 'aboveleft')
vim.keymap.set('ca', 'wsl', 'rightbelow vertical')
-- 为什么用这个 abbreviation
-- lefta[bove] -> abo[veleft] 也不算太慢
-- 但 rightb[elow] -> bel[oright] 容易和 bo[tright] 弄混
-- 所以总体而言, 用 lefta/rightb 还是要打太多字
