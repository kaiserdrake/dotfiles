local M = {}

local userPlugins = require "custom.plugins"
local override = require "custom.plugins.override"

M.plugins = {

  options = {
    statusline = {
      separator_style = "round"
    },
  },

  override = {
    ["kyazdani42/nvim-tree.lua"] = override.nvimtree,
    ["nvim-treesitter/nvim-treesitter"] = override.treesitter,
  },

  user = userPlugins,
}

M.ui = {
  theme = "onedark",
  hl_override = {
    Comment = { italic = true },
  },
}

M.mappings = require "custom.mappings"

return M
