local map = require("core.utils").map
local utils = require "core.utils"

local config = utils.load_config()

local map_wrapper = utils.map
local maps = config.mappings
local plugin_maps = maps.plugins

-- custom
map("n", maps.custom.diag_prev, ":lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", maps.custom.diag_next, ":lua vim.lsp.diagnostic.goto_next()<CR>")

-- Telescope
map("n", plugin_maps.telescope.file_browser, ":Telescope file_browser<CR>")
