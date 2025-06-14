return {
  -- signature
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

  -- highlight whitespace
  {
    'johnfrankmorgan/whitespace.nvim',
    lazy = false,
    config = function ()
      require('whitespace-nvim').setup({
        -- `highlight` configures which highlight is used to display
        -- trailing whitespace
        highlight = 'DiffDelete',
        -- `ignored_filetypes` configures which filetypes to ignore when
        -- displaying trailing whitespace
        ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help', 'dashboard' },
        ignore_terminal = true,
        return_cursor = true,
      })
    end,
  },

  -- blink
  -- { import = "nvchad.blink.lazyspec" },
}
