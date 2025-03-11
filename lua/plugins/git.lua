return {
	{
		"lewis6991/gitsigns.nvim",
		event = {
			"VeryLazy",
			"BufReadPre",
			"BufNewFile",
		},
		opts = {
			signs = {
				add = { text = "┃" },
				untracked = { text = "┆" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		dependencies = {
      "sindrets/diffview.nvim",
      event = "VeryLazy",
    },
		config = function()
			vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>")
			vim.keymap.set("n", "<leader>dvc", ":DiffviewClose<CR>")
		end,
	},
}
