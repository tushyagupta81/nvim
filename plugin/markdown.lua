vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "markdown-preview" and kind == "update" then
			vim.cmd([[call mkdp#util#install()]])
		end
	end,
})

vim.schedule(function ()
  vim.pack.add({
    "https://github.com/iamcco/markdown-preview.nvim",
  })
end)

-- Use this command to install markdown preview binary
-- :call mkdp#util#install()
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.keymap.set("n", "<leader>pre", "<cmd>MarkdownPreview<CR>", { desc = "Enable markdown preview" })
	end,
})
