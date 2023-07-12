local M = {}

M.plugins = "custom.plugins"

M.ui = {
  theme = "github_dark",
  hl_override = {
    Comment = { italic = true },
  },
}

M.mappings = require "custom.mappings"

M.lazy_nvim = {
  performance = {
    rtp = {
      disabled_plugins = vim.tbl_filter(function(plug)
        return not vim.tbl_contains({ "editorconfig" }, plug)
      end,
      require("plugins.configs.lazy_nvim").performance.rtp.disabled_plugins),
    },
  },
}

return M
