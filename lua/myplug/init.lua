-- nvim
local myplug_path = vim.fn.stdpath('config')..'/lua/myplug'

-- basic utils
vim.cmd('source '..myplug_path..'/edit-utils.lua')
vim.cmd('source '..myplug_path..'/buffer-utils.vim')
vim.cmd('source '..myplug_path..'/misc-utils.lua')

-- language utils
vim.cmd('source '..myplug_path..'/markdown-utils.vim')
vim.cmd('source '..myplug_path..'/cxx-utils.lua')

-- UI
vim.cmd('source '..myplug_path..'/statusline.vim')
vim.cmd('source '..myplug_path..'/tabline.vim')
vim.cmd('source '..myplug_path..'/foldtext.vim')
vim.cmd('source '..myplug_path..'/echo_status.lua')

vim.cmd('source '..myplug_path..'/workspace-vim_compatible.lua')

