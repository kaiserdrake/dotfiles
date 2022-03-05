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

