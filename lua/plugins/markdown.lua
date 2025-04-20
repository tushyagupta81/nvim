return {
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			-- vim.fn["mkdp#util#install"]()
			vim.cmd([[call mkdp#util#install()]])
		end,
		config = function()
			vim.keymap.set("n", "<leader>pre", "<cmd>MarkdownPreview<CR>")
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,

		-- For blink.cmp's completion
		-- source
		-- dependencies = {
		--     "saghen/blink.cmp"
		-- },
	},
}
