local M = {}

M.base46 = {
  theme = "github_dark",
  theme_toggle = {"github_dark","github_light"},
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
  },

  tabufline = {
    lazyload = false,
  },
}

return M
