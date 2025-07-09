# My Neovim Config
#TODO

## Notice
My config use ssh to download lazy.nvim and all plugins under it, so you must ensure your ssh connection works, or change the relating config manually (in [lazy.lua](lua/config/lazy.lua)).

For Display, need true color and nerd font (recommend UbuntuMono Nerd Font) in terminal (recommend Windows Terminal).

LSP is enabled by default. If you don't have the LSP server, disable the corresponding config in `lua/config/lsp.lua`.

## TODO
* [X] Add branch of minimal config for installing on other environment. Plugins and the relevant dependences are disabled by default, to minimize errors.
    - [ ] Optimize this config (reconfig, from disable everywhere to no plugin and dependences at first)
* [ ] #QUE Use nvim-lspconfig rather than config lsp myself

