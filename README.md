# My Neovim Config
#TODO

## Notice
My config use ssh to download lazy.nvim and all plugins under it, so you must ensure your ssh connection works, or change the relating config manually (in [lazy.lua](lua/lazy_config/init.lua)).

For Display, need true color and nerd font (recommend UbuntuMono Nerd Font) in terminal (recommend Windows Terminal).

LSP is disabled by default. To enable the specific LSP client, add config in [lsp](lua/config/lsp.lua) or use `:lua vim.lsp.enable('...')` manually.

