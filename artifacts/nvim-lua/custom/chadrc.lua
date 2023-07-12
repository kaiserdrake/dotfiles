local M = {}

M.plugins = "custom.plugins"

M.ui = {
  theme = "onedark",
  hl_override = {
    Comment = { italic = true },
  },
}

M.mappings = require "custom.mappings"

return M
