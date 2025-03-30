return {
  cmd = { "masksman", "lsp" }, -- Ensure "masksman" is installed
  filetypes = { "markdown" },
  root_marker = { ".git", ".masksman.json" },
  settings = {
    masksman = {
      linting = true,
      formatting = true,
      completion = true,
    },
  },
}

