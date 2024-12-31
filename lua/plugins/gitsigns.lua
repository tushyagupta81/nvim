return {
	"lewis6991/gitsigns.nvim",
	event = {
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
}
