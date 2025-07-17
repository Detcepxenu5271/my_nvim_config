-- ======== config ========
-- can't depend on each other

require 'config.abbreviation'
require 'config.autocmd'
require 'config.diagnostics'
require 'config.filetype'
require 'config.keymap'
require 'config.lsp'
require 'config.option'

-- ======== myplug ========
-- my plugins

require 'myplug'

-- ======== lazy.nvim ========
-- plugin management

-- 注意 lazy 配置模块不要与 lazy 重名
require 'lazy_config'

-- ======== lazy.nvim ========
-- local config

require 'local'
