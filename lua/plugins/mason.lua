---@diagnostic disable: missing-fields
return {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
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
				"prettier", -- js, ts & more formatter
				"stylua", -- lua formatter
				"ruff", -- python linter & formatter
				"biome", -- js & ts formatter
				-- "eslint_d", -- js formatter
				"clang-format", -- cpp & c formatter
				"marksman", -- markdown lsp
				-- "markdownlint-cli2", -- markdown linter

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

				-- Debug adapters
				"codelldb", -- c c++ rust zig
				"debugpy", -- python
			},
		})
	end,
}
