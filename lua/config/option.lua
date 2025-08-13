local opt = vim.opt

-- ======== 外 观 (ui) ========

opt.complete:append('k')
opt.complete:append('s')
opt.complete:remove('u')
opt.completeopt:append('longest')
opt.cursorline = true
opt.equalalways = false
opt.ignorecase = true
opt.jumpoptions:append('stack')
opt.lazyredraw = true;
opt.list = true
-- simulate indent line
opt.listchars = {tab = '│ ', trail = 'X'}
--opt.listchars = {tab = '>-', trail = 'X'}
opt.nrformats:append('alpha')
opt.number = true
opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 4
opt.smartcase = true
opt.smartindent = true
opt.splitkeep = 'screen'
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.virtualedit:append('block')
opt.wrapscan = false

-- ======== 文 件 (file) ========

opt.backup = true
opt.backupdir:remove('.')
opt.swapfile = true
opt.undofile = true

-- ======== 命 令 行 (cmdline) ========

opt.wildmode = {'longest', 'full'}
opt.wildoptions:append('fuzzy')

-- ======== 其 他 (else) ========

opt.keywordprg = ':help'
opt.timeout = false

-- ======== 内 置 插 件 (builtin) ========

-- netrw tree
vim.g.netrw_banner = 0
vim.g.netrw_preview = 1

-- markdown
vim.g.markdown_folding = 1
vim.g.markdown_syntax_conceal = 1

vim.cmd('packadd cfilter')

-- add manually?
--vim.cmd('packadd! termdebug')
vim.g.termdebug_config = {
	map_K = false,
	map_minus = false,
	map_plug = false,
}

