return {
  cmd = { "marksman", "server" }, -- Ensure "masksman" is installed
  filetypes = { "markdown" },
  root_marker = { ".git", ".marksman.json" },
  settings = {
    marksman = {
      linting = true,
      formatting = true,
      completion = true,
    },
  },
}

