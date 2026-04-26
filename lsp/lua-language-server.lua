-- Use .luarc.json for config
-- {
--   "Lua.workspace.library": ["~/.local/share/love2d/library"],
--   "Lua.diagnostics.globals": ["love"]
-- }

local root_markers1 = {
	".emmyrc.json",
	".luarc.json",
	".luarc.jsonc",
}

local root_markers2 = {
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
}

local root_markers = vim.list_extend(vim.list_extend(root_markers1, root_markers2), { ".git" })

return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = root_markers,

	on_init = function(client)
		local root = client.workspace_folders and client.workspace_folders[1].name or nil

		if not root then
			return
		end

		if vim.uv.fs_stat(root .. "/.luarc.json") or vim.uv.fs_stat(root .. "/.luarc.jsonc") then
			return
		end

		local lua_settings = {
			runtime = {
				version = "LuaJIT",
				path = {
					"lua/?.lua",
					"lua/?/init.lua",
				},
			},
			workspace = {
				checkThirdParty = false,
			},
		}

		client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, lua_settings)
	end,

	settings = {
		Lua = {
			codeLens = { enable = true },
			hint = { enable = true, semicolon = "Disable" },
		},
	},
}
