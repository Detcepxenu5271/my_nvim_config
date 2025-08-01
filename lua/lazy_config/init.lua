-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	--local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local lazyrepo = "git@github.com:folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
if vim.g.mapleader == nil then
		vim.g.mapleader = " "
end
if vim.g.maplocalleader == nil then
		vim.g.maplocalleader = "\\"
end

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "lazy_config/plugins" },
	},
	git = {
		url_format = "git@github.com:%s.git",
		--allow_local_modifications = true, -- AI 推荐的配置, 不知道是否存在
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "quietlight", "myshine", "default" } },
	-- automatically check for plugin updates
	checker = { enabled = true }
})

