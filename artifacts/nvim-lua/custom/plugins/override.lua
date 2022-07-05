-- overriding default plugin configs

local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "html",
    "css",
    "javascript",
    "json",
    "toml",
    "markdown",
    "c",
    "bash",
    "lua",
  },
}

M.nvimtree = {
  git = {
    enable = true,
  },
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  view = {
    adaptive_size = false,
    side = "right",
    width = 32,
  },
}

return M
