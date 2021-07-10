local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args

-- default map
local def_map = {
  ["n|<C-x>k"]     = map_cr('bdelete'):with_noremap():with_silent(),
  ["n|<C-s>"]      = map_cu('write'):with_noremap(),
  ["n|Y"]          = map_cmd('y$'),
  ["n|]w"]         = map_cu('WhitespaceNext'):with_noremap(),
  ["n|[w"]         = map_cu('WhitespacePrev'):with_noremap(),
  ["n|]b"]         = map_cu('bn'):with_noremap(), -- swapped logic
  ["n|[b"]         = map_cu('bp'):with_noremap(), -- swapped logic
  ["n|<C-h>"]      = map_cmd('<C-w>h'):with_noremap(),
  ["n|<C-l>"]      = map_cmd('<C-w>l'):with_noremap(),
  ["n|<C-j>"]      = map_cmd('<C-w>j'):with_noremap(),
  ["n|<C-k>"]      = map_cmd('<C-w>k'):with_noremap(),
  ["n|<A-[>"]      = map_cr('vertical resize -5'):with_silent(),
  ["n|<A-]>"]      = map_cr('vertical resize +5'):with_silent(),
  ["n|<C-q>"]      = map_cmd(':wq<CR>'),
  -- Insert
  ["i|<C-w>"]      = map_cmd('<C-[>diwa'):with_noremap(),
  ["i|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
  ["i|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
  ["i|<C-u>"]      = map_cmd('<C-G>u<C-U>'):with_noremap(),
  ["i|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
  ["i|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
  ["i|<C-a>"]      = map_cmd('<ESC>^i'):with_noremap(),
  ["i|<C-j>"]      = map_cmd('<Esc>o'):with_noremap(),
  ["i|<C-k>"]      = map_cmd('<Esc>O'):with_noremap(),
  ["i|<C-s>"]      = map_cmd('<Esc>:w<CR>'),
  ["i|<C-q>"]      = map_cmd('<Esc>:wq<CR>'),
  ["i|<C-e>"]      = map_cmd([[pumvisible() ? "\<C-e>" : "\<End>"]]):with_noremap():with_expr(),
  -- command line
  ["c|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
  ["c|<C-f>"]      = map_cmd('<Right>'):with_noremap(),
  ["c|<C-a>"]      = map_cmd('<Home>'):with_noremap(),
  ["c|<C-e>"]      = map_cmd('<End>'):with_noremap(),
  ["c|<C-d>"]      = map_cmd('<Del>'):with_noremap(),
  ["c|<C-h>"]      = map_cmd('<BS>'):with_noremap(),
  ["c|<C-t>"]      = map_cmd([[<C-R>=expand("%:p:h") . "/" <CR>]]):with_noremap(),
}

-- Core mapping not registered in interactive keymaps
local plug_map = {
  ["i|<TAB>"]          = map_cmd([[v:lua.tab_complete()]]):with_expr():with_silent(),
  ["i|<S-TAB>"]        = map_cmd([[v:lua.s_tab_complete()]]):with_silent():with_expr(),
  ["i|<CR>"]           = map_cmd([[compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })]]):with_noremap():with_expr():with_nowait(),
  -- acceleratedjk
  ["n|j"]              = map_cmd([[v:lua.enhance_jk_move("j")]]):with_silent():with_expr(),
  ["n|k"]              = map_cmd([[v:lua.enhance_jk_move("k")]]):with_silent():with_expr(),
  -- Remove highlight
  ["n|<ESC><ESC>"]     = map_cr([[noh]]):with_noremap():with_silent(),
  -- vim-eft
  ["n|;"]              = map_cmd([[v:lua.enhance_ft_move(';')]]):with_expr(),
  ["x|;"]              = map_cmd([[v:lua.enhance_ft_move(';')]]):with_expr(),
  ["n|f"]              = map_cmd([[v:lua.enhance_ft_move('f')]]):with_expr(),
  ["x|f"]              = map_cmd([[v:lua.enhance_ft_move('f')]]):with_expr(),
  ["o|f"]              = map_cmd([[v:lua.enhance_ft_move('f')]]):with_expr(),
  ["n|F"]              = map_cmd([[v:lua.enhance_ft_move('F')]]):with_expr(),
  ["x|F"]              = map_cmd([[v:lua.enhance_ft_move('F')]]):with_expr(),
  ["o|F"]              = map_cmd([[v:lua.enhance_ft_move('F')]]):with_expr(),
  -- Date insertion
  ["i|<C-x>d"]         = map_cmd([[strftime("[%Y-%m-%d %a]")]]):with_noremap():with_expr(),
  ["n|<C-x>d"]         = map_cu([[normal a<C-R>=strftime("[%Y-%m-%d %a]")<CR>]]):with_noremap():with_silent(),
  -- telescope
  ["n|<C-x>b"]         = map_cu([[Telescope buffers]]):with_noremap():with_silent(),
  ["n|<C-x>f"]         = map_cu([[Telescope find_files find_command=rg,-uu,--files,--follow]]):with_noremap():with_silent(),
  ["n|<C-x>F"]         = map_cu([[Telescope find_files find_command=rg,-uu,--files,--follow cwd=]]..os.getenv("HOME")):with_noremap():with_silent(),
  -- quickfix
  ["n|]c"]             = map_cu([[cn]]):with_noremap(),
  ["n|[c"]             = map_cu([[cp]]):with_noremap(),
  ["i|<C-x>cn"]        = map_cmd([[cn]]):with_noremap():with_expr(),
  ["n|<C-x>cn"]        = map_cu([[cn]]):with_noremap():with_silent(),
  ["i|<C-x>cp"]        = map_cmd([[cp]]):with_noremap():with_expr(),
  ["n|<C-x>cp"]        = map_cu([[cp]]):with_noremap():with_silent(),
  ["i|<C-x>co"]        = map_cmd([[copen]]):with_noremap():with_expr(),
  ["n|<C-x>co"]        = map_cu([[copen]]):with_noremap():with_silent(),
  ["i|<C-x>cc"]        = map_cmd([[ccl]]):with_noremap():with_expr(),
  ["n|<C-x>cc"]        = map_cu([[ccl]]):with_noremap():with_silent(),
  ["i|<C-x>cw"]        = map_cmd([[cw]]):with_noremap():with_expr(),
  ["n|<C-x>cw"]        = map_cu([[cw]]):with_noremap():with_silent(),
  ["i|<C-x>cf"]        = map_cmd([[cnf]]):with_noremap():with_expr(),
  ["n|<C-x>cf"]        = map_cu([[cnf]]):with_noremap():with_silent(),
  ["i|<C-x>cg"]        = map_cmd([[.cc]]):with_noremap():with_expr(),
  ["n|<C-x>cg"]        = map_cu([[.cc]]):with_noremap():with_silent(),
};

bind.nvim_load_mapping(def_map)
bind.nvim_load_mapping(plug_map)
