local opt = vim.opt

-- ======== 外 观 (ui) ========

opt.complete:append('k')
opt.complete:append('s')
opt.complete:remove('u')
-- when 0.12, fuzzy may affect the collection of candidates
-- longest may conflict with fuzzy
opt.completeopt = {'menuone', 'popup', 'fuzzy'}
-- opt.completeopt:append('longest')
-- opt.completeopt:remove('menu')
-- opt.completeopt:append('menuone')
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
-- shiftwidth=0: use tabstop
opt.shiftwidth = 0
opt.smartcase = true
opt.smartindent = true
opt.splitkeep = 'screen'
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 4
opt.virtualedit:append('block')
opt.winwidth = 1
opt.wrapscan = false

-- ======== 文 件 (file) ========

opt.backup = true
opt.backupdir:remove('.')
opt.swapfile = true
opt.undofile = true
opt.fileencodings = 'ucs-bom,utf-8,cp936,default,latin1'

-- ======== 命 令 行 (cmdline) ========

opt.wildmode = {'longest', 'full'}
opt.wildoptions:append('fuzzy')

-- ======== 其 他 (else) ========

opt.keywordprg = ':help'
opt.timeout = false
if vim.fn.executable('rg') then
	opt.grepprg = 'rg --vimgrep -S'
end

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

