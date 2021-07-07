local editor = {}
local conf = require('modules.editor.config')

-- Automatic closing of quotes, parenthesis, and brackets
editor['Raimondi/delimitMate'] = {
  event = 'InsertEnter',
  config = conf.delimimate,
}

-- Accelerated scrolling with j/k when key is repeating
editor['rhysd/accelerated-jk'] = {
  opt = true
}

-- Loading of coding style using EditorConfig
editor['editorconfig/editorconfig-vim'] = {
  opt = false
}

-- Highlighting of word under cursor
editor['itchyny/vim-cursorword'] = {
  event = {'BufReadPre','BufNewFile'},
  config = conf.vim_cursorword
}

-- Enhancement to f/t/F/T navigations
editor['hrsh7th/vim-eft'] = {
  opt = true,
  config = function()
    vim.g.eft_ignorecase = true
  end
}

-- Automatic cwd to project root
editor['airblade/vim-rooter'] = {
  config = conf.vim_rooter,
}

-- Onedark theme
editor['joshdick/onedark.vim'] = {
  config = conf.onedark
}

-- Fuzzy search of files, buffers, etc
editor['nvim-telescope/telescope.nvim'] = {
  opt = false,
  config = conf.telescope,
  requires = {
    {'nvim-lua/popup.nvim', opt = false},
    {'nvim-lua/plenary.nvim', opt = false},
    {'nvim-telescope/telescope-fzy-native.nvim', opt = false},
  }
}

-- Highlighting based on tree-sitter in neovim
editor['nvim-treesitter/nvim-treesitter'] = {
  event = 'BufRead',
  after = 'telescope.nvim',
  config = conf.nvim_treesitter,
}

-- Customization of textobjects for tree-stitter
editor['nvim-treesitter/nvim-treesitter-textobjects'] = {
  after = 'nvim-treesitter'
}

-- Customization on status line
editor['glepnir/galaxyline.nvim'] = {
  config = conf.galaxyline,
  requires = {'kyazdani42/nvim-web-devicons', opt = false},
  requires = {'ryanoasis/vim-devicons', opt = true}
}

-- Bufferline in place of tabs
editor['akinsho/nvim-bufferline.lua'] = {
  requires = {'kyazdani42/nvim-web-devicons', opt = false},
  config = conf.bufferline,
}

-- Git icons
editor['lewis6991/gitsigns.nvim'] = {
  event = {'BufRead', 'BufNewFile'},
  config = conf.gitsigns,
  requires = {'nvim-lua/plenary.nvim', opt = true}
}

-- Indent markers on blank lines
editor['lukas-reineke/indent-blankline.nvim'] = {
  event = 'BufRead',
  branch = 'master',
  config = conf.indent_blankline
}

-- Orgmode folding and highlighting support
editor['axvr/org.vim'] = {
  opt = false
}

-- Whichkey mapping
editor['folke/which-key.nvim'] = {
  config = conf.which_key
}

-- Note taking capability
editor['vimwiki/vimwiki'] = {
  config = conf.vimwiki
}

-- Session management
editor['rmagatti/auto-session'] = {
  config = conf.sessions
}

return editor
