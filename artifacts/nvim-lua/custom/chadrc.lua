local M = {}
local fn = vim.fn

M.plugins = "custom.plugins"

M.ui = {
  theme = "github_dark",
  hl_override = {
    Comment = { italic = true },
  },
  statusline = {
    theme = "vscode_colored",
    overriden_modules = function(modules)
      modules[9] = (function()

        local current_line = fn.line(".", vim.g.statusline_winid)
        local total_line = fn.line("$", vim.g.statusline_winid)
        local text = math.modf((current_line / total_line) * 100) .. tostring "%%"

        text = (current_line == 1 and "Top") or text
        text = (current_line == total_line and "Bot") or text

        return vim.o.columns > 80 and ("%#StText#  " .. text .. ", Col %c  ") or ("%#StText# " .. text .. " ")
      end)()
    end,
  },
  cheatsheet = {
    theme = "simple"
  },
}

M.mappings = require "custom.mappings"

M.lazy_nvim = {
  performance = {
    rtp = {
      disabled_plugins = vim.tbl_filter(function(plug)
        return not vim.tbl_contains({ "editorconfig" }, plug)
      end,
      require("plugins.configs.lazy_nvim").performance.rtp.disabled_plugins),
    },
  },
}

return M
