local trigger_text = ";"
---@diagnostic disable: missing-fields
return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		-- lazy = true,
		event = "InsertEnter",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"Exafunction/codeium.nvim",
				dependencies = "nvim-lua/plenary.nvim",
				build = ":Codeium Auth",
				config = function()
					require("codeium").setup({
						virtual_text = {
							enabled = false,
						},
					})
				end,
			},
			"saghen/blink.compat",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				config = function()
					---@diagnostic disable-next-line: assign-type-mismatch
					require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/snippets" })
					require("luasnip.loaders.from_vscode").lazy_load()
				end,
			},
		},
		version = "v0.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "default" },

			appearance = {
				nerd_font_variant = "mono",
			},

			snippets = { preset = "luasnip" },

			sources = {
				default = { "lsp", "snippets", "codeium", "lazydev", "path", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- show at a higher priority than lsp
						fallbacks = { "lsp" },
					},
					lsp = {
						score_offset = 90,
					},
					snippets = {
						name = "snippets",
						enabled = true,
						max_items = 15,
						-- min_keyword_length = 2,
						module = "blink.cmp.sources.snippets",
						score_offset = 85, -- the higher the number, the higher the priority
						-- Only show snippets if I type the trigger_text characters, so
						-- to expand the "bash" snippet, if the trigger_text is ";" I have to
						should_show_items = function()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							-- NOTE: remember that `trigger_text` is modified at the top of the file
							return before_cursor:match(trigger_text .. "%w*$") ~= nil or true
						end,
						-- After accepting the completion, delete the trigger_text characters
						-- from the final inserted text
						transform_items = function(_, items)
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							local trigger_pos = before_cursor:find(trigger_text .. "[^" .. trigger_text .. "]*$")
							if trigger_pos then
								for _, item in ipairs(items) do
									item.textEdit = {
										newText = item.insertText or item.label,
										range = {
											start = { line = vim.fn.line(".") - 1, character = trigger_pos - 1 },
											["end"] = { line = vim.fn.line(".") - 1, character = col },
										},
									}
								end
							end
							-- NOTE: After the transformation, I have to reload the luasnip source
							-- Otherwise really crazy shit happens and I spent way too much time
							-- figurig this out
							vim.schedule(function()
								require("blink.cmp").reload("snippets")
							end)
							return items
						end,

						fallbacks = function()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							-- NOTE: remember that `trigger_text` is modified at the top of the file
							if before_cursor:match(trigger_text .. "%w*$") ~= nil then
								return { "lsp" }
							else
								return {}
							end
						end,
					},
					codeium = {
						name = "codeium",
						module = "blink.compat.source",
						score_offset = 80,
						async = true,
					},
				},
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
		},
		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		-- opts_extend = { "sources.default" },
		-- opts_extend = { "sources.completion.enabled_providers" },
	},
}
