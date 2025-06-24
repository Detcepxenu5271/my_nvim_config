local myplug_path = '$HOME/.config/nvim/lua/myplug'

vim.cmd('source '..myplug_path..'/buffer-utils.vim')

vim.cmd('source '..myplug_path..'/markdown-utils.vim')
vim.cmd('source '..myplug_path..'/cxx-utils.lua')

vim.cmd('source '..myplug_path..'/statusline.vim')
vim.cmd('source '..myplug_path..'/tabline.vim')
--vim.cmd('source '..myplug_path..'/mode_status.lua')

vim.cmd('source '..myplug_path..'/workspace-vim_compatible.lua')

