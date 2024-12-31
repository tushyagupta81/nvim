return {
	"akinsho/bufferline.nvim",
  enabled = false,
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				style_preset = bufferline.style_preset.no_italic, -- or bufferline.style_preset.minimal,
				numbers = "ordinal",
				indicator = {
					style = "icon",
				},
				diagnostics = "nvim_lsp",
			},
		})
	end,
}
