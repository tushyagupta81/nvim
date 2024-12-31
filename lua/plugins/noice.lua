return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		-- "rcarriga/nvim-notify",
	},
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("noice").setup({
			cmdline = {
				view = "cmdline",
			},
			lsp = {
				signature = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
		})
		-- require("notify").setup({
		-- 	timeout = 200,
		-- 	background_color = "transparent",
		-- 	top_down = false,
		-- 	render = "minimal",
		-- 	stages = "fade",
		-- })
	end,
}
