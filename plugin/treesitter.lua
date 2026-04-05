vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			{
				src = "https://github.com/nvim-treesitter/nvim-treesitter",
				version = "main",
			},
		})

		require("nvim-treesitter").setup({
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
				"regex",
				"rust",
				"sql",
				"markdown",
				"markdown_inline",
				"typst",
				"yaml",
			},
			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = { "markdown" },
			},
			diagnostic = {
				update_in_insert = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "v",
					node_decremental = "V",
				},
			},
		})

		-- MDX
		vim.filetype.add({
			extension = {
				mdx = "mdx",
			},
		})
		vim.treesitter.language.register("markdown", "mdx")
	end,
})
