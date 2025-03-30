---@diagnostic disable: missing-fields
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = function()
		local snacks = require("snacks")
		return {
			picker = {
				sources = {
					files = {
						hidden = true,
					},
				},
			},
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
				size = 1 * 1024 * 1024, -- 1MB
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
			},
			input = {
				enabled = true,
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
			-- {
			-- 	"<leader>bd",
			-- 	function()
			-- 		snacks.bufdelete()
			-- 	end,
			-- 	desc = "Delete Buffer",
			-- },
			{
				"<leader>lg",
				function()
					snacks.lazygit()
				end,
				desc = "Open LazyGit",
			},
			{
				"<leader>b",
				function()
					snacks.picker.buffers({
						focus = "list",
						current = false,
					})
				end,
				desc = "Buffers",
			},
			{
				"<leader>sg",
				function()
					snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>:",
				function()
					snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader><leader>",
				function()
					snacks.picker.smart({
						multi = { "buffers", "files" },
					})
				end,
				desc = "Find Files",
			},
			{
				"<leader>u",
				function()
					local opts = {
						focus = "list",
					}
					snacks.picker.undo(opts)
				end,
				desc = "Undo Files",
			},
			{
				"<leader>sn",
				function()
					snacks.picker.files({
						---@diagnostic disable-next-line: assign-type-mismatch
						cwd = vim.fn.stdpath("config"),
					})
				end,
				desc = "Find Config File",
			},
			{
				"<leader>tt",
				function()
					Snacks.picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			-- Grep
			{
				"<leader>sw",
				function()
					snacks.picker.grep_word()
				end,
				desc = "Visual selection or word",
				mode = { "n", "x" },
			},
			-- search
			{
				"<leader>sC",
				function()
					snacks.picker.commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>sh",
				function()
					snacks.picker.help()
				end,
				desc = "Help Pages",
			},
			{
				"<leader>sH",
				function()
					snacks.picker.highlights()
				end,
				desc = "Highlights",
			},
			{
				"<leader>sk",
				function()
					snacks.picker.keymaps()
				end,
				desc = "Keymaps",
			},
			{
				"<leader>sm",
				function()
					snacks.picker.marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>sr",
				function()
					snacks.picker.resume()
				end,
				desc = "Resume",
			},
			{
				"<leader>sq",
				function()
					snacks.picker.qflist()
				end,
				desc = "Quickfix List",
			},
			-- LSP
			{
				"<leader>gd",
				function()
					snacks.picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"<leader>gr",
				function()
					snacks.picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"<leader>gi",
				function()
					snacks.picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"<leader>gy",
				function()
					snacks.picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"<leader>ss",
				function()
					snacks.picker.lsp_symbols()
				end,
				desc = "LSP Symbols",
			},
		}
	end,
}
