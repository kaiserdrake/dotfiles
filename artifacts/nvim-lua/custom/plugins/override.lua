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
  sync_install = true,
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
}

return M
