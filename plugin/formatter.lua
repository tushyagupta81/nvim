vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/stevearc/conform.nvim",
		})
		local conform = require("conform")

		conform.setup({
			formatters = {
				djlint = {
					args = {
						"--reformat",
						"--profile=django",
						"--stdin-filename",
						"$FILENAME",
						"-",
					},
					stdin = true,
				},
			},
			formatters_by_ft = {
				javascript = { "biome" },
				typescript = { "biome" },
				astro = { "prettierd" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				json = { "biome" },
				css = { "prettierd" },
				html = { "prettierd" },
				htmldjango = { "djlint" },
				yaml = { "prettierd" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				python = { "ruff_format", "isort" },
				cpp = { "clang-format" },
				markdown = { "mdformat" },
				toml = { "pyproject-fmt" },
				xml = { "xmlformatter" },
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = false,
			-- 	timeout_ms = 1000,
			-- },
		})

		vim.filetype.add({
			pattern = {
				[".*/templates/.*%.html"] = "htmldjango",
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
})
