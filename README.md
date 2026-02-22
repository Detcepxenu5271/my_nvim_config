# My Neovim Config
修改 Readme

## Notice
My config use https to download lazy.nvim but ssh for all plugins under it, so you must ensure your ssh connection works, or change the relating config manually (in [lazy.lua](lua/lazy_config/init.lua)).

For Display, need true color and nerd font (e.g. UbuntuMono Nerd Font) in terminal (on Windows, recommend Windows Terminal).

LSP uses Nvim built-in with nvim-lspconfig plugin. For Nvim 0.11 or older, nvim-lspconfig provide `:LspStart` to enable specific lsp config and support completion. For newer version of Nvim (0.12 for now), use `:lsp enable` (seems it has bugs)

{!old!} LSP is disabled by default. To enable a specific LSP client, use my command `:LspEnable` or directly use `:lua vim.lsp.enable('...')` (they are the same except the former support completion of user specified config name).

