local M = {}

-- Telescope
M.telescope = {
  n = {
    ["<leader>f"] = {"+Telescope"},
    ["<leader>fe"] = {"<cmd> Telescope file_browser<CR>", "  file browser"},
    ["<leader>fn"] = {"<cmd> Telescope find_files find_command=rg,-uu,--files,--follow cwd="..os.getenv("FILESTORE_PATH").."/orgs<CR>", "  find notes"},
    ["<leader>fW"] = {"<cmd> Telescope grep_string<CR>", "  grep string"},
    ["<leader>fp"] = {"<cmd> Telescope projects<CR>", "  projects"},
    -- muscle memory fallthrough
    ["<C-x>b"] = {"<cmd> Telescope buffers<CR>", "  buffers"},
    ["<C-x>f"] = {"<cmd> Telescope find_files find_command=rg,--hidden,--files,--follow<CR>", "  files"},
  }
}

return M
