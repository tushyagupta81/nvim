---@type vim.lsp.Config
return {
	cmd = { "astro-ls", "--stdio" },
	filetypes = { "astro" },
	root_markers = { "astro.config.mjs", "astro.config.ts", "package.json", ".git" },
	single_file_support = true,
	init_options = {
		typescript = {
			tsdk = "./node_modules/typescript/lib",
		},
	},
	settings = {
		astro = {
			-- enable TypeScript and CSS diagnostics inside .astro files
			typescript = { enabled = true },
			css = { enabled = true },
		},
	},
}
