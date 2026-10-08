return {
	settings = {
		pylsp = {
			plugins = {
				jedi = {
					-- bug: some numpy modules don't have hover (e.g. np.random)
					auto_import_modules = {},
				},
			}
		}
	}
}
