-- @file:     init.lua
-- @author:   JulyRabbit
-- @github:   Detcepxenu5271
-- @brief:    My onefile-config for Neovim, stick to nvim and try to maximize
--            simplicity and compatibility
-- @detailed: Some principles:
--            1. If my wanted setting is the same as default, don't show in
--               this config file
--            2. Almost no comment. To know the meaning of config, use :help
--               (also, :opt can show all commands classified and with desc)

-- use this pattern to search the section title:
-- ^$\n\zs-- +=\++\n.*\n.*\n

-- +===========+
-- |  options  |
-- +===========+

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
opt.listchars = {tab = '>-', trail = 'X'}
opt.nrformats:append('alpha')
opt.number = true
opt.relativenumber = true
opt.shiftround = true
opt.shiftwidth = 4
opt.smartcase = true
opt.smartindent = true
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

-- +===========+
-- |  keymaps  |
-- +===========+

local map = vim.keymap.set

-- ======== META ========

map('n', 'M', function()
	vim.cmd([[
		exe 'tabe' stdpath('data')..'/meta.txt'
		exe 'tc' stdpath('data')
		setl foldmethod=indent
	]])
end, {desc = 'Meta Command'})

-- ======== Leader ========

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

map('n', '<leader>', '<nop>')

map('n', '<leader>/', ":let @/='\\<'..input('Search word: ')..'\\>'<CR>")
map('n', '<leader>a', 'i<space><esc>la<space><esc>l')
map('n', '<leader>d', '<nop>')
map('n', '<leader>dd', [[:exe "lc" substitute(expand('%:p:h'), '^\w\+://', '', '') | pwd<cr>]])
map('n', '<leader>dt', [[:exe "tc" substitute(expand('%:p:h'), '^\w\+://', '', '') | pwd<cr>]])
map('n', '<leader>dw', ':tc $ws | pwd<cr>')
map('n', '<leader>E', '<nop>')
map('n', '<leader>e', '<nop>')
map('n', '<leader>eb', ':buffers<cr>:sb<space>')
map('n', '<leader>Eb', ':buffers<cr>:vert sb<space>')
map('n', '<leader>er', ':browse oldfiles<cr>')
map('n', '<leader>ev', ':sp $MYVIMRC<cr>')
map('n', '<leader>Ev', ':vs $MYVIMRC<cr>')
map('n', '<Leader>I', ':Inspect<CR>')
map('n', '<leader>o', '<nop>')
map('n', '<leader>oc', ':setl cursorcolumn! cursorcolumn?<cr>')
map('n', '<leader>oh', ':noh<cr>', {silent = true})
map('n', '<leader>on', ':setl nu! rnu! nu?<cr>')
map('n', '<leader>ot', ':let &showtabline = 3-&showtabline | setl showtabline?<cr>')
map('n', '<leader>ow', ':setl wrap! wrap?<cr>')
map('n', '<leader>sv', ':source $MYVIMRC<cr>')
map('n', '<leader>w', '<c-w>')
map('v', '<leader>a', 'c<space><c-r>"<space><esc>')

-- ======== Insert 模式下的 "leader" ========

map('i', 'jl==', '<esc>vBdi<c-r>=<c-r>"<cr>')
map('i', 'jl=e', '<space><esc>yBEls=<c-r>=<c-r>0<cr>')

-- ======== 移 动 (motion) ========

map('c', '<c-a>', '<home>')
map('c', '<c-b>', '<left>')
map('c', '<c-f>', '<right>')
map('i', '<c-a>', '<home>')
map('i', '<c-b>', '<left>')
map('i', '<c-e>', '<end>')
map('i', '<c-f>', '<right>')
map('n', '<C-n>', '<C-i>')
map({'n', 'v', 'o'}, 'gH', 'g0')
map({'n', 'v', 'o'}, 'gL', 'g$')
map({'n', 'v', 'o'}, 'H', '0')
map({'n', 'v', 'o'}, 'L', '$')

-- ======== 编 辑 (edit) ========

map('c', '<c-l>', '<del>')
map('i', '<c-l>', '<del>')

-- 补全
map('i', '<C-o>', '<C-x><C-o>')

-- ======== 查看 (view) ========

map('n', '<Tab>', 'za')

-- ======== 窗口 (window) ========

map('n', '+', '<c-w>>')
map('n', '-', '<c-w>-')
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '=', '<c-w>+')
map('n', '_', '<c-w><')

-- ======== esc 绑定 ========

map('i', 'jk', '<esc>')
map('t', 'jk', '<c-\\><c-n>')

-- +================+
-- |  abbreviation  |
-- +================+

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
vim.cmd([[cnorea ptt <[^>]\+><C-r>=Eatchar('\s')<CR>]])

-- +===========+
-- |  autocmd  |
-- +===========+

vim.api.nvim_create_augroup('my_autocmd', { clear = true })

vim.api.nvim_create_autocmd('TextYankPost', {
	group = 'my_autocmd',
	pattern = '*',
	callback = function()
		vim.hl.on_yank {higroup='Visual', timeout=500}
	end,
	desc = 'highlight on yank'
	-- TODO "silent!" not implemented
	--      AI recommend use pcall
})

-- +===============+
-- |  diagnostics  |
-- +===============+

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '',
			[vim.diagnostic.severity.HINT] = '󰌵',
			[vim.diagnostic.severity.INFO] = '',
			[vim.diagnostic.severity.WARN] = '',
		}
	}
})

vim.keymap.set('n', 'gK', function()
	vim.diagnostic.open_float()
end, { desc = 'Toggle diagnostic float' })

vim.api.nvim_create_user_command('DiagnosticsToggle', function()
	local new_config = not vim.diagnostic.config().virtual_lines
	vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })

-- +============+
-- |  filetype  |
-- +============+

vim.filetype.add { extension = { p8 = "pico8" } }

-- +=======+
-- |  lsp  |
-- +=======+

vim.api.nvim_create_augroup('my_lsp_attach', {clear = true})

vim.api.nvim_create_autocmd('LspAttach', {
	group = 'my_lsp_attach',
	callback = function (event)
		vim.keymap.set('n', 'grd', vim.lsp.buf.definition, {buffer = true})
		vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, {buffer = true})
	end
})

-- +===============+
-- |  colorscheme  |
-- +===============+

vim.cmd('colorscheme shine')
opt.background='light'
vim.cmd([[
hi NonText guibg=NONE
hi Search guifg=#f5f5f5
hi MoreMsg guibg=#f5f5f5
hi ModeMsg guibg=#f5f5f5
hi StatusLine guifg=#f5f5f5
hi StatusLineNC guifg=#f5f5f5
hi WarningMsg guibg=#f5f5f5
hi DiffAdd guifg=#f5f5f5
hi DiffChange guifg=#f5f5f5
hi DiffDelete guifg=#f5f5f5
hi PmenuSbar guifg=#f5f5f5 guibg=#f5f5f5
hi TabLineSel guibg=#f5f5f5
hi Cursor guifg=#f5f5f5
hi Normal guibg=#f5f5f5
hi MatchParen guifg=#f5f5f5
hi Error guibg=#f5f5f5

hi clear TabLineFill
hi TabLineFill guibg=grey
]])

-- +============+
-- |  ftplugin  |
-- +============+

vim.api.nvim_create_augroup('my_markdown', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
	group = 'my_markdown',
	pattern = 'markdown',
	callback = function()
		vim.wo.conceallevel = 2
		vim.wo.foldlevel = 1
	end,
	desc = 'markdown "ftplugin" (by autocmd manually)'
})

