local myplug_path = vim.fn.stdpath('config')..'/lua/myplug'

-- basic utils
vim.cmd('source '..myplug_path..'/buffer-utils.vim')
require 'myplug.misc-utils'

-- language utils
vim.cmd('source '..myplug_path..'/markdown-utils.vim')
require 'myplug.cxx-utils'

-- UI
vim.cmd('source '..myplug_path..'/statusline.vim')
vim.cmd('source '..myplug_path..'/tabline.vim')
vim.cmd('source '..myplug_path..'/foldtext.vim')
require 'myplug.echo_status'

require 'myplug.workspace-vim_compatible'

