vim.api.nvim_create_user_command("SyncPack", function ()
  vim.pack.update(nil, {
    target = 'lockfile',
  })
end, {
  desc = "Sync plugins to lockfile",
})
