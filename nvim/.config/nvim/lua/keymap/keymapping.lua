local wk = require('which-key')

-- Register global mappings
wk.register({
  f = {
    name = "+Find",
    f = {"<cmd>Telescope find_files find_command=rg,-uu,--files,--follow<cr>",
    "Find File"},
    F = {"<cmd>Telescope find_files find_command=rg,-uu,--files,--follow cwd="..os.getenv("HOME").."<cr>",
    "Find All Files"},
    d = {"<cmd>Telescope dotfiles path="..os.getenv("HOME").."/.dotfiles<cr>", "Find Dotfile"},
    g = {"<cmd>Telescope git_files<cr>", "Find Git File"},
    b = {"<cmd>lua require('telescope.builtin').file_browser({hidden=true})<cr>", "Browse File"},
    e = {"<cmd>Explore .<cr>", "Exlore mode"},
    w = {"<cmd>Telescope grep_string<cr>", "Find under cursor"},
    r = {"<cmd>Telescope live_grep grep_open_files=true<cr>", "Search Buffers"},
    S = {"<cmd>Telescope live_grep cwd="..os.getenv("HOME").."<cr>", "Search All"},
    s = {"<cmd>Telescope live_grep<cr>", "Search"},
  },
  b = {"<cmd>Telescope buffers<cr>", "Buffers"},
  s = {
    name = "+Session",
    s = {"<cmd>SaveSession<cr>", "Save"},
    l = {"<cmd>RestoreSession<cr>", "Load"},
    d = {"<cmd>DeleteSession<cr>", "Delete"},
  },
  w = {
    name = "+VimWiki",
    x = {"<cmd>VimwikiIndex<cr><cmd>VimwikiGoto Scratch<cr>", "VimWiki Scratch"},
    c = {"<cmd>VimwikiIndex<cr><cmd>VimwikiGoto commands<cr>", "VimWiki Commands"},
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
  h = {
    name = "+GitSigns",
    b = {"Blame Line"},
    u = {"Undo Stage Hunk"},
    p = {"Preview Hunk"},
    r = {"Reset Hunk"},
    s = {"Stage Hunk"},
  },
  t = {
    name = "+Tools",
    p = {
      name = "+Packer",
      u = {"<cmd>PackerUpdate<cr>", "Update"},
      i = {"<cmd>PackerInstall<cr>", "Install"},
      c = {"<cmd>PackerCompile<cr>", "Compile"},
      d = {"<cmd>PackerClean<cr>", "Clean"},
      s = {"<cmd>PackerSync<cr>", "Sync"},
    },
    g = {
      name = "+Ctags",
      c = {"<cmd>GutentagsClearCache<cr>", "Clear Cache"},
      u = {"<cmd>GutentagsUpdate<cr>", "Update Tags"},
    },
  },
  e = {
    name = "+Settings",
    n = {
      name = "+Line number",
      n = {"<cmd>lua require('core.global'):set_linenumber('on')<cr>", "Show Number"},
      r = {"<cmd>lua require('core.global'):set_linenumber('relative')<cr>", "Show Relative Number"},
      h = {"<cmd>lua require('core.global'):set_linenumber('off')<cr>", "Hide Number"},
    },
  },
 }, { prefix = "<leader>" })
