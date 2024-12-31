local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("set")
require("remaps")

require("lazy").setup({
	-- importing directories
	spec = {
		{ import = "plugins" },
		-- { import = "plugins.lsp" },
	},

	-- ui config
	ui = {
		border = "rounded",
		size = {
			width = 0.8,
			height = 0.8,
		},
	},
})
