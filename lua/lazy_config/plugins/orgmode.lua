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
			org_agenda_custom_commands = {
				T = {
					description = 'TODO (not include NEXT)',
					types = {
						{
							type = 'tags_todo',
							-- match = '/TODO|RUNNING',
							match = '/-NEXT',
							org_agenda_overriding_header = 'Global list of TODO items of type: ALL but NEXT',
						},
					},
				},
			},
			org_agenda_files = vim.env.org_path..'/**/*.org',
			org_agenda_time_grid = {
				type = { 'daily', 'today', 'require-timed' },
				times = { 800, 1000, 1200, 1400, 1600, 1800, 2000 },
				time_separator = '┄┄┄┄┄',
				time_label = '┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄',
			},
			org_agenda_use_time_grid = true,
			org_archive_location = vim.env.org_path..'/archive/%s_archive::',
			org_capture_templates = {
				d = {
					description = "Default",
					template = "* %^{PROMPT}",
					target = vim.env.org_path.."/refile.org"
				},
				-- r = {
				-- 	-- https://nvim-orgmode.github.io/tutorial#captures
				-- 	description = "Repo",
				-- 	template = "* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?",
				-- 	target = vim.env.org_path.."/repos.org",
				-- }
			},
			org_default_notes_file = vim.env.org_path..'/refile.org',
			org_hide_emphasis_markers = true,
			-- 'native' or 'entities':
			-- native: see org as latex
			-- entities: only see as latex in $$, \(\), ...
			-- ATTENTION! If use nvim-treesitter, set highlight.additional_vim_regex_highlighting to false or add org to the list
			--            Because now inline latex requires vim regex syntax
			--            {update} Now (nvim-treesitter at main) no need
			-- enable this config will cause syntax works alongside treesitter, which may be bad
			-- org_highlight_latex_and_related = "entities",
			org_id_link_to_org_use_id = true,
			--org_indent_mode_turns_off_org_adapt_indentation = true,
			--org_indent_mode_turns_on_hiding_stars = true,
			org_startup_indented = true,
			org_tags_column = 0,
			-- org_tags_exclude_from_inheritance = {'cur', 'refile'},
			org_todo_keywords = {'TODO(t)', 'NEXT(n)', 'RUNNING(r)', '|', 'DONE(d)', 'CANCEL(c)'},
			org_use_tag_inheritance = false,
			hyperlinks = {
				sources = {
					-- Zotero Link
					{
						get_name = function() return 'zotero' end,
						follow = function(self, link)
							if not vim.startswith(link, 'zotero://') then
								return false
							end
							vim.ui.open(link)
							return true
						end,
						-- autocomplete = function(self, link)
						-- 	local items = {
						-- 		'zotero://select/library/items/',
						-- 	}
						-- 	return vim.tbl_filter(function(item) return vim.startswith(item, link) end, items)
						-- end,
					},
				},
			},
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
					-- org-roam.nvim use prefix + naa/nar
					--org_add_note = false,
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
				-- if <S-CR> isn't supported, <M-CR> can
				vim.keymap.set('i', '<M-CR>', '<cmd>lua require("orgmode").action("org_mappings.meta_return")<CR>', {
					silent = true,
					buffer = true,
				})
			end,
		})
		-- search headline of orgfiles
		-- TODO 改为自定义命令, 并支持指定大纲层级
		--vim.api.nvim_create_user_command('OrgFindHeadline', function ()
		--end, {desc = 'Find Org Headlines'})

		-- 小写 f: 搜全部标题
		--vim.keymap.set('n', '<Leader>Of', [[:tab sp<CR>:silent grep -t org '^\*+ ' ]]..vim.env.org_path..[[<CR>:tc %:p:h<CR>:copen<CR>]])
		-- rewrite and add feature by AI:
		vim.keymap.set('n', '<Leader>Of', function()
			local buf = vim.api.nvim_get_current_buf()
			local is_fresh = vim.api.nvim_buf_get_name(buf) == ''
				and vim.bo[buf].buftype == ''
				and not vim.bo[buf].modified
				and vim.api.nvim_buf_line_count(buf) == 1
				and vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1] == ''

			if not is_fresh then
				vim.cmd('tab split')
			end

			vim.cmd([[silent grep -t org '^\*+ ' ]] .. vim.fn.fnameescape(vim.env.org_path))
			vim.cmd('tc ' .. vim.fn.fnameescape(vim.env.org_path))
			vim.cmd('copen')
		end)

		-- open refile.org
		vim.keymap.set('n', '<Leader>Or', ':sp $org_path/refile.org<CR>')

		-- [Experimental] LSP
		vim.lsp.enable('org')

		-- [Notice] other file-related settings are in after/ftplugin/org.lua
	end,
}
