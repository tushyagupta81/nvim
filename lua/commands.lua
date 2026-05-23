vim.api.nvim_create_user_command("PackSync", function ()
  vim.pack.update(nil, {
    target = 'lockfile',
  })
end, {
  desc = "Sync plugins to lockfile",
})

vim.api.nvim_create_user_command("PackUpdate", function ()
  vim.pack.update()
end, {
  desc = "Update all plugins",
})
