return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"j-hui/fidget.nvim",
		"saghen/blink.cmp",
	},
	event = "LspAttach",
	config = function()
		local lspconfig = require("lspconfig")

		local capabilities = require("blink.cmp").get_lsp_capabilities()
		require("fidget").setup({
			notification = {
				window = {
					winblend = 0, -- Background color opacity in the notification window
				},
			},
		})
		---@diagnostic disable-next-line: missing-fields
		require("mason-lspconfig").setup({
			handlers = {
				function(server_name) -- default handler (optional)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["emmet_language_server"] = function()
					lspconfig.emmet_language_server.setup({
						capabilities = capabilities,
						filetypes = {
							"css",
							"eruby",
							"html",
							"javascript",
							"typescript",
							"javascriptreact",
							"typescriptreact",
							"less",
							"sass",
							"scss",
							"pug",
						},
					})
				end,
				["basedpyright"] = function()
					lspconfig.basedpyright.setup({
						capabilities = capabilities,
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
					})
				end,
			},
		})

		local signs = { Error = "✘", Warn = "󰀪", Hint = "󰌶", Info = "" }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		vim.keymap.set("n", "K", vim.lsp.buf.hover)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
	end,
}
