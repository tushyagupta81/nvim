return {
	"tpope/vim-fugitive",
	dependencies = "sindrets/diffview.nvim",
  config = function ()
    vim.keymap.set("n","<leader>dv",":DiffviewOpen<CR>")
  end
}
