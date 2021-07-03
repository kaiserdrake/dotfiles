local api = vim.api
local lsp = require 'lspconfig'
local global = require 'core.global'

local map = function(type, key, value)
	api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end


local custom_attach = function(client)
	print("LSP started.");
  map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
	map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
	map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
	map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
	map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
	map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
	map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')

  api.nvim_command('autocmd CursorHold <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()')
end

lsp.clangd.setup{
  on_attach = custom_attach,
  default_config = {
    cmd = {
      "clangd", "--background-index", "--pch-storage=memory",
      "--clang-tidy", "--suggest-missing-includes"
    },
    filetypes = {"c", "cpp", "objc", "objcpp"},
    root_dir = [[root_pattern("compile_commands.json", "compile_flags.txt", ".git/") or dirname]];
  },
  handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable virtual_text
        virtual_text = false
      }
    ),
  }
}

lsp.sumneko_lua.setup{
	on_attach = custom_attach,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
			completion = { keywordSnippet = "Disable", },
			diagnostics = { enable = true, globals = {
				"vim", "describe", "it", "before_each", "after_each" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
				}
			}
		}
	}
}

vim.cmd([[sign define LspDiagnosticsSignError text= texthl= linehl= numhl=LspDiagnosticsSignError]])
vim.cmd([[sign define LspDiagnosticsSignWarning text= texthl= linehl= numhl=LspDiagnosticsSignWarning]])
vim.cmd([[sign define LspDiagnosticsSignInformation text= texthl= linehl= numhl=LspDiagnosticsSignInformation]])
vim.cmd([[sign define LspDiagnosticsSignHint text= texthl= linehl= numhl=LspDiagnosticsSignHint]])

local servers = {
  'dockerls','bashls','pyright'
}

for _,server in ipairs(servers) do
  lspconfig[server].setup {
    on_attach = custom_attach
  }
end
