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
--vim.cmd('packadd! termdebug')

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
map('n', '<leader>oc', function ()
	local state = (vim.o.cursorline and 1 or 0) + (vim.o.cursorcolumn and 1 or 0)
	state = (state + 1) % 3
	if state == 0 then
		vim.o.cursorline = false; vim.o.cursorcolumn = false
	elseif state == 1 then
		vim.o.cursorline = true; vim.o.cursorcolumn = false
	else
		vim.o.cursorline = true; vim.o.cursorcolumn = true
	end
end)
map('n', '<leader>oh', ':noh<cr>', {silent = true})
map('n', '<leader>on', function()
	if vim.o.number then
		vim.o.number = false
		vim.o.relativenumber = false
	else
		vim.o.number = true
		vim.o.relativenumber = true
	end
end)
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
map({'n', 'v', 'o'}, 'j', 'gj')
map({'n', 'v', 'o'}, 'k', 'gk')
map({'n', 'v', 'o'}, 'gj', 'j')
map({'n', 'v', 'o'}, 'gk', 'k')
map({'n', 'v', 'o'}, 'gH', '0')
map({'n', 'v', 'o'}, 'gL', '$')
map({'n', 'v', 'o'}, 'H', 'g0')
map({'n', 'v', 'o'}, 'L', 'g$')

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
vim.keymap.set('ca', 'ee', "expand('')<Left><Left><C-r>=Eatchar('\\s')<CR>")
vim.keymap.set('ca', 'dd', '%:p:h')
vim.keymap.set('ca', 'ptt', "<[^>]\\+><C-r>=Eatchar('\\s')<CR>")
vim.keymap.set('ca', 'll', "<lt>Leader><C-r>=Eatchar('\\s')<CR>")
vim.keymap.set('ca', 'lll', "<lt>LocalLeader><C-r>=Eatchar('\\s')<CR>")

-- +===========+
-- |  command  |
-- +===========+

vim.api.nvim_create_user_command('ReverseLine', [[exe "keepp '<,'>g/^/m "..(line("'<")-1)]], {desc = 'reverse previous selected lines'})

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

vim.api.nvim_create_autocmd('InsertEnter', {
	group = 'my_autocmd',
	pattern = '*',
	callback = function()
		if vim.o.number then
			vim.o.relativenumber = false
		end
	end,
	desc = 'use norelativenumber in insert mode'
})

vim.api.nvim_create_autocmd('InsertLeave', {
	group = 'my_autocmd',
	pattern = '*',
	callback = function()
		if vim.o.number then
			vim.o.relativenumber = true
		end
	end,
	desc = 'use relativenumber in normal mode'
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
hi NormalNC guibg=#e8e8e8
hi NonText guibg=NONE
hi Search guifg=#f5f5f5
hi MoreMsg guibg=#f5f5f5
hi ModeMsg guibg=#f5f5f5
hi StatusLine gui=bold guifg=black guibg=lightgrey
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

-- +===========+
-- |  myplugs  |
-- +===========+

vim.cmd([[
" foldtext
function! FoldText()
	let line = getline(v:foldstart)
	let line = substitute(line, '^\t\+', '\=repeat(" ", len(submatch(0)) * &l:tabstop)', '')
	let line = substitute(line, '\s*$', '', 'g')

	let win_width = winwidth(0)
	if &number || &relativenumber
		let win_width -= max([&numberwidth, strlen(line('$')) + 1])
	endif

	let numOfLines = v:foldend - v:foldstart + 1
	let numIndicator = numOfLines . ' LINES'

	let indicator_width = strdisplaywidth(numIndicator)
	let max_line_width = win_width - indicator_width - 2
	if strdisplaywidth(line) > max_line_width
		if strdisplaywidth(line) <= 3
			let line = repeat('.', strdisplaywidth(line))
		else
			let line = strpart(line, 0, max_line_width-3)..'...'
		endif
	endif

	let padding = max([win_width - strdisplaywidth(line) - indicator_width, 1])

	return line . repeat(' ', padding) . numIndicator
endfunction

set foldtext=FoldText()

" statusline
function MyStatusLine()
	let s:statusline = ''

	if win_getid() == g:statusline_winid
		let s:statusline ..= '[%n]'
		let s:statusline ..= '%<%f'
		let s:statusline ..= '%r%m'

		let s:statusline ..= '%= '
		let s:statusline ..= '|%B'
		let s:statusline ..= '|%v'
		let s:statusline ..= '|%Y'
		let s:statusline ..= '|%2p%%'
	else
		let s:statusline ..= '[%n]'
		let s:statusline ..= '%<%f'
		let s:statusline ..= '%r%m'
	endif
	
	return s:statusline
endfunction

set statusline=%!MyStatusLine()

" tabline
function! TabHasModifiedBuffers(tabnr)
	let tabinfo = gettabinfo(a:tabnr)
	if empty(tabinfo) | return 0 | endif

	return len(filter(tabinfo[0].windows, 'getbufvar(winbufnr(v:val), "&modified")')) > 0
endfunction

function! MyTabLine()
	let s = ''
	for i in range(tabpagenr('$'))
		if i+1 == tabpagenr()
			let tab_hi = '%#TabLineSel#'
			let tabnr_hi = '%#TabLineSel#'
		else
			let tab_hi = '%#TabLine#'
			let tabnr_hi = '%#TabLine#'
		endif

		let s ..= '%' .. (i+1) .. 'T'

		let buflist = tabpagebuflist(i+1)
		let winnr = tabpagewinnr(i+1)

		let s ..= tab_hi .. ' '
		let s ..= tabnr_hi .. '[' .. (i+1)
		if TabHasModifiedBuffers(i+1) | let s ..= '+' | endif
		let s ..= ']'
		let s ..= tab_hi .. ' ' .. fnamemodify(getcwd(winnr, i+1), ':t') .. '/'
		let s ..= (len(buflist) > 1 ? '('..len(buflist)..')' : '')
		let s ..= ' '
	endfor

	let s ..= '%#TabLineFill#%T'
	if tabpagenr('$') > 1
		let s ..= '%=%#TabLine#%999XX'
	endif

	return s
endfunction

set tabline=%!MyTabLine()
]])

