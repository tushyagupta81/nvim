return {
	"nvim-treesitter/nvim-treesitter",
	event = "VimEnter",
	build = ":TSUpdate",
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			-- A list of parser names, or "all"
			ensure_installed = {
				"vimdoc",
				"javascript",
				"typescript",
				"c",
				"lua",
				"rust",
				"jsdoc",
				"bash",
				"html",
				"python",
				"cpp",
				"css",
				"fish",
				"gitignore",
				"http",
				"rust",
				"sql",
			},
			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "markdown" },
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "v",
					node_decremental = "V",
				},
			},
		})
	end,
}
