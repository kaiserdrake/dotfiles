local M = {}

M.umap = {
  shortcuts = {
    diag_next = "]l",
    diag_prev = "[l",
  },
  telescope = {
    file_browser = "<leader>fe",
    find_notes = "<leader>fn",
    grep_string = "<leader>fW",
  },
  gitsigns = {
    next_hunk = "]g",
    prev_hunk = "[g",
    stage_hunk = "<leader>gs",
    undo_stage_hunk = "<leader>gu",
    reset_hunk = "<leader>gr",
    preview_hunk = "<leader>gv",
    blame_line = "<leader>gb",
    toggle_blame = "<leader>gB",
    toggle_signs = "<leader>gT",
  }
}

return M
