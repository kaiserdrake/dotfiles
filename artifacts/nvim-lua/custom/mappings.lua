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

-- Gitsigns
M.gitsigns = {
  n = {
    ["]g"] = {"<cmd> Gitsigns next_hunk<CR>", "ﰚ next hunk"},
    ["[g"] = {"<cmd> Gitsigns prev_hunk<CR>", "ﰜ prev hunk"},

    ["<leader>g"] = {"+GitSigns"},
    ["<leader>gs"] = {"<cmd> Gitsigns stage_hunk<CR>", "  stage hunk"},
    ["<leader>gu"] = {"<cmd> Gitsigns undu_stage_hunk<CR>", "  undo stage hunk"},
    ["<leader>gv"] = {"<cmd> Gitsigns preview_hunk<CR>", "  preview hunk"},
    ["<leader>gr"] = {"<cmd> Gitsigns reset_hunk<CR>", "  reset hunk"},
    ["<leader>gb"] = {"<cmd> Gitsigns blame_line<CR>", "  blame line"},
    ["<leader>gB"] = {"<cmd> Gitsigns toggle_current_line_blame<CR>", "⏼  toggle line blame"},
    ["<leader>gT"] = {"<cmd> Gitsigns toggle_signs<CR>", "⏼  toggle signs"},
  }
}

-- lspconfig
M.lspconfig = {
  n = {
    ["]d"] = {function() vim.diagnostic.goto_next() end, "ﰚ next hunk"},
    ["[d"] = {function() vim.diagnostic.goto_prev() end, "ﰜ prev hunk"},

    ["<leader>l"] = {"+LspConfig"},
    ["<leader>la"] = {function() vim.lsp.buf.code_action() end, "  code action"},
    ["<leader>lo"] = {function() vim.diagnostic.open_float() end, "  floating diagnostic"},
  }
}

return M
