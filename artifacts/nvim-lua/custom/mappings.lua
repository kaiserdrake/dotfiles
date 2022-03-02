local map = require("core.utils").map
local utils = require "core.utils"

local config = utils.load_config()

local maps = config.mappings
local plugin_maps = maps.plugins

-- shortcuts
map("n", maps.shortcuts.diag_prev, ":lua vim.lsp.diagnostic.goto_prev()<CR>")
map("n", maps.shortcuts.diag_next, ":lua vim.lsp.diagnostic.goto_next()<CR>")

-- Telescope
map("n", plugin_maps.telescope.file_browser, ":Telescope file_browser<CR>")
map("n", plugin_maps.telescope.find_notes, ":Telescope find_files find_command=rg,-uu,--files,--follow cwd="..os.getenv("FILESTORE_PATH").."/orgs<CR>")
