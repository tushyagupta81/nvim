return {
	"mbbill/undotree",
  enabled = false,
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	end,
}
