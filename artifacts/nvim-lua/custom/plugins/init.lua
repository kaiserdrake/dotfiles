return {
  ["folke/which-key.nvim"] = {
    disable = false
  },
  ["nvim-telescope/telescope-file-browser.nvim"] = {
    after = "telescope.nvim",
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
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },
  ["nvim-orgmode/orgmode"] = {
    config = function()
      require("orgmode").setup {
        org_agenda_files = {'~/.filestore/orgs/*'},
        org_default_notes_file = '~/.filestore/orgs/notes.org',
        org_agenda_templates = {
          t = { description = 'Task', template = '* TODO %?\n  - %u', target = '~/.filestore/orgs/todo.org' },
          n = { description = 'Note', template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?', target = '~/sync/org/notes.org' },
        }
      }
      require('orgmode').setup_ts_grammar()
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,
          disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
          additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
        },
        ensure_installed = {'org'}, -- Or run :TSUpdate org
      }
      vim.cmd('language en_US.utf8')
    end,
  },
  ["ahmedkhalf/project.nvim"] = {
    after = "telescope.nvim",
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
  ["kshenoy/vim-signature"] = {},
  ["editorconfig/editorconfig-vim"] = {},
}
