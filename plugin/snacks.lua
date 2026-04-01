vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})
local snacks = require("snacks")
snacks.setup({
	picker = {
		sources = {
			files = {
				hidden = true,
			},
		},
	},
	bigfile = {
		notify = true, -- show notification when big file detected
		size = 1 * 1024 * 1024, -- 1MB
		-- Enable or disable features when big file detected
		---@param ctx {buf: number, ft:string}
		setup = function(ctx)
			vim.cmd([[NoMatchParen]])
			snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
			vim.b.minianimate_disable = true
			vim.schedule(function()
				vim.bo[ctx.buf].syntax = ctx.ft
			end)
		end,
	},
	notifier = {
		timeout = 3000, -- default timeout in ms
		top_down = false, -- place notifications from top to bottom
	},
	styles = {
		notification = {
			wo = { wrap = true }, -- Wrap notifications
		},
	},
	quickfile = {
		enabled = true,
	},
	indent = {
		enabled = true,
	},
	input = {
		enabled = true,
	},
})

vim.keymap.set("n", "<leader>.", function()
	snacks.scratch()
end, { desc = "Toggle Scratch Buffer" })

vim.keymap.set("n", "<leader>n", function()
	snacks.notifier.show_history()
end, { desc = "Notification History" })

vim.keymap.set("n", "<leader>b", function()
	snacks.picker.buffers({
		focus = "list",
		current = false,
	})
end, { desc = "Buffers" })

vim.keymap.set("n", "<leader>sg", function()
	snacks.picker.grep()
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>:", function()
	snacks.picker.command_history()
end, { desc = "Command History" })

vim.keymap.set("n", "<leader><leader>", function()
	snacks.picker.smart({
		multi = { "buffers", "files" },
	})
end, { desc = "Find Files" })

-- vim.keymap.set("n", "<leader>u", function()
-- 	local opts = {
-- 		focus = "list",
-- 	}
-- 	snacks.picker.undo(opts)
-- end, { desc = "Undo Files" })

vim.keymap.set("n", "<leader>tt", function()
	snacks.picker.diagnostics()
end, { desc = "Diagnostics" })

-- Grep
vim.keymap.set({ "n", "x" }, "<leader>sw", function()
	snacks.picker.grep_word()
end, { desc = "Visual selection or word" })

-- search
vim.keymap.set("n", "<leader>sC", function()
	snacks.picker.commands()
end, { desc = "Commands" })

vim.keymap.set("n", "<leader>sh", function()
	snacks.picker.help()
end, { desc = "Help Pages" })

vim.keymap.set("n", "<leader>sH", function()
	snacks.picker.highlights()
end, { desc = "Highlights" })

vim.keymap.set("n", "<leader>sk", function()
	snacks.picker.keymaps()
end, { desc = "Keymaps" })

vim.keymap.set("n", "<leader>sm", function()
	snacks.picker.marks()
end, { desc = "Marks" })

vim.keymap.set("n", "<leader>sr", function()
	snacks.picker.resume()
end, { desc = "Resume" })

vim.keymap.set("n", "<leader>sq", function()
	snacks.picker.qflist()
end, { desc = "Quickfix List" })

-- LSP
vim.keymap.set("n", "<leader>gd", function()
	snacks.picker.lsp_definitions()
end, { desc = "Goto Definition" })

vim.keymap.set("n", "<leader>gr", function()
	snacks.picker.lsp_references()
end, { nowait = true, desc = "References" })

vim.keymap.set("n", "<leader>gi", function()
	snacks.picker.lsp_implementations()
end, { desc = "Goto Implementation" })

vim.keymap.set("n", "<leader>gy", function()
	snacks.picker.lsp_type_definitions()
end, { desc = "Goto T[y]pe Definition" })

vim.keymap.set("n", "<leader>ss", function()
	snacks.picker.lsp_symbols()
end, { desc = "LSP Symbols" })
