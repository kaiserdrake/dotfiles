local M = {}

local userPlugins = require "custom.plugins"
local plugin_conf = require "custom.plugins.configs"

M.plugins = {
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
    norman = "test"
  }
}

M.mappings.plugins = {
  telescope = {
    file_browser = "<leader>fb",
    buffers = "<C-x>b",
    find_files = "<C-x>f",
    find_hiddenfiles = "<leader>ff"
  }
}

return M
