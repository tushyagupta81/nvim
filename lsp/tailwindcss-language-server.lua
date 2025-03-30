return {
  cmd = { "tailwindcss-language-server", "--stdio" },
  filetypes = { "html", "css", "javascript", "typescript", "jsx", "tsx" },
  root_marker = { "tailwind.config.js", "tailwind.config.ts", "package.json", ".git" },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidScreen = "error",
        invalidVariant = "error",
      },
      experimental = {
        classRegex = { "tw`([^`]*)`", 'tw="([^"]*)"' },
      },
    },
  },
}
