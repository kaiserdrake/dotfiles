require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- Telescope
map("n", "<leader>fe", ":Telescope file_browser<CR>", { desc = "Telescope file browser"})
map("n", "<leader>fn", ":Telescope find_files find_command=rg,-uu,--files,--follow cwd="..os.getenv("FILESTORE_PATH").."/orgs<CR>", { desc = "Telescope find notes"})

map("n", "<leader>fW", ":Telescope grep_string<CR>", { desc = "Telescope grep string"})
map("n", "<leader>fp", ":Telescope projects<CR>", { desc = "Telescope projects"})
-- muscle memory fallthrough
map({ "i", "n" }, "<C-x>b", ":Telescope buffers<CR>", { desc = "Telescope buffers"})
map({ "i", "n" }, "<C-x>f", ":Telescope find_files find_command=rg,--hidden,--files,--follow<CR>", { desc = "Telescope files"})


-- Gitsigns
map("n", "]g", ":Gitsigns next_hunk<CR>", { desc = "next hunk"})
map("n", "[g", ":Gitsigns prev_hunk<CR>", { desc = "prev hunk"})
map("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { desc = "stage hunk"})
map("n", "<leader>gu", ":Gitsigns undu_stage_hunk<CR>", { desc = "undo stage hunk"})
map("n", "<leader>gv", ":Gitsigns preview_hunk<CR>", { desc = "preview hunk"})
map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { desc = "reset hunk"})
map("n", "<leader>gb", ":Gitsigns blame_line<CR>", { desc = "blame line"})
map("n", "<leader>gB", ":Gitsigns toggle_current_line_blame<CR>", { desc = "toggle line blame"})
map("n", "<leader>gT", ":Gitsigns toggle_signs<CR>", { desc = "toggle signs"})

-- lspconfig
map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "next hunk"})
map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "prev hunk"})

-- vim-tmux-navigator
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { desc = "switch window left" })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { desc = "switch window right" })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { desc = "switch window down" })
map("n", "<C-k>", ":TmuxNvaigateUp<CR>", { desc = "switch window up" })
map("n", "<C-\\>", ":TmuxNavigatePrevious<CR>", { desc = "switch window left" })

