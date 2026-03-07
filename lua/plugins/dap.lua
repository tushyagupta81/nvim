---@diagnostic disable: missing-fields
return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"igorlfs/nvim-dap-view",
	},
	config = function()
		require("nvim-dap-virtual-text").setup({
			enabled = true,
			enabled_commands = true,
			highlight_changed_variables = true,
			highlight_new_as_changed = false,
			show_stop_reason = true,
			commented = false,
			only_first_definition = true,
			all_references = false,
			clear_on_continue = false,
			display_callback = function(variable, buf, stackframe, node, options)
				if options.virt_text_pos == "inline" then
					return " = " .. variable.value:gsub("%s+", " ")
				else
					return variable.name .. " = " .. variable.value:gsub("%s+", " ")
				end
			end,
			virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",
			all_frames = false,
			virt_lines = false,
			virt_text_win_col = nil,
		})

		local dap_view = require("dap-view")

		dap_view.setup({
			winbar = {
				controls = {
					enabled = true,
					position = "right",
					buttons = {
						"play",
						"step_into",
						"step_over",
						"step_out",
						"step_back",
						"run_last",
						"terminate",
						"disconnect",
					},
					custom_buttons = {},
				},
			},
			windows = {
				size = 0.3,
				position = "below",
				terminal = {
					size = 0.25,
					position = "left",
					-- List of debug adapters for which the terminal should be ALWAYS hidden
					hide = {},
				},
			},
		})

		local dap = require("dap")

		dap.listeners.before.attach.dapui_config = function()
			dap_view.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dap_view.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dap_view.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dap_view.close()
		end

		vim.g.dap_virtual_text = true
		vim.fn.sign_define("DapBreakpoint", { text = "🔵", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "🔴", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapConditionalBreakpoint", { text = "🟡", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })

		vim.keymap.set("n", "<Leader>da", dap.toggle_breakpoint, {})
		vim.keymap.set("n", "<leader>dc", dap.continue, {})
		vim.keymap.set("n", "<leader>di", dap.step_into, {})
		vim.keymap.set("n", "<leader>db", dap.step_back, {})
		vim.keymap.set("n", "<leader>do", dap.step_out, {})
		vim.keymap.set("n", "<leader>dt", dap.terminate, {})

		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = { "dap-view", "dap-view-term", "dap-repl" }, -- dap-repl is set by `nvim-dap`
			callback = function(args)
				vim.keymap.set("n", "q", "<C-w>q", { buffer = args.buf })
			end,
		})
	end,
}
