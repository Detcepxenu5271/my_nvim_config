return {
	'nvim-orgmode/orgmode',
	event = 'VeryLazy',
	config = function()
		-- Setup orgmode
		require('orgmode').setup({
			org_adapt_indentation = false,
			org_agenda_files = '~/orgfiles/**/*',
			org_capture_templates = {
				r = {
					-- https://nvim-orgmode.github.io/tutorial#captures
					description = "Repo",
					template = "* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?",
					target = "~/orgfiles/repos.org",
				}
			},
			org_default_notes_file = '~/orgfiles/refile.org',
			org_hide_emphasis_markers = true,
			-- 'native' or 'entities':
			-- ATTENTION! If use nvim-treesitter, set highlight.additional_vim_regex_highlighting to false or add org to the list
			--            Because now inline latex requires vim regex syntax
			org_highlight_latex_and_related = "entities",
			org_id_link_to_org_use_id = true,
			--org_indent_mode_turns_on_hiding_stars = true,
			org_startup_indented = false,
			org_tags_column = 0,
			org_todo_keywords = {'TODO(t)', 'NEXT(n)', '|', 'DONE(d)', 'CANCEL(c)'},
			org_use_tag_inheritance = true,
			mappings = {
				prefix = '<LocalLeader>',
				org_return_uses_meta_return = false,
				global = {
					org_agenda = '<leader>Oa',
					org_capture = '<leader>Oc',
				},
				org = {
					-- now use <C-n> to replace <C-i> (same as <Tab>)
					--org_cycle = 'za',
					--org_global_cycle = 'zA',
				},
			}
		})
		-- Set meta return
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'org',
			callback = function()
				vim.keymap.set('i', '<S-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
					silent = true,
					buffer = true,
				})
			end,
		})
	end,
}
