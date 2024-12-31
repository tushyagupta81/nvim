return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		enabled = false,
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
		opts = {
			check_ts = true,
		},
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
	},
}
