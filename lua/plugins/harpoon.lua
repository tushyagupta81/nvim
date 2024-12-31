return {
	"ThePrimeagen/harpoon",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)

		vim.keymap.set("n", "<C-e>", function()
      harpoon:list()
		end, { desc = "Open harpoon window" })

		vim.keymap.set("n", "<C-r>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-t>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-i>", function()
			harpoon:list():select(4)
		end)
	end,
}
