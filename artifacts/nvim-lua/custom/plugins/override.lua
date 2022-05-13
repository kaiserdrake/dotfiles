-- overriding default plugin configs

local M = {}

M.treesitter = {
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
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
    "norg",
    "org",
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
}

return M
