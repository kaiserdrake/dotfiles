return {
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
}
