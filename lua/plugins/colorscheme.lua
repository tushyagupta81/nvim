---@param color "neofusion" | "tokyonight-storm" | "cyberdream" | "tokyonight-day" | "tokyonight-moon" | "tokyonight-night" | "catppuccin-latte" | "catppuccin-mocha" | "catppuccin-frappe" | "catppuccin-macchiato" | nil
function ColorMyPencils(color)
	color = color or "tokyonight-night"
	vim.cmd.colorscheme(color)

	local colors = {
		blue = "#80a0ff",
		cyan = "#79dac8",
		black = "#080808",
		dark_red = "#f44e3f",
		orange = "#ff9e64",
		white = "#c6c6c6",
		red = "#ff5189",
		dark_orange = "#D84727",
		violet = "#d183e8",
		green = "#8DC17C",
		gray = "#303030",
		yellow = "#5eff6c",
	}

	vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = colors.orange })
	vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true })
	vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true })
	vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpActiveParameter", { fg = colors.dark_orange })
	vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = colors.yellow })
	vim.api.nvim_set_hl(0, "LazyButton", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinSeparator", { bold = true, fg = colors.white })

	-- Statusline Colors
	vim.api.nvim_set_hl(0, "StatusLineAccent", { bg = colors.blue, fg = colors.black })
	vim.api.nvim_set_hl(0, "StatuslineAccent", { bg = colors.blue, fg = colors.black })
	vim.api.nvim_set_hl(0, "StatuslineInsertAccent", { bg = colors.dark_red, fg = colors.black })
	vim.api.nvim_set_hl(0, "StatuslineVisualAccent", { bg = colors.blue, fg = colors.black })
	vim.api.nvim_set_hl(0, "StatuslineReplaceAccent", { bg = colors.red, fg = colors.black })
	vim.api.nvim_set_hl(0, "StatuslineCmdLineAccent", { bg = colors.green, fg = colors.black })
	vim.api.nvim_set_hl(0, "StatuslineTerminalAccent", { bg = colors.black, fg = colors.white })

	vim.api.nvim_set_hl(0, "StatuslineFilename", { bg = colors.cyan, fg = colors.black })
	vim.api.nvim_set_hl(0, "StatuslineGit", { bg = colors.red, fg = colors.black })
	vim.api.nvim_set_hl(0, "StatuslineMacro", { bg = "none", fg = colors.orange })
	vim.api.nvim_set_hl(0, "StatuslineFiletype", { bg = colors.red, fg = colors.black })
	vim.api.nvim_set_hl(0, "StatuslineLineInfo", { bg = colors.blue, fg = colors.black })

	vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })

	-- Statusline LSP
	vim.api.nvim_set_hl(0, "StatuslineLSP", { bg = colors.gray, fg = colors.white })
	vim.api.nvim_set_hl(0, "LspDiagnosticsSignError", { bg = colors.gray, fg = colors.red })
	vim.api.nvim_set_hl(0, "LspDiagnosticsSignWarning", { bg = colors.gray, fg = colors.yellow })
	vim.api.nvim_set_hl(0, "LspDiagnosticsSignHint", { bg = colors.gray, fg = colors.white })
	vim.api.nvim_set_hl(0, "LspDiagnosticsSignInformation", { bg = colors.gray, fg = colors.cyan })
end

return {
	{
		"folke/tokyonight.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
				dim_inactive = false,
				cache = true,
			})
			ColorMyPencils("tokyonight-night")
			-- vim.cmd.colorscheme("tokyonight-night")
			-- vim.cmd.colorscheme("tokyonight-moon")
			-- vim.cmd.colorscheme("tokyonight-storm")
			-- vim.cmd.colorscheme("tokyonight-day")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		enabled = false,
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
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("cyberdream").setup({
				-- Enable transparent background
				transparent = true,
				borderless_telescope = false,
				cache = false,
			})
			-- ColorMyPencils()
			-- vim.cmd("colorscheme cyberdream")
		end,
	},
	{
		"diegoulloao/neofusion.nvim",
		enabled = false,
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
