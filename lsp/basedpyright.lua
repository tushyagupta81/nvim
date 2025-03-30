return {
	cmd = { "basedpyright-langserver", "--stdio" },
	root_markers = { ".git", "requirements.txt", "pyproject.toml", "uv.lock", ".venv" },
	filetypes = { "python" },
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				autoImportCompletions = true,
				diagnosticsMode = "openFilesOnly",
			},
		},
	},
}
