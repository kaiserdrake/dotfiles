local map = require("core.utils").map
local utils = require "core.utils"

local config = utils.load_config()

local map_wrapper = utils.map
local maps = config.mappings
local plugin_maps = maps.plugins

-- custom
map("n", maps.custom.insert_date, ":normal a<C-R>=strftime('[%Y-%m-%d %a]')<CR><CR>")
map("i", maps.custom.insert_date, "<C-R>=strftime('[%Y-%m-%d %a]')<CR>")

-- Telescope
map("n", plugin_maps.telescope.file_browser, ":Telescope file_browser<CR>")
