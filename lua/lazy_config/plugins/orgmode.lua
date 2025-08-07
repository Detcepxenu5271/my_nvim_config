return {
	'nvim-orgmode/orgmode',
	event = 'VeryLazy',
	config = function()
		if not vim.env.org_path then
			vim.env.org_path = '~/orgfiles'
		end
		-- Setup orgmode
		require('orgmode').setup({
			org_adapt_indentation = false,
			org_agenda_files = vim.env.org_path..'/**/*.org',
			org_archive_location = vim.env.org_path..'/archive/%s_archive::',
			org_capture_templates = {
				d = {
					description = "Default",
					template = "* %^{PROMPT}",
					target = vim.env.org_path.."/refile.org"
				},
				r = {
					-- https://nvim-orgmode.github.io/tutorial#captures
					description = "Repo",
					template = "* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?",
					target = vim.env.org_path.."/repos.org",
				}
			},
			org_default_notes_file = vim.env.org_path..'/refile.org',
			org_hide_emphasis_markers = true,
			-- 'native' or 'entities':
			-- native: see org as latex
			-- entities: only see as latex in $$, \(\), ...
			-- ATTENTION! If use nvim-treesitter, set highlight.additional_vim_regex_highlighting to false or add org to the list
			--            Because now inline latex requires vim regex syntax
			org_highlight_latex_and_related = "entities",
			org_id_link_to_org_use_id = true,
			--org_indent_mode_turns_off_org_adapt_indentation = true,
			--org_indent_mode_turns_on_hiding_stars = true,
			org_startup_indented = true,
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
		-- search headline of orgfiles
		-- TODO 改为自定义命令, 并支持指定大纲层级
		--vim.api.nvim_create_user_command('OrgFindHeadline', function ()
		--end, {desc = 'Find Org Headlines'})
		vim.keymap.set('n', '<Leader>Of', [[:tab sp<CR>:silent grep '^\*+ ' ]]..vim.env.org_path..[[/**/*.org<CR>:tc %:p:h<CR>:copen<CR>]])
		-- open refile.org
		vim.keymap.set('n', '<Leader>Or', ':sp $org_path/refile.org<CR>')

		vim.keymap.set('ca', 'pott', ":\\zs\\w\\+\\ze:<C-r>=Eatchar('\\s')<CR>", {desc = 'Pattern of Org Tag'})
	end,
}
