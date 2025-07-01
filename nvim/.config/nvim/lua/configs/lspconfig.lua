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

-- Disable virtual_text because its too intrusive
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  update_in_insert = false,
})
