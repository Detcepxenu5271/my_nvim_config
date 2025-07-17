-- ======== Misc Commands ========

-- make a quick session
vim.api.nvim_create_user_command('SessionQuick', 'mksession! ~/.tmp/Session.vim', {})

-- view hex dump of current buffer in vertical split window
vim.api.nvim_create_user_command('HexDump', 'vnew | 0r # | setl noswapfile buftype=nofile bufhidden=wipe ft=xxd nonu nornu nowrap | silent %!xxd', {})

-- diff current buffer with saved file
-- TODO 自动切换 filetype
--      了解 ++edit 是什么用法
--vim.api.nvim_create_user_command('DiffSaved', 'vertical new | set buftype=nofile | 0read ++edit # | diffthis | wincmd p | diffthis', {})
