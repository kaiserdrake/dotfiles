local M = {}

M.base46 = {
  theme = "github_dark",
  hl_override = {
    Comment = { italic = true },
  },
  statusline = {
    theme = "vscode_colored",
  },
  cheatsheet = {
    theme = "grid",
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" },
  },
}

M.ui = {
  statusline = {
    theme = "default",
    separator_style = "round"
  }
}

M.lsp = {signature = false} -- signature is handled by noice

return M
