local M = {}

local userPlugins = require "custom.plugins"
local plugin_conf = require "custom.plugins.configs"

local defined = require "custom.defines"

M.options = {
  timeoutlen = 800, -- make shortcuts timeout more forgiving
  relativenumber = true,
}

M.plugins = {

  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },

    statusline = {
      style = "slant"
    },
  },

  override = {
    ["kyazdani42/nvim-tree.lua"] = plugin_conf.nvimtree,
    ["nvim-treesitter/nvim-treesitter"] = plugin_conf.treesitter,
  },

  user = userPlugins,
}

M.ui = {
  theme = "onedark",
}

M.mappings = {
  shortcuts = defined.umap.shortcuts,
}

M.mappings.plugins = {
  telescope = defined.umap.telescope,
  gitsigns = defined.umap.gitsigns,
  orgmode = defined.umap.orgmode,
}

return M
