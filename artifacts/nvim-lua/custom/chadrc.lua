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
  },

  default_plugin_config_replace = {
    nvim_treesitter = plugin_conf.treesitter,
    nvim_tree = plugin_conf.nvimtree,
    nvim_cmp = plugin_conf.nvimcmp,
  },

  install = userPlugins,
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
}

return M
