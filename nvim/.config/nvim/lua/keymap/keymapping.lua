local wk = require('which-key')

-- Register mappings to which-key
wk.register({
  ["<leader>"] = {
    f = {
      name = "+File",
      f = {"<cmd>Telescope find_files find_command=rg,--ignore,--files,--follow cwd="..os.getenv("HOME").."<cr>",
           "Find File"},
      F = {"<cmd>Telescope find_files find_command=rg,--hidden,--files,--follow cwd="..os.getenv("HOME").."<cr>",
           "Find All Files"},
      p = {"<cmd>Telescope find_files find_command=rg,--ignore,--files,--follow<cr>", "Find Project File"},
      P = {"<cmd>Telescope find_files find_command=rg,--hidden,--files,--follow<cr>", "Find All Project Files"},
      d = {"<cmd>Telescope dotfiles path="..os.getenv("HOME").."/.dotfiles<cr>", "Find Dotfile"},
      g = {"<cmd>Telescope git_files<cr>", "Find Git File"},
      b = {"<cmd>lua require('telescope.builtin').file_browser({hidden=true})<cr>", "Browse File"},
      e = {"<cmd>Explore .<cr>", "Exlore mode"},
      w = {"<cmd>Telescope grep_string<cr>", "Find Word"},
    },
    b = {"<cmd>Telescope buffers<cr>", "Find Buffer"},
    c = {
      name = "+Quickfix list",
    },
    w = {
      name = "+vimwiki",
      x = {"<cmd>VimwikiIndex<cr><cmd>VimwikiGoto Scratch<cr>", "Vimwiki Scratch"},
      c = {"<cmd>VimwikiIndex<cr><cmd>VimwikiGoto Commands<cr>", "Vimwiki Commands"},
      ["<space>"] = {
        name = "+More..."
      },
    },
    l = {
        name = "+Lsp",
        S = {"<cmd>LspStart<cr>", "LspStart"},
        s = {"<cmd>LspStop<cr>", "LspStop"},
        r = {"<cmd>LspRestart<cr>", "LspRestart"},
        i = {"<cmd>LspInfo<cr>", "LspInfo"},
        ["="] = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Formatting"},
        d = {"<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Document symbol"},
        w = {"<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", "Workspace symbol"},
        a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action"},
    },
    t = {
      name = "+Tools",
      p = {
        name = "+Packer",
        u = {"<cmd>PackerUpdate<cr>", "PackerUpdate"},
        i = {"<cmd>PackerInstall<cr>", "PackerInstall"},
        c = {"<cmd>PackerCompile<cr>", "PackerCompile"},
        d = {"<cmd>PackerClean<cr>", "PackerClean"},
        s = {"<cmd>PackerSync<cr>", "PackerSync"},
      },
      g = {
        name = "+Ctags",
        c = {"<cmd>GutentagsClearCache<cr>", "Clear ctags cache"},
        u = {"<cmd>GutentagsUpdate<cr>", "Update ctags"},
      },
    },
    e = {
      name = "+Editor settings",
      n = {
        name = "+Line number",
        n = {"<cmd>lua require('core.global'):set_linenumber('on')<cr>", "Show line number"},
        r = {"<cmd>lua require('core.global'):set_linenumber('relative')<cr>", "Show relative line number"},
        h = {"<cmd>lua require('core.global'):set_linenumber('off')<cr>", "Hide line number"},
      }

    }
  },
 })
