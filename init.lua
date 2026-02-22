-- ======== utils ========
-- utilities for config and in-nvim operations
-- PRINCIPLE:
--     1. normally is a module, should be required explicitly
--     2. recommended_builtin is required before all configs
--     3. myplug and plugins to share shouldn't use util (reduce dependency)
--         - TODO tabline.lua uses util.color or hardcoded color

-- load / setup some utils by default
require 'util.recommended_builtin'

-- ======== config ========
-- can't depend on each other

require 'config.abbreviation'
require 'config.autocmd'
require 'config.compatibility'
require 'config.diagnostics'
require 'config.filetype'
require 'config.keymap'
require 'config.lsp'
require 'config.option'
require 'config.treesitter'
require 'config.gui'

-- ======== myplug ========
-- my plugins

require 'myplug'

-- ======== notmyplug ========
-- random plugins originally from others (may be modified by myself)

require 'notmyplug'

-- ======== lazy.nvim ========
-- plugin management

-- 注意 lazy 配置模块不要与 lazy 重名
require 'lazy_config'

-- ======== local ========
-- local config

pcall(require, 'local')
