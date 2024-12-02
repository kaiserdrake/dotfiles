
local configs = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

local servers = {
  html = {},
  cssls = {},
  jsonls = {},
  ts_ls = {},
  bashls = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "basic",
        },
      },
    },
  },
  clangd = {},
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end

-- clangd
lspconfig.clangd.setup {
  on_attach = configs.on_attach,
  capabilities = configs.capabilities,
  cmd = {
    "clangd",
    "--offset-encoding=utf-16",
  },
}
