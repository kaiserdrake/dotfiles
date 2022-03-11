local M = {}

local userPlugins = require "custom.plugins"
local plugin_conf = require "custom.plugins.configs"

local map = require("core.utils").map

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

-- Mappings

local maps = M.mappings
local plugin_maps = maps.plugins

-- shortcuts
map("n", maps.shortcuts.diag_prev, ":lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", maps.shortcuts.diag_next, ":lua vim.lsp.diagnostic.goto_next()<CR>")

-- Telescope
map("n", plugin_maps.plugins.telescope.file_browser, ":Telescope file_browser<CR>")
map("n", plugin_maps.telescope.find_notes, ":Telescope find_files find_command=rg,-uu,--files,--follow cwd="..os.getenv("FILESTORE_PATH").."/orgs<CR>")
map("n", plugin_maps.telescope.grep_string, ":Telescope grep_string<CR>")

-- Gitsigns
map("n", plugin_maps.gitsigns.next_hunk, ":Gitsigns next_hunk<CR>")
map("n", plugin_maps.gitsigns.prev_hunk, ":Gitsigns prev_hunk<CR>")
map("n", plugin_maps.gitsigns.stage_hunk, ":Gitsigns stage_hunk<CR>")
map("n", plugin_maps.gitsigns.undo_stage_hunk, ":Gitsigns undo_stage_hunk<CR>")
map("n", plugin_maps.gitsigns.preview_hunk, ":Gitsigns preview_hunk<CR>")
map("n", plugin_maps.gitsigns.reset_hunk, ":Gitsigns reset_hunk<CR>")
map("n", plugin_maps.gitsigns.blame_line, ":Gitsigns blame_line<CR>")
map("n", plugin_maps.gitsigns.toggle_blame, ":Gitsigns toggle_current_line_blame<CR>")
map("n", plugin_maps.gitsigns.toggle_signs, ":Gitsigns toggle_signs<CR>")

return M
