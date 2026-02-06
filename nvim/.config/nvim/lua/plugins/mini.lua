return {
  -- mini.pick configuration
  {
    "echasnovski/mini.pick",
    version = false,
    config = function()
      require("mini.pick").setup()
      -- Overwrite the default Neovim selector with mini.pick
      vim.ui.select = require("mini.pick").ui_select
    end,
  },
}
