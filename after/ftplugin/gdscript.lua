vim.opt_local.number = true
vim.opt_local.relativenumber = true
vim.opt_local.signcolumn = 'number'

vim.treesitter.start()
vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt_local.foldlevel = 99
vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
