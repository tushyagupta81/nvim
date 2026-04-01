vim.api.nvim_create_autocmd("InsertEnter", {
	once = true,
	callback = function()
		vim.pack.add({
			{
				src = "https://github.com/saghen/blink.cmp",
				version = "v1.10.1",
			},
			"https://github.com/rafamadriz/friendly-snippets",
			"https://github.com/L3MON4D3/LuaSnip",
		})
		require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
		require("luasnip.loaders.from_vscode").lazy_load()
		require("blink.cmp").setup({
			keymap = { preset = "default" },

			appearance = {
				nerd_font_variant = "mono",
			},

			snippets = { preset = "luasnip" },

			sources = {
				default = { "lsp", "snippets", "path", "buffer" },
			},

			cmdline = {
				enabled = true,
				keymap = nil, -- Inherits from top level `keymap` config when not set
				---@diagnostic disable-next-line: assign-type-mismatch
				sources = function()
					local type = vim.fn.getcmdtype()
					-- Search forward and backward
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					-- Commands
					if type == ":" or type == "@" then
						return { "cmdline" }
					end
					return {}
				end,
				completion = {
					trigger = {
						show_on_blocked_trigger_characters = {},
						show_on_x_blocked_trigger_characters = nil, -- Inherits from top level `completion.trigger.show_on_blocked_trigger_characters` config when not set
					},
					menu = {
						auto_show = nil, -- Inherits from top level `completion.menu.auto_show` config when not set
						draw = {
							columns = { { "label", "label_description", gap = 1 } },
						},
					},
				},
			},

			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					auto_show = true,
					draw = {
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "source_name" },
						},
						-- columns = {
						-- 	{ "kind_icon", "sperator", gap = 1 },
						-- 	{ "label", "label_description", gap = 1 },
						-- 	{ "kind", "source_name", gap = 1 },
						-- },
						-- components = {
						-- 	sperator = {
						-- 		ellipsis = false,
						-- 		width = { fill = true },
						-- 		text = function()
						-- 			return "┃"
						-- 		end,
						-- 	},
						-- },
					},
					border = "single",
				},
				documentation = {
					auto_show = true,
					window = {
						border = "single",
						winblend = 0,
					},
				},
				ghost_text = {
					enabled = false,
				},
			},

			-- experimental signature help support
			signature = {
				enabled = true,
				window = {
					border = "single",
				},
			},
		})
	end,
})
