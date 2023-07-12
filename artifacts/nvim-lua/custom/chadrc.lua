local M = {}

M.plugins = "custom.plugins"

M.ui = {
  theme = "vscode_dark",
  hl_override = {
    Comment = { italic = true },
  },
}

M.mappings = require "custom.mappings"

return M
