return {
	cmd = { "lua-language-server" },
	root_marker = { ".luarc.json", ".luarc.jsonc", ".git", "init.lua" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = (function()
					local lib = {}
					local cwd = vim.loop.cwd() -- Get current working directory
					if cwd and cwd:find(".config/nvim", 1, true) then
						-- Only add Neovim runtime files if editing files inside ~/.config/nvim
						vim.list_extend(lib, vim.api.nvim_get_runtime_file("", true))
					end
					return lib
				end)(),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
