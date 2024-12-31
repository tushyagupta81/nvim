return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "biomejs" },
			typescript = { "biomejs" },
			javascriptreact = { "biomejs" },
			typescriptreact = { "biomejs" },
			python = { "ruff" },
			markdown = { "markdownlint-cli2" },
			rust = { "clippy" },
		}

		-- lint.linters.eslint_d = {
		-- 	-- From nvim-lint README
		-- 	cmd = function()
		-- 		local local_binary = vim.fn.fnamemodify("./node_modules/.bin/" .. "eslint_d", ":p")
		-- 		return vim.loop.fs_stat(local_binary) and local_binary or "eslint_d"
		-- 	end,
		-- 	-- ^ this was directly copied from nvim-lint README
		--
		-- 	args = {
		-- 		"--no-warn-ignored", -- <-- this is the key argument
		-- 		"--format",
		-- 		"json",
		-- 		"--stdin",
		-- 		"--stdin-filename",
		-- 		function()
		-- 			return vim.api.nvim_buf_get_name(0)
		-- 		end,
		-- 	},
		-- }

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>gl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
