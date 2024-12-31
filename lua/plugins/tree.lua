-- return {
-- 	"nvim-neo-tree/neo-tree.nvim",
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
-- 		"MunifTanjim/nui.nvim",
-- 		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
-- 	},
-- 	config = function()
-- 		require("neo-tree").setup({
-- 			filesystem = {
-- 				filtered_items = {
-- 					visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
-- 					hide_dotfiles = false,
-- 					hide_gitignored = false,
-- 				},
-- 				follow_current_file = {
-- 					enabled = true,
-- 					leave_dirs_open = false,
-- 				},
-- 				hijack_netrw_behavior = "open_default",
-- 			},
-- 			buffers = {
-- 				follow_current_file = {
-- 					enabled = true, -- This will find and focus the file in the active buffer every time
-- 					--              -- the current file is changed while the tree is open.
-- 					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
-- 				},
-- 			},
-- 			sources = {
-- 				"filesystem",
-- 				"git_status",
-- 			},
-- 			add_blank_line_at_top = false, -- Add a blank line at the top of the tree.
-- 			close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
-- 			source_selector = {
-- 				statusline = true, -- toggle to show selector on statusline
-- 			},
-- 			window = { -- see https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup for
-- 				-- possible options. These can also be functions that return these options.
-- 				position = "right", -- left, right, top, bottom, float, current
-- 				width = 35, -- applies to left and right positions
-- 				height = 15, -- applies to top and bottom positions
-- 				mapping_options = {
-- 					noremap = true,
-- 					nowait = true,
-- 				},
-- 				mappings = {
-- 					["z"] = "close_all_nodes",
-- 					["Z"] = "expand_all_nodes",
-- 				},
-- 			},
-- 		})
-- 		vim.keymap.set("n", "-", "<cmd>Neotree filesystem reveal right<cr>")
-- 	end,
-- }

return {
	"echasnovski/mini.files",
	version = false,
	config = function()
		require("mini.files").setup({
			mappings = {
				close = "q",
				go_in = "l",
				go_in_plus = "<CR>",
				go_out = "h",
				go_out_plus = "H",
				reset = "<BS>",
				reveal_cwd = "@",
				show_help = "g?",
				synchronize = "=",
				trim_left = "<",
				trim_right = ">",
			},
			windows = {
				-- Maximum number of windows to show side by side
				max_number = math.huge,
				-- Whether to show preview of file/directory under cursor
				preview = true,
				-- Width of focused window
				width_focus = 25,
				-- Width of non-focused window
				width_nofocus = 15,
				-- Width of preview window
				width_preview = 80,
			},
		})

		-- require("plugins.utils.mini-files-git")

		local MiniFiles = require("mini.files")
		local minifiles_toggle = function()
			if not MiniFiles.close() then
				MiniFiles.open(vim.api.nvim_buf_get_name(0))
				MiniFiles.reveal_cwd()
			end
		end

		vim.keymap.set("n", "-", minifiles_toggle)
	end,
}

-- return {
-- 	"nvim-tree/nvim-tree.lua",
-- 	config = function()
-- 		local nvim_tree = require("nvim-tree")
-- 		nvim_tree.setup({
-- 			view = {
-- 				mappings = {
-- 					list = {
-- 						{ key = "-", action = "" },
-- 					},
-- 				},
-- 				side = "right",
-- 				signcolumn = "yes",
-- 				width = 35,
-- 			},
-- 			mappings = {
-- 				custom_only = true,
-- 			},
-- 			ui = {
-- 				confirm = {
-- 					remove = true,
-- 					trash = true,
-- 					default_yes = true,
-- 				},
-- 			},
-- 			update_focused_file = {
-- 				enable = true,
-- 			},
-- 			renderer = {
-- 				indent_markers = {
-- 					enable = true,
-- 				},
-- 				icons = {
-- 					web_devicons = {
-- 						folder = {
-- 							enable = true,
-- 						},
-- 					},
-- 					glyphs = {
-- 						git = {
-- 							unstaged = "[+]",
-- 						},
-- 					},
-- 				},
-- 			},
-- 			git = {
-- 				enable = true,
-- 				show_on_dirs = true,
-- 				show_on_open_dirs = false,
-- 			},
-- 			diagnostics = {
-- 				enable = true,
-- 				show_on_dirs = false,
-- 			},
-- 			modified = {
-- 				enable = true,
-- 				show_on_dirs = true,
-- 				show_on_open_dirs = true,
-- 			},
-- 		})
-- 		vim.keymap.set("n", "-", "<CMD>NvimTreeFocus<CR>")
-- 	end,
-- }

-- return {
-- 	"stevearc/oil.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	config = function()
-- 		local oil = require("oil")
-- 		oil.setup({
-- 			default_file_explorer = true,
-- 			columns = {
-- 				"icon",
-- 				-- "permissions",
-- 				-- "size",
-- 				-- "mtime",
-- 			},
-- 			keymaps = {
-- 				["<C-h>"] = false,
-- 				["<C-l>"] = false,
-- 				["<C-j>"] = false,
-- 				["<C-k>"] = false,
-- 				["<leader>-"] = "actions.refresh",
-- 			},
-- 			view_options = {
-- 				-- Show files and directories that start with "."
-- 				show_hidden = true,
-- 			},
-- 		})
-- 		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- 	end,
-- }
