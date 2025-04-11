local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
	["nt"] = "TERMINAL",
}

local mode = function()
	local current_mode = vim.api.nvim_get_mode().mode
	return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#StatusLineAccent#"
	if current_mode == "n" then
		mode_color = "%#StatuslineAccent#"
	elseif current_mode == "i" or current_mode == "ic" or current_mode == "t" then
		mode_color = "%#StatuslineInsertAccent#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#StatuslineVisualAccent#"
	elseif current_mode == "R" then
		mode_color = "%#StatuslineReplaceAccent#"
	elseif current_mode == "c" then
		mode_color = "%#StatuslineCmdLineAccent#"
	elseif current_mode == "nt" then
		mode_color = "%#StatuslineTerminalAccent#"
	end
	return mode_color
end

local filepath = function()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." then
		return " "
	end
	if string.find(fpath, "minifiles://%d*/") then
		local _, b = string.find(fpath, "minifiles://%d*/")
		fpath = fpath:sub(b + 1, fpath:len())
	end
	return string.format(" %%<%s/", fpath)
end

local filename = function()
	local fname = vim.fn.expand("%:t")
	if fname == "" or string.find(fname, "Scratch") then
		return ""
	end
	return fname .. " "
end

local lsp = function()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		---@diagnostic disable-next-line: assign-type-mismatch
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError# " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsSignHint#󰌶 " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsSignInformation# " .. count["info"]
	end

	if errors == "" and warnings == "" and hints == "" and info == "" then
		return ""
	else
		return errors .. warnings .. hints .. info .. " "
	end
end

local filetype = function()
  local str = string.format(" %s ", vim.bo.filetype):lower()
	return (str:sub(1,2):upper() .. str:sub(3))
end

local lineinfo = function()
	if vim.bo.filetype == "alpha" then
		return ""
	end
	return " %P %l:%c "
end

local vcs = function()
	local git_info = vim.b.gitsigns_status_dict
	if not git_info or git_info.head == "" then
		return ""
	end
	local added = git_info.added and ("+" .. git_info.added .. " ") or ""
	local changed = git_info.changed and ("~" .. git_info.changed .. " ") or ""
	local removed = git_info.removed and ("-" .. git_info.removed .. " ") or ""
	if git_info.added == 0 then
		added = ""
	end
	if git_info.changed == 0 then
		changed = ""
	end
	if git_info.removed == 0 then
		removed = ""
	end
	return table.concat({
		" ",
		added,
		changed,
		removed,
		" ",
		git_info.head,
		" ",
	})
end

local noice_macro = function()
	local noice = require("noice")
	if noice.api.status.mode.has() then
		return "%#StatuslineMacro#" .. noice.api.status.mode.get() .. " "
	else
		return ""
	end
end

local noice_keys = function()
	local noice = require("noice")
	if noice.api.status.command.has() then
		return "%#StatuslineMacro#" .. noice.api.status.command.get() .. " "
	else
		return ""
	end
end

Statusline = {}

---@diagnostic disable-next-line: duplicate-set-field
Statusline.active = function()
	return table.concat({
		"%#Statusline#",
		update_mode_colors(),
		mode(),
		"%#StatuslineFilename#",
		filepath(),
		filename(),
		"%#StatuslineGit#",
		vcs(),
		"%#StatuslineLSP#",
		lsp(),
		"%#Normal#%=",
		noice_macro(),
		noice_keys(),
		"%#StatuslineFiletype#",
		filetype(),
		"%#StatuslineLineInfo#",
		lineinfo(),
	})
end

---@diagnostic disable-next-line: duplicate-set-field
function Statusline.inactive()
	return " %F"
end

---@diagnostic disable-next-line: duplicate-set-field
function Statusline.short()
	return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec2(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]],
	{ output = false }
)
