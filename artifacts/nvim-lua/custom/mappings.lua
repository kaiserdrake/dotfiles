local M = {}

-- General mappings
M.general = {
  n = {
    [";"] = { ":", "command mode", opts = { nowait = true } },
  },
  i = {
    ["jk"] = { "<ESC>", "escape insert mode" },
  },
}

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

-- nvterm
M.nvterm = {
  n = {
    ["<leader>gc"] = {
      function()
        require("nvterm.terminal").send("clear && g++ -o out " .. vim.fn.expand "%" .. " && ./out", "vertical")
      end,

      "compile & run a cpp file",
    },
  },
}

return M
