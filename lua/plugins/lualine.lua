return {
	"nvim-lualine/lualine.nvim",
  event = "VimEnter",
	config = function()
		if vim.g.colors_name == "cyberdream" then
			local cyberdream = require("lualine.themes.cyberdream")
			require("lualine").setup({
				options = {
					theme = cyberdream,
				},
				sections = {
					lualine_x = {
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
					},
				},
			})
		else
			require("lualine").setup({
				options = {
					theme = "ayu_mirage",
				},
				sections = {
					lualine_x = {
						{
							require("noice").api.statusline.mode.get,
							cond = require("noice").api.statusline.mode.has,
							color = { fg = "#ff9e64" },
						},
					},
				},
			})
		end
	end,
}
