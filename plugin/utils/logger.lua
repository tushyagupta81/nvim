---@param logger string
local makeArg = function(logger, offset)
	offset = offset or 0
	local res = "yo"
		.. string.sub(logger, 1, string.len(logger) - 1 - offset)
		.. "<Esc>pa"
		.. string.sub(logger, -1 - offset, -1)
		.. "<Esc>"
	return res
end

local log = function()
	if vim.bo.filetype == "lua" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(makeArg("print()"), true, false, true), "n", false)
	elseif
		vim.bo.filetype == "javascript"
		or vim.bo.filetype == "javascriptreact"
		or vim.bo.filetype == "typescript"
		or vim.bo.filetype == "typescriptreact"
	then
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes(makeArg("console.log();", 1), true, false, true),
			"n",
			false
		)
	elseif vim.bo.filetype == "python" then
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(makeArg("print()"), true, false, true), "n", false)
	elseif vim.bo.filetype == "zig" then
		vim.api.nvim_feedkeys(
			vim.api.nvim_replace_termcodes(makeArg('std.debug.print("{any}",.{});', 2), true, false, true),
			"n",
			false
		)
	end
end

vim.keymap.set("v", ";l", log)
