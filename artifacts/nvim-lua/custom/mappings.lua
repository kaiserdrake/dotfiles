local map = require("core.utils").map

local utils = require "core.utils"

local config = utils.load_config()
local map_wrapper = utils.map

local maps = config.mappings
local plugin_maps = maps.plugins

map("n", plugin_maps.telescope.file_browser, ":Telescope file_browser<CR>")

