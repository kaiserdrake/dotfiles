return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require("telescope").setup {
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      }
      require("telescope").load_extension('file_browser')
    end,
  },
  {
    'nvim-telescope/telescope-project.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
      require("telescope").setup {
        extensions = {
          project = {
            base_dirs = {
              {'~/WORKSPACE/'},
              {'~/DATASTORE/WORCONF', max_depth = 4},
              {'~/DATASTORE/ARCHIVE', max_depth = 4},
              {'~/.dotfiles/'},
            },
            ignore_missing_dirs = true, -- default: false
            hidden_files = true, -- default: false
            theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = false, -- default false
          },
        },
      }
      require("telescope").load_extension('project')
    end,
    }
  }
