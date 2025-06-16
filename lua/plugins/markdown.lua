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
			vim.keymap.set("n", "<leader>pre", "<cmd>MarkdownPreview<CR>", { desc = "Enable markdown preview" })
		end,
	},
	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown" },
		config = function()
			vim.keymap.set("n", "<leader>pd", "<cmd>Markview disable<CR>", { desc = "Disable markview" })
			vim.keymap.set("n", "<leader>pe", "<cmd>Markview enable<CR>", { desc = "Enable markview" })
		end,

		-- For blink.cmp's completion
		-- source
		-- dependencies = {
		--     "saghen/blink.cmp"
		-- },
	},
}
