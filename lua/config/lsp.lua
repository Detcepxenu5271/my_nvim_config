--vim.lsp.enable('lua-ls')
--vim.lsp.enable('clangd')
--vim.lsp.enable('vimls')
--vim.lsp.enable('jsonls')
--vim.lsp.enable('pico8_ls')

local lsp_attach = vim.api.nvim_create_augroup('lsp-attach', {clear = true})

-- from: https://github.com/patricorgi/dotfiles/blob/main/.config/nvim/lua/custom/lsp.lua
vim.api.nvim_create_autocmd('LspAttach', {
	group = lsp_attach,
	callback = function (event)
		-- obtain LSP client
		-- (Why and why cli
		--local client = vim.lsp.get_client_by_id(event.data.client_id)
		vim.keymap.set('n', 'grd', vim.lsp.buf.definition, {buffer = true})
		vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, {buffer = true})
	end
})

-- ======== 其他 ========

-- https://github.com/HCY-ASLEEP/NVIM-Config
-- 使用默认的 omnifunc 进行自动补全
--vim.cmd([[
--set completeopt=menuone,noselect
--" hide commplete info under the statusline
--set shortmess+=c
--
--function! OpenFilePathCompletion()
--    if v:char =~ '[/]' && !pumvisible()
--        call feedkeys("\<C-x>\<C-f>", "n")
--    endif
--endfunction
--
--function! OpenNoLSPCompletion()
--    if v:char =~ '[A-Za-z_]' && !pumvisible() 
--        call feedkeys("\<C-n>", "n")
--    endif
--endfunction
--
--augroup openFilePathCompletion
--    autocmd!
--    autocmd InsertCharPre * silent! call OpenFilePathCompletion()
--augroup END
--
--augroup openNoLSPCompletion
--    autocmd!
--    autocmd InsertCharPre * silent! call OpenNoLSPCompletion()
--augroup END
--
--inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
--inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
--
--" use up and down keys for navigating the autocomplete menu
--inoremap <expr> <down> pumvisible() ? "\<C-n>" : "\<down>"
--inoremap <expr> <up> pumvisible() ? "\<C-p>" : "\<up>"
--]])
