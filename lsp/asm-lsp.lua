return {
	cmd = { "asm-lsp" }, -- Ensure this is installed and in your PATH
	filetypes = { "asm", "nasm" }, -- Adjust for your preferred Assembly dialect
	root_marker = { ".git", "Makefile", "build.ninja" },
	settings = {
		asm = {
			includePaths = { "/usr/include", "/usr/local/include" }, -- Adjust for your system
			syntax = "nasm", -- Options: "nasm", "gas", etc.
		},
	},
}
