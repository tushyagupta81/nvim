vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/Wansmer/treesj",
			"https://github.com/nvim-treesitter/nvim-treesitter",
		})
		require("treesj").setup({})
	end,
})
