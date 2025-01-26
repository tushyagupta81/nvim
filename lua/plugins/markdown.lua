return {
	-- {
	-- 	"OXY2DEV/markview.nvim",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	opts = {},
	-- },
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
