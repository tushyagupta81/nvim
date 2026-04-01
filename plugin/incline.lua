vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			"https://github.com/b0o/incline.nvim",
			"https://github.com/SmiteshP/nvim-navic",
			"https://github.com/nvim-tree/nvim-web-devicons",
		})
		local helpers = require("incline.helpers")
		local navic = require("nvim-navic")
		local devicons = require("nvim-web-devicons")

		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "Navic Attacher",
			group = vim.api.nvim_create_augroup("idr4n/navic-attacher", {}),
			callback = function(a)
				local client = vim.lsp.get_client_by_id(a.data.client_id)
				if client and client.server_capabilities["documentSymbolProvider"] then
					navic.attach(client, a.buf)
				end
			end,
		})

		require("incline").setup({
			window = {
				padding = 0,
				margin = { horizontal = 0, vertical = 0 },
			},
			hide = {
				cursorline = true,
			},
			render = function(props)
				local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
				if filename == "" then
					filename = "[No Name]"
				end
				local ft_icon, ft_color = devicons.get_icon_color(filename)
				local modified = vim.bo[props.buf].modified
				local res = {
					ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
					" ",
					{ filename, gui = modified and "bold,italic" or "bold" },
					guibg = "#44406e",
				}
				if props.focused then
					for _, item in ipairs(navic.get_data(props.buf) or {}) do
						table.insert(res, {
							{ " > ", group = "NavicSeparator" },
							{ item.icon, group = "NavicIcons" .. item.type },
							{ item.name, group = "NavicText" },
						})
					end
				end
				table.insert(res, " ")
				return res
			end,
		})
	end,
})
