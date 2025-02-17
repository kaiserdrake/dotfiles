return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      git = { enable = true },
      filters = {
        dotfiles = false,
        custom = { "node_modules" },
      },

      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true
      },

      view = {
        adaptive_size = false,
        side = "left",
        width = 24,
      },

      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
    },
  },
}
