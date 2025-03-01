---@diagnostic disable: missing-fields
return {
	{
		"williamboman/mason.nvim",
    event = "VeryLazy",
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
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", -- lua
					"rust_analyzer", -- rust
					"ts_ls", -- typescript
					"emmet_language_server", -- emmet
					-- "emmet_ls", -- emmet
					-- "eslint", -- javascript
					"basedpyright", -- python
					"bashls", -- bash
					"tailwindcss", -- tailwind
					"zls", -- zig
					"clangd", -- cpp
				},
			})
			require("mason-tool-installer").setup({
				ensure_installed = {
					"prettier", -- js, ts & more formatter
					"stylua", -- lua formatter
					-- "ruff", -- python linter & formatter
					"biome", -- js & ts formatter
					-- "eslint_d", -- js formatter
					"clang-format", -- cpp & c formatter
					"marksman", -- markdown lsp
					-- "markdownlint-cli2", -- markdown linter
					"autopep8",
					"isort",
				},
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		lazy = true,
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
			ensure_installed = {
				"codelldb", -- c c++ rust zig
				"python", -- python
				"typescript", -- node
			},
		},
	},
}
