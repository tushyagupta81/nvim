return {
	cmd = { "neocmakelsp", "stdio" },
	filetypes = { "cmake" },
	root_markers = { ".git", "build", "cmake" },
	init_options = {
		buildDirectory = "build",
		format = {
			enable = true,
		},
		lint = {
			enable = true,
		},
		completion = {
			enable = true,
		},
		diagnostics = {
			enable = true,
		},
	},
	settings = {
		capabilities = {
			workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
					relative_pattern_support = true,
				},
			},
		},
	},
}
