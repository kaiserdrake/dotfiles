local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

-- Core mapping not registered in interactive keymaps
local plug_map = {
  ["i|<TAB>"]          = map_cmd('v:lua.tab_complete()'):with_expr():with_silent(),
  ["i|<S-TAB>"]        = map_cmd('v:lua.s_tab_complete()'):with_silent():with_expr(),
  ["i|<CR>"]           = map_cmd([[compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })]]):with_noremap():with_expr():with_nowait(),
  -- Plugin acceleratedjk
  ["n|j"]              = map_cmd('v:lua.enhance_jk_move("j")'):with_silent():with_expr(),
  ["n|k"]              = map_cmd('v:lua.enhance_jk_move("k")'):with_silent():with_expr(),
  -- Remove highlight
  ["n|<ESC><ESC>"]     = map_cr('noh'):with_noremap():with_silent(),
  -- Peersonal mappings
  ["n|<C-x>b"]         = map_cu('Telescope buffers'):with_noremap():with_silent(),
  ["n|<C-x>f"]         = map_cu('Telescope find_files find_command=rg,--ignore,--files,--follow'):with_noremap():with_silent(),
  ["n|<C-x>F"]         = map_cu('Telescope find_files find_command=rg,--hidden,--files,--follow'):with_noremap():with_silent(),
};

bind.nvim_load_mapping(plug_map)
