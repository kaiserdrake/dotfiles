require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "jsonls",
  "bashls",
  "unocss",
  "pylsp",
  "clangd",
  "lua_ls",
}

vim.lsp.enable(servers)

local lspconfig = require('lspconfig')

-- clangd
lspconfig.clangd.setup({
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
})

-- Disable virtual_text because its too intrusive
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  update_in_insert = false,
})
