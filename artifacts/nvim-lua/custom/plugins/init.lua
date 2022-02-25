return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    after = "telescope.nvim",
    config = function()
      require("telescope").setup {
        extensions = {
          file_browser = {
          },
        },
      }
      require("telescope").load_extension "file_browser"
    end,
  },
  {
    "nvim-orgmode/orgmode",
    config = function()
      require('orgmode').setup_ts_grammar()
      require("orgmode").setup {
        org_agenda_files = {'~/.filestore/orgs/*'},
        org_default_notes_file = '~/.filestore/orgs/notes.org',
        org_agenda_templates = {
          t = { description = 'Task', template = '* TODO %?\n  - %u', target = '~/.filestore/orgs/todo_list.org' },
          n = { description = 'Note', template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?', target = '~/sync/org/notes.org' },
        }
      }
    end,
  },
  {
    "jedi2610/nvim-rooter.lua",
    config = function()
      require("nvim-rooter").setup()
    end,
  },
  {
    "kshenoy/vim-signature"
  },
  {
    "editorconfig/editorconfig-vim"
  },
}
