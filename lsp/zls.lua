return {
  cmd = { "zls" }, -- Ensure it's installed and in your PATH
  filetypes = { "zig" },
  root_marker = { "build.zig", "zls.json", ".git" },
  settings = {
    zls = {
      enable_autofix = true,
      warn_style = true,
    },
  },
}
