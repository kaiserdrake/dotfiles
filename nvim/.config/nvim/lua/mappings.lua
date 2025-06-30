require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- Telescope
map("n", "<leader>ff", ":Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", { desc = "Telescope find file"})
map("n", "<leader>fe", ":Telescope file_browser<CR>", { desc = "Telescope file browser"})
map("n", "<leader>fn", ":Telescope find_files find_command=rg,-uu,--files,--follow cwd="..os.getenv("FILESTORE_PATH").."/notes<CR>", { desc = "Telescope find notes"})
map("n", "<leader>fN", ":Telescope find_files find_command=rg,-uu,--files,--follow cwd=~/Nextcloud/Notes<CR>", { desc = "Telescope find cloud notes"})
map("n", "<leader>fW", ":Telescope grep_string<CR>", { desc = "Telescope grep string"})
map("n", "<leader>fp", ":lua require'telescope'.extensions.project.project{}<CR>", { desc = "Telescope projects"})
-- muscle memory fallthrough
map("n", "<C-x>b", ":Telescope buffers<CR>", { desc = "Telescope buffers"})
map("n", "<C-x>f", ":Telescope find_files find_command=rg,--hidden,--files,--follow<CR>", { desc = "Telescope files"})
-- scratch shortcut
local scratch_pad = os.getenv("FILESTORE_PATH").."/notes/scratch.md"
map("n", "<C-x>n", ":e "..scratch_pad.."<CR>", { desc = "Open scratch file"})

-- Oil
map("n", "<C-x>o", ":Oil --float<CR>", { desc = "Open oil"})

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
map({ "n", "v" }, "<leader>da", ":lua vim.lsp.buf.code_action()<CR>", { desc = "LSP code action"})
map({ "n", "i" }, "<C-k>", function() vim.diagnostic.open_float(0, {scope='line'}) end, { desc = "Show diagnostic message"})


-- Copilot
map('i', '<C-l>', function () vim.fn.feedkeys(vim.fn['copilot#Accept'](), '') end, { desc = 'Copilot Accept', noremap = true, silent = true })
