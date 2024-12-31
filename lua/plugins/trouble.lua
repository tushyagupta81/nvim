return {
	"folke/trouble.nvim",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		require("trouble").setup({
			auto_close = true, -- auto close when there are no items
			auto_open = false, -- auto open when there are items
			modes = {
				mydiags = {
					mode = "diagnostics", -- inherit from diagnostics mode
					filter = {
						severity = vim.diagnostic.severity.ERROR, -- errors only
					},
				},
			},
		})
		vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>")
		vim.keymap.set("n", "]t", "<cmd>Trouble mydiags next follow=true focus=true<cr>")
		vim.keymap.set("n", "[t", "<cmd>Trouble mydiags prev follow=true focus=true<cr>")
	end,
}
