return {
  cmd = { "bash-language-server", "start" }, -- Ensure it's installed and in your PATH
  filetypes = { "sh", "bash", "zsh" },
  root_marker = { ".git", ".bashrc", ".bash_profile" },
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)", -- Recognizes common Bash script extensions
      backgroundAnalysisMaxFiles = 500, -- Adjust if you have many scripts
      shellcheckPath = "shellcheck", -- Ensure `shellcheck` is installed for linting
      explainshellEndpoint = "https://explainshell.com/explain", -- Optional: Online command explanation
    },
  },
}
