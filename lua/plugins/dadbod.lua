return {
	"kristijanhusak/vim-dadbod-ui",
	"tpope/vim-dadbod",
	"kristijanhusak/vim-dadbod-completion",
  enabled = false,
	lazy = true,
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
	end,
}
