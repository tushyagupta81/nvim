---@param color "neofusion" | "tokyonight-storm" | "cyberdream" | "tokyonight-day" | "tokyonight-moon" | "tokyonight-night" | "catppuccin-latte" | "catppuccin-mocha" | "catppuccin-frappe" | "catppuccin-macchiato" | nil
function ColorMyPencils(color)
	color = color or "cyberdream"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffbd5e" })
	vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = "#D84727" })
	vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#5eff6c" })
end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
		},
		-- vim.cmd.colorscheme("tokyonight-night")
		-- vim.cmd.colorscheme("tokyonight-moon")
		-- vim.cmd.colorscheme("tokyonight-storm")
		-- vim.cmd.colorscheme("tokyonight-day")
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
			-- vim.cmd.colorscheme("catppuccin-macchiato")
			-- vim.cmd.colorscheme("catppuccin-mocha")
			-- vim.cmd.colorscheme("catppuccin-latte")
			-- vim.cmd.colorscheme("catppuccin-frappe")
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				-- Enable transparent background
				transparent = true,
				borderless_telescope = false,
				cache = false,
			})
			ColorMyPencils()
			-- vim.cmd("colorscheme cyberdream")
		end,
	},
	{
		"diegoulloao/neofusion.nvim",
		name = "neofusion",
		priority = 1000,
		config = function()
			require("neofusion").setup({
				transparent_mode = true,
			})
			-- vim.cmd.colorscheme("neofusion")
		end,
	},
}
