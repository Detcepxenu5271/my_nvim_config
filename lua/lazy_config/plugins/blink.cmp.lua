-- BUG? 在 return 里定义 config = function() ... end
--      会导致 blink.cmp 无法触发
vim.keymap.set('n', '<Leader>oC', function()
	if vim.b.completion == false then
		vim.b.completion = true
		print('[blink.cmp] enable completion')
	else
		vim.b.completion = false
		print('[blink.cmp] disable completion')
	end
end, {desc = "Toggle blink.cmp completion"})

return {
	'saghen/blink.cmp',

	enabled = true,

	event = 'VeryLazy',

	-- optional: provides snippets for the snippet source
	dependencies = { 'rafamadriz/friendly-snippets' },

	-- use a release tag to download pre-built binaries
	version = '1.*',
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--
		-- All presets have the following mappings:
		-- C-space: Open menu or open docs if already open
		-- C-n/C-p or Up/Down: Select next/previous item
		-- C-e: Hide menu
		-- C-k: Toggle signature help (if signature.enabled = true)
		--
		-- See :h blink-cmp-config-keymap for defining your own keymap
		keymap = {
			preset = 'default',
			-- my keymap:
			-- Tab to select next/prev -> snippet forward/backward
			-- Enter to accept/cancel (if use Windows Terminal
			--     (cancel returns to the initial input, while 'hide' remains the current text)
			-- Ctrl-B/F to scroll documentation up/down
			-- Ctrl-E also stops snippet
			['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
			['<C-e>'] = { 'hide', vim.snippet.stop, 'fallback' },
			['<C-y>'] = { 'select_and_accept', 'fallback' },
			['<CR>'] = { 'accept', 'fallback' },
			['<S-CR>'] = { 'cancel', 'hide_signature', 'fallback' },

			['<Up>'] = { 'select_prev', 'fallback' },
			['<Down>'] = { 'select_next', 'fallback' },
			-- change fallback_to_mappings to fallback, so that vim builtin <C-P>/<C-N> is used
			['<C-p>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'select_next', 'fallback' },
			['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback_to_mappings' },
			['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback_to_mappings' },

			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

			--['<Tab>'] = { 'snippet_forward', 'fallback' },
			--['<S-Tab>'] = { 'snippet_backward', 'fallback' },

			['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
		},

		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'normal'
		},

		-- (Default) Only show the documentation popup when manually triggered
		completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 0,
				window = {
					border = 'single'
				}
			},
			menu = {
				-- Don't automatically show the completion menu
				auto_show = true,
				max_height = 20,
				-- nvim-cmp style menu
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 },
						{ "kind_icon", "kind" }
					},
					treesitter = { 'lsp' }
				},
				border = 'none'
			},
			list = {
				selection = {
					preselect = function(ctx)
						return vim.bo.filetype == 'cpp'
						    or vim.bo.filetype == 'lua'
					end,
					auto_insert = true
				}
			},
			-- Display a preview of the selected item on the current line
			ghost_text = { enabled = false },
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		sources = {
			default = { 'lsp', 'buffer', 'snippets', 'path' },
			-- orgmode: https://github.com/nvim-orgmode/orgmode
			-- [Experimental] use LSP, disable custom source settings
			-- per_filetype = {
			-- 	org = {'orgmode', 'buffer', 'snippets', 'path'}
			-- },
			providers = {
				path = {
					-- from cwd instead of current buffer's directory
					opts = {
						get_cwd = function(_)
							return vim.fn.getcwd()
						end,
					},
				},
				orgmode = {
					name = 'Orgmode',
					module = 'orgmode.org.autocompletion.blink',
					-- fallbacks 似乎没有作用, 暂时不知道为什么, 所以放到了 per_filetype 里
					--fallbacks = { 'buffer', 'snippets', 'path' },
				},
			},
		},

		-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
		-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
		-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
		--
		-- See the fuzzy documentation for more information
		fuzzy = { implementation = "prefer_rust_with_warning" },

		cmdline = {
			-- BUG external (shell) command causes stuck (when type :! then other key, nvim stuck until CTRL-C)
			-- https://github.com/Saghen/blink.cmp/issues/1926
			enabled = false,
		},

		signature = {
			enabled = true,
			window = {
				show_documentation = false,
				border = 'double'
			}
		},
	},
	opts_extend = { "sources.default" },
}

