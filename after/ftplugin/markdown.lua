vim.wo.conceallevel = 2
vim.wo.foldlevel = 1

vim.keymap.set('n', '<LocalLeader>b', 'viWv`>a**<Esc>`<i**<Esc>', {buffer = true})
vim.keymap.set('n', '<LocalLeader>i', 'viWv`>a*<Esc>`<i*<Esc>', {buffer = true})
vim.keymap.set('n', '<LocalLeader>s', 'viWv`>a~~<Esc>`<i~~<Esc>', {buffer = true})

vim.keymap.set('v', '<LocalLeader>b', 'v`>a**<Esc>`<i**<Esc>', {buffer = true})
vim.keymap.set('v', '<LocalLeader>i', 'v`>a*<Esc>`<i*<Esc>', {buffer = true})
vim.keymap.set('v', '<LocalLeader>s', 'v`>a~~<Esc>`<i~~<Esc>', {buffer = true})
vim.keymap.set('v', '<LocalLeader>c', 'v`>a`<Esc>`<i`<Esc>', {buffer = true})
vim.keymap.set('v', '<LocalLeader>m', 'v`>a$<Esc>`<i$<Esc>', {buffer = true})

vim.keymap.set('i', 'jlc', '``<Left>', {buffer = true})
vim.keymap.set('i', 'jlm', '$$<Left>', {buffer = true})

