---@diagnostic disable: missing-fields
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = function()
		local snacks = require("snacks")
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})
		return {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			dashboard = {
				width = 68,
				preset = {
					header = [[
                                                                   
      ████ ██████           █████      ██                 btw
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]],
				},
				sections = {
					{
						section = "header",
					},
					{
						section = "keys",
						gap = 1,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Recent Files",
						section = "recent_files",
						indent = 2,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Projects",
						section = "projects",
						indent = 3,
						padding = 1,
					},
					{
						pane = 2,
						icon = " ",
						title = "Git Status",
						section = "terminal",
						enabled = function()
							return snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 2,
					},
					{
						pane = 2,
						icon = " ",
						title = "Git Changes",
						section = "terminal",
						enabled = function()
							return snacks.git.get_root() ~= nil
						end,
						cmd = "git --no-pager diff --stat -B -M -C",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
						indent = 2,
					},
					{ section = "startup" },
				},
			},
			bigfile = {
				notify = true, -- show notification when big file detected
				size = 5 * 1024 * 1024, -- 5MB
				-- Enable or disable features when big file detected
				---@param ctx {buf: number, ft:string}
				setup = function(ctx)
					vim.cmd([[NoMatchParen]])
					snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
					vim.b.minianimate_disable = true
					vim.schedule(function()
						vim.bo[ctx.buf].syntax = ctx.ft
					end)
				end,
			},
			notifier = {
				timeout = 3000, -- default timeout in ms
				top_down = false, -- place notifications from top to bottom
			},
			styles = {
				notification = {
					wo = { wrap = true }, -- Wrap notifications
				},
			},
			quickfile = {
				enabled = true,
			},
			indent = {
				enabled = true,
				animate = {
					enabled = false,
				},
				-- scope = {
				-- 	char = "┃",
				-- },
			},
      zen = {
        toggles = {
          dim = false,
        },
        show = {
          statusline = true,
        },
      },
		}
	end,
	keys = function()
		local snacks = require("snacks")
		return {
			{
				"<leader>.",
				function()
					snacks.scratch()
				end,
				desc = "Toggle Scratch Buffer",
			},
			{
				"<leader>S",
				function()
					snacks.scratch.select()
				end,
				desc = "Select Scratch Buffer",
			},
			{
				"<leader>n",
				function()
					snacks.notifier.show_history()
				end,
				desc = "Notification History",
			},
			{
				"<leader>bd",
				function()
					snacks.bufdelete()
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>lg",
				function()
					snacks.lazygit()
				end,
				desc = "Open LazyGit",
			},
			{
				"<leader>zz",
				function()
					snacks.zen()
				end,
				desc = "Open zen mode",
			},
		}
	end,
}
