local wk = require('which-key')

-- Register mappings to which-key
wk.register({
  ["<leader>"] = {
    f = {
      name = "+File",
      f = {"<cmd>Telescope find_files find_command=rg,--ignore,--files,--follow cwd="..os.getenv("HOME").."<cr>", "Find File"},
      h = {"<cmd>Telescope find_files find_command=rg,--hidden,--files,--follow cwd="..os.getenv("HOME").."<cr>", "Find All Files"},
      p = {"<cmd>Telescope find_files find_command=rg,--ignore,--files,--follow<cr>", "Find Project File"},
      h = {"<cmd>Telescope find_files find_command=rg,--hidden,--files,--follow<cr>", "Find All Project Files"},
      d = {"<cmd>Telescope dotfiles path="..os.getenv("HOME").."/.dotfiles<cr>", "Find Dotfile"},
      g = {"<cmd>Telescope git_files<cr>", "Find Git File"},
      b = {"<cmd>Telescope file_browser<cr>", "Browse File"},
      w = {"<cmd>Telescope grep_string<cr>", "Find Word"},
    },
    b = {"<cmd>Telescope buffers<cr>", "Find Buffer"},
    c = {
      name = "+Quickfix list",
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
  },
 })
