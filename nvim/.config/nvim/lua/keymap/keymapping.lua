local wk = require('which-key')

-- Register mappings to which-key
wk.register({
  -- Files
  ["<leader>f"] = {name = "+File"},
  ["<leader>ff"] = {"<cmd>Telescope find_files find_command=rg,--ignore,--files,--follow cwd="..os.getenv("HOME").."<cr>", "Find File"},
  ["<leader>fp"] = {"<cmd>Telescope find_files find_command=rg,--ignore,--files,--follow<cr>", "Find Project File"},
  ["<leader>fh"] = {"<cmd>Telescope find_files find_command=rg,--hidden,--files,--follow<cr>", "Find All Files"},
  ["<leader>fd"] = {"<cmd>Telescope dotfiles path="..os.getenv("HOME").."/.dotfiles<cr>", "Find Dotfile"},
  ["<leader>fg"] = {"<cmd>Telescope git_files<cr>", "Find Git File"},
  ["<leader>fb"] = {"<cmd>Telescope file_browser<cr>", "Browse File"},
  ["<leader>fw"] = {"<cmd>Telescope grep_string<cr>", "Find Word"},
  -- Buffer
  ["<leader>b"] = {name = "+Buffer"},
  ["<leader>bb"] = {"<cmd>Telescope buffers<cr>", "Find Buffer"},
  -- Tools
  ["<leader>t"] = {name = "+Tools"},
  ---- Packer
  ["<leader>tp"] = {name = "+Packer"},
  ["<leader>tpu"] = {"<cmd>PackerUpdate<cr>", "PackerUpdate"},
  ["<leader>tpi"] = {"<cmd>PackerInstall<cr>", "PackerInstall"},
  ["<leader>tpc"] = {"<cmd>PackerCompile<cr>", "PackerCompile"},
  ["<leader>tpd"] = {"<cmd>PackerClean<cr>", "PackerClean"},
  ["<leader>tps"] = {"<cmd>PackerSync<cr>", "PackerSync"},
})
