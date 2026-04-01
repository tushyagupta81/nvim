vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/jay-babu/mason-nvim-dap.nvim",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/mfussenegger/nvim-dap",
})
require("mason").setup({
	-- PATH = "append",
	ui = {
		border = "single",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})
require("mason-tool-installer").setup({
	ensure_installed = {
		-- Formatters and Linters
		"prettierd", -- html, css, etc
		"stylua", -- lua formatter
		"ruff", -- python linter & formatter
		"isort", -- python import sorter
		"biome", -- js & ts formatter
		-- "eslint_d", -- js formatter
		"clang-format", -- cpp & c formatter
		"marksman", -- markdown lsp
		-- "markdownlint-cli2", -- markdown linter
		"mdformat", -- markdown formatter
		"pyproject-fmt", -- toml formatter

		-- LSP's
		"lua-language-server", -- lua
		"rust-analyzer", -- rust
		"typescript-language-server", -- typescript
		"emmet-language-server", -- emmet
		-- "emmet_ls", -- emmet
		-- "eslint", -- javascript
		"basedpyright", -- python
		"bash-language-server", -- bash
		"tailwindcss-language-server", -- tailwind
		"zls", -- zig
		"clangd", -- cpp
		"xmlformatter", -- formatter for xml

		-- Debug adapters
		"codelldb", -- c c++ rust zig
		"debugpy", -- python
	},
})
