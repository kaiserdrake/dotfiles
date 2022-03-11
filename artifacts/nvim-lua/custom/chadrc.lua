local M = {}

local userPlugins = require "custom.plugins"
local plugin_conf = require "custom.plugins.configs"

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
  shortcuts = {
    diag_next = "]l",
    diag_prev = "[l",
  },
}

M.mappings.plugins = {
  telescope = {
    file_browser = "<leader>fe",
    find_notes = "<leader>fn",
    grep_string = "<leader>fW",
  },
  gitsigns = {
    next_hunk = "[g",
    prev_hunk = "]g",
    stage_hunk = "<leader>gs",
    undo_stage_hunk = "<leader>gu",
    reset_hunk = "<leader>gr",
    preview_hunk = "<leader>gv",
    blame_line = "<leader>gb",
    toggle_blame = "<leader>gB",
    toggle_signs = "<leader>gT",
  }
}

return M
