local M = {}

local userPlugins = require "custom.plugins"
local plugin_conf = require "custom.plugins.configs"

M.plugins = {

  options = {
    lspconfig = {
      setup_lspconf = "custom.plugins.lspconfig",
    },
  },

  default_plugin_config_replace = {
    nvim_treesitter = plugin_conf.treesitter,
    nvim_tree = plugin_conf.nvimtree,
  },

  install = userPlugins,
}

M.ui = {
  theme = "onedark",
}

M.mappings = {
  custom = {
    insert_date = "<C-x>d"
  }
}

M.mappings.plugins = {
  telescope = {
    file_browser = "<leader>fe",
    buffers = "<C-x>b",
  }
}

return M
