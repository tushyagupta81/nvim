return {
	{
		"ggandor/leap.nvim",
    enabled = false,
		dependencies = {
			"tpope/vim-repeat",
		},
		config = function()
			vim.keymap.set("n", "m", "<Plug>(leap)")
			vim.keymap.set("n", "M", "<Plug>(leap-from-window)")
			vim.keymap.set({ "x", "o" }, "m", "<Plug>(leap-forward)")
			vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
			-- Define equivalence classes for brackets and quotes, in addition to
			-- the default whitespace group.
			require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }

			-- Use the traversal keys to repeat the previous motion without explicitly
			-- invoking Leap.
			require("leap.user").set_repeat_keys("<enter>", "<backspace>")

			vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" }) -- or some grey
			vim.api.nvim_set_hl(0, "LeapMatch", {
				-- For light themes, set to 'black' or similar.
				fg = "white",
				bold = true,
				nocombine = true,
			})
		end,
	},
	{
		"folke/flash.nvim",
		enabled = false,
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		---@diagnostic disable-next-line: undefined-doc-name
		---@type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "m", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "M", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
	},
}
