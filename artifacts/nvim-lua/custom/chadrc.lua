local M = {}

M.plugins = "custom.plugins"

M.ui = {
  theme = "github_dark",
  hl_override = {
    Comment = { italic = true },
  },
}

M.mappings = require "custom.mappings"

return M
