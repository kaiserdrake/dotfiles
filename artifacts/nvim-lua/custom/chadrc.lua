local M = {}

local userPlugins = require "custom.plugins"
local override = require "custom.plugins.override"

M.plugins = {

  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },

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
}

M.mappings = require "custom.mappings"

return M
