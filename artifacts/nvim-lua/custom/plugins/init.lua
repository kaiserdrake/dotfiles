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
    "jedi2610/nvim-rooter.lua",
    config = function()
      require("nvim-rooter").setup()
    end,
  },
  {
    "kshenoy/vim-signature"
  },
}
