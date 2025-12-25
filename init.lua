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

-- ======== 外 观 (ui) ========

vim.opt.complete:append('k')
vim.opt.complete:append('s')
vim.opt.complete:remove('u')
vim.opt.completeopt:append('longest')
vim.opt.cursorline = true
vim.opt.equalalways = false
vim.opt.ignorecase = true
vim.opt.jumpoptions:append('stack')
vim.opt.lazyredraw = true;
vim.opt.list = true
vim.opt.listchars = {tab = '│ ', trail = 'X'}
vim.opt.nrformats:append('alpha')
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitkeep = 'screen'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.virtualedit:append('block')
vim.opt.wrapscan = false

-- ======== 文 件 (file) ========

vim.opt.backup = true
vim.opt.backupdir:remove('.')
vim.opt.swapfile = true
vim.opt.undofile = true

-- ======== 命 令 行 (cmdline) ========

vim.opt.wildmode = {'longest', 'full'}
vim.opt.wildoptions:append('fuzzy')

-- ======== 其 他 (else) ========

vim.opt.keywordprg = ':help'
vim.opt.timeout = false

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

vim.keymap.set('n', 'M', function()
	vim.cmd([[
		exe 'tabe' stdpath('data')..'/meta.txt'
		exe 'tc' stdpath('data')
		setl foldmethod=indent
	]])
end, {desc = 'Meta Command'})

-- ======== Leader ========

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set('n', '<leader>', '<nop>')

vim.keymap.set('n', '<leader>/', ":let @/='\\<'..input('Search word: ')..'\\>'<CR>")
vim.keymap.set('n', '<leader>a', 'i<space><esc>la<space><esc>l')
vim.keymap.set('n', '<leader>d', '<nop>')
vim.keymap.set('n', '<leader>dd', [[:exe "lc" substitute(expand('%:p:h'), '^\w\+://', '', '') | pwd<cr>]])
vim.keymap.set('n', '<leader>dt', [[:exe "tc" substitute(expand('%:p:h'), '^\w\+://', '', '') | pwd<cr>]])
vim.keymap.set('n', '<leader>dw', ':tc $ws | pwd<cr>')
vim.keymap.set('n', '<leader>E', '<nop>')
vim.keymap.set('n', '<leader>e', '<nop>')
vim.keymap.set('n', '<leader>eb', ':buffers<cr>:sb<space>')
vim.keymap.set('n', '<leader>Eb', ':buffers<cr>:vert sb<space>')
vim.keymap.set('n', '<leader>er', ':browse oldfiles<cr>')
vim.keymap.set('n', '<leader>ev', ':sp $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>Ev', ':vs $MYVIMRC<cr>')
vim.keymap.set('n', '<Leader>I', ':Inspect<CR>')
vim.keymap.set('n', '<leader>o', '<nop>')
vim.keymap.set('n', '<leader>oc', function ()
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
vim.keymap.set('n', '<leader>oh', ':noh<cr>', {silent = true})
vim.keymap.set('n', '<leader>on', function()
	if vim.o.number then
		vim.o.number = false
		vim.o.relativenumber = false
	else
		vim.o.number = true
		vim.o.relativenumber = true
	end
end)
vim.keymap.set('n', '<leader>ot', ':let &showtabline = 3-&showtabline | setl showtabline?<cr>')
vim.keymap.set('n', '<leader>ow', ':setl wrap! wrap?<cr>')
vim.keymap.set('n', '<leader>sv', ':source $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>w', '<c-w>')
vim.keymap.set('v', '<leader>a', 'c<space><c-r>"<space><esc>')

-- ======== Insert 模式下的 "leader" ========

vim.keymap.set('i', 'jl==', '<esc>vBdi<c-r>=<c-r>"<cr>')
vim.keymap.set('i', 'jl=e', '<space><esc>yBEls=<c-r>=<c-r>0<cr>')

-- ======== 移 动 (motion) ========

vim.keymap.set('c', '<c-a>', '<home>')
vim.keymap.set('c', '<c-b>', '<left>')
vim.keymap.set('c', '<c-f>', '<right>')
vim.keymap.set('i', '<c-a>', '<home>')
vim.keymap.set('i', '<c-b>', '<left>')
vim.keymap.set('i', '<c-e>', '<end>')
vim.keymap.set('i', '<c-f>', '<right>')
vim.keymap.set('n', '<C-n>', '<C-i>')
vim.keymap.set({'n', 'v', 'o'}, 'j', 'gj')
vim.keymap.set({'n', 'v', 'o'}, 'k', 'gk')
vim.keymap.set({'n', 'v', 'o'}, 'gj', 'j')
vim.keymap.set({'n', 'v', 'o'}, 'gk', 'k')
vim.keymap.set({'n', 'v', 'o'}, 'gH', '0')
vim.keymap.set({'n', 'v', 'o'}, 'gL', '$')
vim.keymap.set({'n', 'v', 'o'}, 'H', 'g0')
vim.keymap.set({'n', 'v', 'o'}, 'L', 'g$')

-- ======== 编 辑 (edit) ========

vim.keymap.set('c', '<c-l>', '<del>')
vim.keymap.set('i', '<c-l>', '<del>')

-- 补全
vim.keymap.set('i', '<C-o>', '<C-x><C-o>')

-- nvim-surround 功能简单代替
vim.keymap.set('v', 'S', function()
	local ch = vim.fn.nr2char(vim.fn.getchar())
	local chl, chr
	if ch=='(' or ch==')' then
		chl = '('
		chr = ')'
	elseif ch=='<' or ch=='>' then
		chl = '<'
		chr = '>'
	elseif ch=='[' or ch==']' then
		chl = '['
		chr = ']'
	elseif ch=='{' or ch=='}' then
		chl = '{'
		chr = '}'
	else
		chl = ch
		chr = ch
	end
	vim.cmd([[exe "norm! v`>a]]..chr..[[\<Esc>`<i]]..chl..[["]])
end)

-- ======== 查看 (view) ========

vim.keymap.set('n', '<Tab>', 'za')

-- ======== 窗口 (window) ========

vim.keymap.set('n', '+', '<c-w>>')
vim.keymap.set('n', '-', '<c-w>-')
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-l>', '<c-w>l')
vim.keymap.set('n', '=', '<c-w>+')
vim.keymap.set('n', '_', '<c-w><')

-- ======== esc 绑定 ========

vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('t', 'jk', '<c-\\><c-n>')

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
vim.opt.background='light'
vim.cmd([[
hi Cursor guifg=#f5f5f5
hi CursorLineNr guibg=#a8a8a8
hi DiffAdd guifg=#f5f5f5
hi DiffChange guifg=#f5f5f5
hi DiffDelete guifg=#f5f5f5
hi Error guibg=#f5f5f5
hi LineNr guibg=#e8e8e8
hi MatchParen guifg=#f5f5f5
hi ModeMsg guibg=#f5f5f5
hi MoreMsg guibg=#f5f5f5
hi NonText guibg=NONE
hi Normal guibg=#f5f5f5
hi NormalNC guibg=#e8e8e8
hi PmenuSbar guifg=#f5f5f5 guibg=#f5f5f5
hi Search guifg=#f5f5f5
hi StatusLine gui=bold guifg=black guibg=lightgrey
hi StatusLineNC guifg=#f5f5f5
hi TabLineSel guibg=#f5f5f5
hi WarningMsg guibg=#f5f5f5
hi link WinSeperator Normal

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
function! MyStatusLine()
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
]])

local bg_color = '#808080'
local white = '#f5f5f5'
local black = '#14161b'
local green = '#448c27'
local purple = '#7a3e9d'
local orange = '#ab6526'
local brighter_orange = '#d18a2e'
local red = '#aa3731'
local blue = '#4b69c6'

vim.api.nvim_set_hl(0, "ModeNormal", { fg = white, bg = blue })
vim.api.nvim_set_hl(0, "ModeInsert", { fg = white, bg = green })
vim.api.nvim_set_hl(0, "ModeVisual", { fg = white, bg = orange })
vim.api.nvim_set_hl(0, "ModeCmdline", { fg = white, bg = brighter_orange })
vim.api.nvim_set_hl(0, "ModeReplace", { fg = white, bg = red })
vim.api.nvim_set_hl(0, "ModeOperatorPending", { fg = white, bg = purple })
vim.api.nvim_set_hl(0, "ModeTerminal", { fg = white, bg = black })

local mode_info_str = {
	n = "%#ModeNormal# NOM ",
	i = "%#ModeInsert# INS ",
	v = "%#ModeVisual# VIS ",
	V = "%#ModeVisual# V-L ",
	[''] = "%#ModeVisual# V-B ",
	c = "%#ModeCmdline# CMD ",
	R = "%#ModeReplace# RPL ",
	Rv = "%#ModeVirtualReplace# R-V ",
	no = "%#ModeOperatorPending# OPD ",
	t = "%#ModeTerminal# TER ",
	nt = "%#ModeNormal# TNO ",
}

local function tab_has_modified_buffers(tabnr)
	local tabinfo = vim.fn.gettabinfo(tabnr)
	if vim.tbl_isempty(tabinfo) then
		return false
	end
	for _, winid in ipairs(tabinfo[1].windows) do
		local bufnr = vim.fn.winbufnr(winid)
		if vim.bo[bufnr].modified then
			return true
		end
	end
	return false
end

function _G.my_tabline()
	local s = {}
	local current_tab = vim.fn.tabpagenr()
	for i = 1, vim.fn.tabpagenr('$') do
		local tab_hi, tabnr_hi
		if i == current_tab then
			tab_hi = '%#TabLineSel#'
			tabnr_hi = '%#TabLineSel#'
		else
			tab_hi = '%#TabLine#'
			tabnr_hi = '%#TabLine#'
		end

		table.insert(s, '%'..i..'T')

		local buflist = vim.fn.tabpagebuflist(i)
		local winnr = vim.fn.tabpagewinnr(i)

		table.insert(s, tab_hi..' ')
		table.insert(s, tabnr_hi..'['..i)
		if tab_has_modified_buffers(i) then
			table.insert(s, '+')
		end
		table.insert(s, ']')

		local cwd = vim.fn.fnamemodify(vim.fn.getcwd(-1, i), ':t')
		table.insert(s, tab_hi..' '..cwd..'/')
		if #buflist > 1 then
			table.insert(s, '('..#buflist..')')
		end

		table.insert(s, ' ')
	end
	table.insert(s, '%#TabLineFill#%T')
	table.insert(s, '%=')
	table.insert(s, mode_info_str[vim.api.nvim_get_mode().mode])
	if vim.fn.tabpagenr('$') > 1 then
		table.insert(s, '%#TabLine#%999XX')
	end

	return table.concat(s)
end

vim.opt.tabline = '%!v:lua.my_tabline()'

vim.api.nvim_create_augroup('myplug_tabline', { clear = true })
vim.api.nvim_create_autocmd('ModeChanged', {
	group = 'myplug_tabline',
	callback = function()
		vim.cmd('redrawtabline')
	end
})

-- +=================+
-- |  compatibility  |
-- +=================+

if string.find(vim.o.shell, 'bash') or string.find(vim.o.shell, 'zsh') then
	vim.o.shellcmdflag = '-c'
	vim.o.shellslash = true
	if vim.fn.has('win32') then
		vim.o.shellquote = ''
		vim.o.shellxquote = ''
	end
elseif string.find(vim.o.shell, 'cmd') then
	vim.o.shellcmdflag = '/c'
elseif string.find(vim.o.shell, 'powershell') then
	vim.o.shellcmdflag = '-Command'
end

