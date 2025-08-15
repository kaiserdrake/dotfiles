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

-- Disable virtual_text because its too intrusive
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  update_in_insert = false,
})

vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = {'E501'},
          maxLineLength = 100
        }
      }
    }
  }
})

vim.lsp.enable(servers)
