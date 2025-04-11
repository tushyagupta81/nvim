-- vim.lsp.enable({ "clangd", "basedpyright", "asm-lsp", "rust-analyzer", "emmet-language-server", "lua-language-server", "bash-language-server" })
local lsp_configs = {
	"arduino-language-server",
	"asm-lsp",
	"basedpyright",
	"bash-language-server",
	"clangd",
	"emmet-language-server",
	"lua-language-server",
	"marksman",
	"rust-analyzer",
	"tailwindcss-language-server",
	"typescript-language-server",
	"zls",
}

vim.lsp.enable(lsp_configs)

vim.diagnostic.config({
	virtual_text = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󰌶",
			[vim.diagnostic.severity.INFO] = "",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})
