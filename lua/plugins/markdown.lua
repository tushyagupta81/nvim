return {
	"MeanderingProgrammer/render-markdown.nvim",
  ft = { "md" },
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.nvim",
	}, -- if you use the mini.nvim suite
	---@module 'render-markdown'
	---@diagnostic disable-next-line: undefined-doc-name
	---@type render.md.UserConfig
	opts = {},
}
