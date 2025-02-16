return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "query",
        "html",
        "css",
        "javascript",
        "json",
        "toml",
        "markdown",
        "c",
        "bash",
        "lua",
        "dockerfile",
        "xml",
        "yaml",
        "yang"
      },
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
  },
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

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "prettier",
        "lua-language-server",
        "stylua",
        -- web dev
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "prettier",
        -- "emmet-ls",
        "json-lsp",
        "tailwindcss-language-server",
        -- shell
        "shfmt",
        "shellcheck",
        "bash-language-server",
        -- c/cpp
        "clangd",
        "clang-format",
      },
    },
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    lazy = false,
    dependencies = {
      "telescope.nvim"
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
    "nvim-orgmode/orgmode",
    lazy = false,
    -- commit = "4f9448c", -- use old version to avoid CR map issue
    config = function()
      require("orgmode").setup {
        org_agenda_files = {'~/.filestore/orgs/*'},
        org_default_notes_file = '~/.filestore/orgs/notes.org',
        org_agenda_templates = {
          t = { description = 'Task', template = '* TODO %?\n  - %u', target = '~/.filestore/orgs/notes.org' },
          n = { description = 'Note', template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?', target = '~/sync/org/notes.org' },
        },
      }

      vim.cmd('language en_US.utf8')
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    lazy = false,
    dependencies = {
      "telescope.nvim"
    },
    config = function()
      require("project_nvim").setup {
        detection_methods = { 'lsp', 'pattern'},
        patterns = { '.git', '.git/' , '.editorconfig'},
        exclude_dirs = { 'build' },
        manual_mode = false,
      }
      require('telescope').load_extension('projects')
    end,
  },

  {
    "kshenoy/vim-signature",
    lazy = false,
  },

  -- get highlight group under cursor
  {
    "nvim-treesitter/playground",
    cmd = "TSCaptureUnderCursor",
    config = function()
      require("nvim-treesitter.configs").setup()
    end,
  },

  -- dim inactive windows
  {
    "andreadev-it/shade.nvim",
    keys = "<Bslash>",
    config = function()
      require("shade").setup {
        exclude_filetypes = { "NvimTree" },
      }
    end,
  },

  -- noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        presets = {
          bottom_search = false, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        views = {
          -- Clean cmdline_popup + palette
          cmdline_popup = {
            position = {
              row = "70%",
              col = "50%",
            },
            border = {
              style = "none",
              padding = { 1, 1 },
            },
            size = {
              min_width = 60,
              width = "auto",
              height = "auto",
            },
            win_options = {
              winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "FloatBorder" },
            },
          },
          cmdline_popupmenu = {
            relative = "editor",
            position = {
              row = "70%",
              col = "50%",
            },
            size = {
              width = 60,
              height = "auto",
              max_height = 15,
            },
            border = {
              style = "none",
              padding = { 0, 2 },
            },
            win_options = {
              winhighlight = { NormalFloat = "NormalFloat", FloatBorder = "NoiceCmdlinePopupBorder" },
            },
          },
          hover = {
            border = {
              style = "single",
            },
          },
          confirm = {
            border = {
              style = "single",
            },
          },
          popup = {
            border = {
              style = "single",
            },
          },
        },
        })
    end,
  },

  {
    "folke/zen-mode.nvim",
    lazy = true,
    cmd = "ZenMode",
    config = function()
      require("zen-mode").setup {
        window = {
          backdrop = 0.93,
          width = 150,
          height = 1,
        },
        plugins = {
          options = {
            showcmd = true, -- disables the command in the last line of the screen
          },
          twilight = { enabled = false }, -- enable to start Twilight when zen mode opens
          gitsigns = { enabled = true }, -- disables git signs
        },
      }
    end,
  },

}
