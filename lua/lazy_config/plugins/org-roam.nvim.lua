return {
	"chipsenkbeil/org-roam.nvim",
	--tag = "0.1.1",
	dependencies = {
		{
			"nvim-orgmode/orgmode",
			--tag = "0.3.7",
		},
	},
	config = function()
		require("org-roam").setup({
			directory = "~/orgfiles",
			-- optional
			-- org_files = {
			-- 	"~/another_org_dir",
			-- 	"~/some/folder/*.org",
			-- 	"~/a/single/org_file.org",
			-- },
			bindings = {
				prefix = "<LocalLeader>n",
				-- orgmode 占用 <Leader>Oc
				capture = "<Leader>Onc",
				find_node = "<Leader>Of",
			},
			extensions = {
				dailies = {
					directory = "journal",
					-- all global
					bindings = {
						capture_date = "<Leader>OdD",
						capture_today = "<Leader>OdN",
						capture_tomorrow = "<Leader>OdT",
						capture_yesterday = "<Leader>OdY",
						find_directory = "<Leader>Od.",
						goto_date = "<Leader>Odd",
						goto_next_date = "<Leader>Odf",
						goto_prev_date = "<Leader>Odb",
						goto_today = "<Leader>Odn",
						goto_tomorrow = "<Leader>Odt",
						goto_yesterday = "<Leader>Ody"
					}
				}
			}
		})
	end
}
