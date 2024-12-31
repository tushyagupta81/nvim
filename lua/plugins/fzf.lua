-- chown the dir for startserver for fzf-lua in wsl if it dosent work !!
return {
	"ibhagwan/fzf-lua",
	dependencies = { "echasnovski/mini.icons" },
	event = "VimEnter",
	opts = function()
		local config = require("fzf-lua.config")
		local actions = require("fzf-lua.actions")

		-- Quickfix
		config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
		config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
		config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
		config.defaults.keymap.fzf["ctrl-x"] = "jump"
		config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
		config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
		config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
		config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

		return {
			"default-title",
			fzf_colors = true,
			fzf_opts = {
				["--no-scrollbar"] = true,
			},
			defaults = {
				file_icons = "mini",
				formatter = "path.filename_first",
			},
			winopts = {
				width = 0.8,
				height = 0.9,
				row = 0.5,
				col = 0.5,
				preview = {
					scrollchars = { "┃", "" },
					-- default = "bat",
				},
			},
			files = {
				cwd_prompt = false,
				actions = {
					["alt-i"] = { actions.toggle_ignore },
					["alt-h"] = { actions.toggle_hidden },
				},
			},
			grep = {
				actions = {
					["alt-i"] = { actions.toggle_ignore },
					["alt-h"] = { actions.toggle_hidden },
				},
				rg_glob = true,
				glob_flag = "--iglob",
				glob_sperator = "%s%-%-",
			},
		}
	end,
	keys = {
		{ "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
		{ "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
		{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{ '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
		{ "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
		{ "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
		{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
		{ "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
		{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
		{ "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
		{ "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Fzf Files" },
		{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Fzf LiveGrep" },
		{ "<leader>sr", "<cmd>FzfLua resume<cr>", desc = "Fzf Resume" },
		{ "<leader><leader>", "<cmd>FzfLua buffers<cr>", desc = "Fzf buffers" },
		{
			"<leader>sn",
			function()
				require("fzf-lua").files({
					cwd = vim.fn.stdpath("config"),
				})
			end,
			desc = "Fzf Neovim Config",
		},
	},
	config = function(_, opts)
		require("fzf-lua").setup(opts)
	end,
}
