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
		lazy = false, -- lazy loading handled internally
		dependencies = {
			"rafamadriz/friendly-snippets",
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

			sources = {
				default = { "lsp", "lazydev", "path", "snippets", "buffer", "luasnip" },
				providers = {
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
						fallbacks = { "buffer" },
						score_offset = 90, -- the higher the number, the higher the priority
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- show at a higher priority than lsp
						fallbacks = { "lsp" },
					},
					luasnip = {
						name = "luasnip",
						enabled = true,
						module = "blink.cmp.sources.luasnip",
						should_show_items = function()
							local col = vim.api.nvim_win_get_cursor(0)[2]
							local before_cursor = vim.api.nvim_get_current_line():sub(1, col)
							-- NOTE: remember that `trigger_text` is modified at the top of the file
							return before_cursor:match(trigger_text .. "%w*$") ~= nil
						end,
						-- After accepting the completion, delete the trigger_text characters
						-- from the final inserted text
						transform_items = function(ctx, items)
							-- WARNING: Explicitly referencing ctx otherwise I was getting an "unused" warning
							local _ = ctx
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
								require("blink.cmp").reload("luasnip")
							end)
							return items
						end,
						fallbacks = { "snippets" },
						score_offset = 85,
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 3,
						fallbacks = { "snippets", "luasnip", "buffer" },
					},
					snippets = {
						name = "snippets",
						enabled = true,
						max_items = 3,
						module = "blink.cmp.sources.snippets",
						score_offset = 80, -- the higher the number, the higher the priority
					},
				},
				cmdline = function()
					local type = vim.fn.getcmdtype()
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					if type == ":" then
						return { "cmdline" }
					end
					return {}
				end,
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
						---@diagnostic disable-next-line: assign-type-mismatch
						treesitter = { "lsp" },
						columns = {
							{ "kind_icon", "sperator", gap = 1 },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
						components = {
							sperator = {
								ellipsis = false,
								width = { fill = true },
								text = function()
									return "┃"
								end,
							},
						},
					},
					border = "rounded",
					scrollbar = false,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
						winblend = 0,
						max_width = 100,
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
					border = "rounded",
				},
			},
		},
		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		-- opts_extend = { "sources.default" },
		opts_extend = { "sources.completion.enabled_providers" },
	},
}
