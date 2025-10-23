return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy", -- fix to prevent which-key ignoring the first invocation
    -- commit = "4f9448c", -- use old version to avoid CR map issue
    config = function()
      require("orgmode").setup {
        -- org_agenda_files = {'~/.filestore/orgs/*'},
        org_default_notes_file = '~/.filestore/orgs/notes.org',
        org_agenda_templates = {
          t = { description = 'Task', template = '* TODO %?\n  - %u', target = '~/.filestore/orgs/notes.org' },
          n = { description = 'Note', template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?', target = '~/sync/org/notes.org' },
        },
      }

      vim.cmd('language en_US.utf8')
    end,
  },
}
