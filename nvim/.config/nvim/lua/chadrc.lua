local M = {}

M.base46 = {
  theme = "onedark",
  theme_toggle = {"onedark","github_light"},
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
  cmp = {
    style = "atom_colored"
  },

  statusline = {
    theme = "default",
    separator_style = "round"
  },

  tabufline = {
    lazyload = false,
  },
}

return M
