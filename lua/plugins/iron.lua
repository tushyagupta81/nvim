return {
	"Vigemus/iron.nvim",
	ft = { "python" },
	config = function()
		local iron = require("iron.core")
		local view = require("iron.view")
		local common = require("iron.fts.common")

		iron.setup({
			config = {
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					sh = {
						-- Can be a table or a function that
						-- returns a table (see below)
						command = { "zsh" },
					},
					python = {
						command = function()
							local ipythonAvailable = vim.fn.executable("ipython") == 1
							if ipythonAvailable then
								local has_matplotlib = false

								local handle = io.popen(
									"python3 -c 'import importlib.util; print(importlib.util.find_spec(\"matplotlib\") is not None)'"
								)
								if handle then
									local result = handle:read("*a")
									handle:close()
									has_matplotlib = result:match("True") ~= nil
								end


								-- The --no-autoindent is VERY important
								local config =  {
									"ipython",
									"--no-autoindent",
									"--no-confirm-exit",
								}

                -- For matplotlib
                if has_matplotlib then
                  table.insert(config, "--matplotlib")
                end

                return config
							else
								return { "python3" }
							end
						end,
						format = common.bracketed_paste_python,
						block_dividers = { "# %%", "#%%" },
					},
				},
				-- How the repl window will be displayed
				-- See below for more information

				-- repl_open_cmd = view.bottom(40),
				repl_open_cmd = view.split.vertical.botright("40%"),

				-- repl_open_cmd can also be an array-style table so that multiple
				-- repl_open_commands can be given.
				-- When repl_open_cmd is given as a table, the first command given will
				-- be the command that `IronRepl` initially toggles.
				-- Moreover, when repl_open_cmd is a table, each key will automatically
				-- be available as a keymap (see `keymaps` below) with the names
				-- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
				-- For example,
				--
				-- repl_open_cmd = {
				--   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
				--   view.split.rightbelow("%25")  -- cmd_2: open a repl below
				-- }
			},
			-- Iron doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				toggle_repl = "<space>rr", -- toggles the repl open and closed.
				restart_repl = "<space>rR", -- calls `IronRestart` to restart the repl
				visual_send = "<space>i",
				send_line = "<space>il",
				send_paragraph = "<space>ip",
				send_code_block = "<space>ie",
				send_code_block_and_move = "<space>ib",
				exit = "<space>iq",
				send_until_cursor = "<space>ic",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			highlight = {
				italic = true,
			},
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
		})

		-- iron also has a list of commands, see :h iron-commands for all available commands
		vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
		vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")

		-- Insert the #%%
		vim.keymap.set("n", "<space>ii", function()
			local current_line = vim.fn.line(".")
			-- Insert two empty lines below the current line
			vim.fn.append(current_line, { "", "" })
			-- Insert '#%%' at the start of the second new line
			vim.fn.setline(current_line + 2, "#%%")
			vim.api.nvim_win_set_cursor(0, { current_line + 2, 0 })
		end, { desc = "Insert #%% below" })

		vim.keymap.set("n", "<space>iI", function()
			local current_line = vim.fn.line(".")
			-- Insert two empty lines below the current line
			vim.fn.append(current_line - 1, { "", "" })
			-- Insert '#%%' at the start of the second new line
			vim.fn.setline(current_line, "#%%")
			vim.api.nvim_win_set_cursor(0, { current_line, 0 })
		end, { desc = "Insert #%% above" })
	end,
}
