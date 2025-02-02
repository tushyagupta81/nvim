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
				default = { "lsp", "codeium", "lazydev", "path", "snippets", "buffer" },
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
          codeium = {
            name = "codeium",
            module = "blink.compat.source",
            score_offset = 80,
            async = true,
          },
				},
				cmdline = {},
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
							{ "kind", "source_name", gap = 1 },
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
					border = "single",
					scrollbar = false,
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "single",
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
					border = "single",
				},
			},
		},
		-- allows extending the providers array elsewhere in your config
		-- without having to redefine it
		-- opts_extend = { "sources.default" },
		opts_extend = { "sources.completion.enabled_providers" },
	},
}
