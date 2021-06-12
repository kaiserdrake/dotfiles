local wk = require('which-key')

-- Register mappings to which-key
wk.register({
  -- Files
  ["<leader>f"] = {name = "+file"},
  ["<leader>ff"] = {"<cmd>Telescope find_files<cr>", "Find File"},
  ["<leader>fd"] = {"<cmd>Telescope dotfiles path="..os.getenv("HOME").."/.dotfiles<cr>", "Find Dotfile"},
  ["<leader>fb"] = {"<cmd>Telescope file_browser<cr>", "Browse File"},
  -- Buffer
  ["<leader>b"] = {name = "+buffer"},
  ["<leader>bb"] = {"<cmd>Telescope buffers<cr>", "Find Buffer"},
  -- Tools
  ["<leader>t"] = {name = "+tools"},
  ---- Packer
  ["<leader>tp"] = {name = "+packer"},
  ["<leader>tpu"] = {"<cmd>PackerUpdate<cr>", "PackerUpdate"},
  ["<leader>tpi"] = {"<cmd>PackerInstall<cr>", "PackerInstall"},
  ["<leader>tpc"] = {"<cmd>PackerCompile<cr>", "PackerCompile"},
  ["<leader>tpd"] = {"<cmd>PackerClean<cr>", "PackerClean"},
  ["<leader>tps"] = {"<cmd>PackerSync<cr>", "PackerSync"},
})
