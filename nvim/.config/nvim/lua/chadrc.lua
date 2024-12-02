local M = {}
local fn = vim.fn

M.base46 = {
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
    theme = "grid",
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" },
  },
}

return M
