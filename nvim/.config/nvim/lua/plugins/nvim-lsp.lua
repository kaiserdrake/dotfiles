return {
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
}
