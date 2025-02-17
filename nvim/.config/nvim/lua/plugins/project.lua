return {
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
}
