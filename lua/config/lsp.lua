vim.lsp.enable('lua-ls')
vim.lsp.enable('clangd')
vim.lsp.enable('vimls')

vim.keymap.set('n', 'grd', vim.lsp.buf.definition)

-- ======== highlight ========

-- 引入自定义颜色模块
local C = require('util.color')
-- 自定义高亮的简写
local hi = vim.api.nvim_set_hl

-- Signature 对当前参数的高亮, 改为更显眼的红色
hi(0, 'LspSignatureActiveParameter', {fg = C:getcolor('ql_red')})

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
