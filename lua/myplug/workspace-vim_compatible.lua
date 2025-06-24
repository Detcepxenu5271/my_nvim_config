vim.keymap.set('n', '<leader>ew', ':sp $ws/.vimrc.workspace<cr>')
vim.keymap.set('n', '<leader>Ew', ':vs $ws/.vimrc.workspace<cr>')
vim.keymap.set('n', '<leader>sw', ':source $ws/.vimrc.workspace<cr>')

vim.cmd([[
if filereadable('.vimrc.workspace')
	source .vimrc.workspace
elseif exists('$ws') && filereadable($ws.'/.vimrc.workspace')
	exe 'source '.$ws.'/.vimrc.workspace'
endif
]])
