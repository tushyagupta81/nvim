return {
	"Exafunction/codeium.nvim",
	lazy = true,
  enabled = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("codeium").setup({})
	end,
}
