return {
	"lukas-reineke/indent-blankline.nvim",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
  enabled = false,
	main = "ibl",
	opts = {},
	config = function()
		local highlight = {
			-- "CursorColumn",
			"Whitespace",
		}
		require("ibl").setup({
			indent = { highlight = highlight },
			whitespace = {
				highlight = highlight,
				remove_blankline_trail = false,
			},
			scope = { enabled = false },
		})
	end,
}
