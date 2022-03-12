local map = require("core.utils").map
local df = require "custom.defines"

-- Telescope
map("n", df.umap.telescope.file_browser, ":Telescope file_browser<CR>")
map("n", df.umap.telescope.find_notes, ":Telescope find_files find_command=rg,-uu,--files,--follow cwd="..os.getenv("FILESTORE_PATH").."/orgs<CR>")
map("n", df.umap.telescope.grep_string, ":Telescope grep_string<CR>")

-- Gitsigns
map("n", df.umap.gitsigns.next_hunk, ":Gitsigns next_hunk<CR>")
map("n", df.umap.gitsigns.prev_hunk, ":Gitsigns prev_hunk<CR>")
map("n", df.umap.gitsigns.stage_hunk, ":Gitsigns stage_hunk<CR>")
map("n", df.umap.gitsigns.undo_stage_hunk, ":Gitsigns undo_stage_hunk<CR>")
map("n", df.umap.gitsigns.preview_hunk, ":Gitsigns preview_hunk<CR>")
map("n", df.umap.gitsigns.reset_hunk, ":Gitsigns reset_hunk<CR>")
map("n", df.umap.gitsigns.blame_line, ":Gitsigns blame_line<CR>")
map("n", df.umap.gitsigns.toggle_blame, ":Gitsigns toggle_current_line_blame<CR>")
map("n", df.umap.gitsigns.toggle_signs, ":Gitsigns toggle_signs<CR>")

