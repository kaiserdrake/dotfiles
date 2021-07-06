local editor = {}
local conf = require('modules.editor.config')

-- Provides automatic closing of quotes, parenthesis, and brackets
editor['Raimondi/delimitMate'] = {
  event = 'InsertEnter',
  config = conf.delimimate,
}

-- Provides accelerated scrolling with j/k when key is repeating
editor['rhysd/accelerated-jk'] = {
  opt = true
}

-- Provides loading of coding style using EditorConfig
editor['editorconfig/editorconfig-vim'] = {
  opt = false
}

-- Provides highlighting of word under cursor
editor['itchyny/vim-cursorword'] = {
  event = {'BufReadPre','BufNewFile'},
  config = conf.vim_cursorword
}

-- Provides enhancement to f/t/F/T navigations
editor['hrsh7th/vim-eft'] = {
  opt = true,
  config = function()
    vim.g.eft_ignorecase = true
  end
}

-- Provides automatic cwd to project root
editor['airblade/vim-rooter'] = {
  config = conf.vim_rooter,
}

-- Provides onedark theme
editor['joshdick/onedark.vim'] = {
  config = conf.onedark
}

-- Provides fuzzy search of files, buffers, etc
editor['nvim-telescope/telescope.nvim'] = {
  opt = false,
  config = conf.telescope,
  requires = {
    {'nvim-lua/popup.nvim', opt = false},
    {'nvim-lua/plenary.nvim', opt = false},
    {'nvim-telescope/telescope-fzy-native.nvim', opt = false},
  }
}

-- Provides highlighting based on tree-sitter in neovim
editor['nvim-treesitter/nvim-treesitter'] = {
  event = 'BufRead',
  after = 'telescope.nvim',
  config = conf.nvim_treesitter,
}

-- Provides customization of textobjects for tree-stitter
editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
  after = 'nvim-treesitter'
}

-- Provides customization on status line
editor['glepnir/galaxyline.nvim'] = {
  config = conf.galaxyline,
  requires = {'kyazdani42/nvim-web-devicons', opt = false},
  requires = {'ryanoasis/vim-devicons', opt = true}
}

-- Provides bufferline in place of tabs
editor['akinsho/nvim-bufferline.lua'] = {
  requires = {'kyazdani42/nvim-web-devicons', opt = false},
  config = conf.bufferline,
}

-- Provides git icons
editor['lewis6991/gitsigns.nvim'] = {
  event = {'BufRead', 'BufNewFile'},
  config = conf.gitsigns,
  requires = {'nvim-lua/plenary.nvim', opt = true}
}

-- Provides indent markers on blank lines
editor['lukas-reineke/indent-blankline.nvim'] = {
  event = 'BufRead',
  branch = 'master',
  config = conf.indent_blankline
}

-- Provides orgmode folding and highlighting support
editor['axvr/org.vim'] = {
  opt = false
}

-- Provides whichkey mapping
editor['folke/which-key.nvim'] = {
  config = conf.which_key
}

-- Provides note taking capability
editor['vimwiki/vimwiki'] = {
  config = conf.vimwiki
}

return editor
