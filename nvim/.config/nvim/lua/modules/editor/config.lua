local config = {}

function config.delimimate()
    vim.g.delimitMate_expand_cr = 0
    vim.g.delimitMate_expand_space = 1
    vim.g.delimitMate_smart_quotes = 1
    vim.g.delimitMate_expand_inside_quotes = 0
    vim.api.nvim_command('au FileType markdown let b:delimitMate_nesting_quotes = ["`"]')
end

function config.nvim_colorizer()
    require 'colorizer'.setup {
        css = { rgb_fn = true; };
        scss = { rgb_fn = true; };
        sass = { rgb_fn = true; };
        stylus = { rgb_fn = true; };
        vim = { names = true; };
        tmux = { names = false; };
        'javascript';
        'javascriptreact';
        'typescript';
        'typescriptreact';
        html = {
            mode = 'foreground';
        }
    }
end

function config.vim_cursorword()
    vim.api.nvim_command('augroup user_plugin_cursorword')
    vim.api.nvim_command('autocmd!')
    vim.api.nvim_command('autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0')
    vim.api.nvim_command('autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif')
    vim.api.nvim_command('autocmd InsertEnter * let b:cursorword = 0')
    vim.api.nvim_command('autocmd InsertLeave * let b:cursorword = 1')
    vim.api.nvim_command('augroup END')
end

function config.vim_rooter()
    vim.g.rooter_silent_chdir = 1
    vim.g.rooter_resolve_links = 1
    vim.g.rooter_patterns = {"package.json", ".git/"}
end

function config.telescope()
    if not packer_plugins['plenary.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
        vim.cmd [[packadd popup.nvim]]
        vim.cmd [[packadd telescope-fzy-native.nvim]]
    end
    require('telescope').setup {
        defaults = {
            find_command = {
                "rg",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--smart-case",
                "--follow",
                "-uu",
            },
            prompt_prefix = '> ',
            selection_caret = " ",
            sorting_strategy = 'descending',
            layout_strategy = 'flex',
            file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
            qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
            file_ignore_patterns = {
                'node_modules/.*',
                '.git/.*',
                '.clangd/.*',
            },
            path_display = {
                'absolute',
            },
        },
        pickers = {
            buffers = {
                results_title = "",
                sort_lastused = true,
                mappings = {
                    i = {
                        ["<c-d>"] = require("telescope.actions").delete_buffer,
                    },
                    n = {
                        ["<c-d>"] = require("telescope.actions").delete_buffer,
                    }
                }
            },
            find_files = {
                results_title = "",
            },
        },
        extensions = {
            fzy_native = {
                override_generic_sorter = false,
                override_file_sorter = true,
            },
        },
    }
    require'telescope'.load_extension('dotfiles')
end

function config.nvim_treesitter()
    vim.api.nvim_command('set foldmethod=expr')
    vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
    require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained",
        highlight = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
        },
    }
end

function config.galaxyline()
    require('modules.editor.statusline')
end

function config.bufferline()
    local c = require('onedark.colors')
    require("bufferline").setup {
        options = {
            indicator_icon = "▎",
            buffer_close_icon = "",
            modified_icon = "●",
            close_icon = "",
            close_command = "bdelete %d",
            right_mouse_command = "bdelete! %d",
            left_trunc_marker = "",
            right_trunc_marker = "",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "",
                    text_align = "center",
                    padding = 1,
                },
            },
            show_tab_indicators = true,
            show_close_icon = false,
            show_buffer_close_icons = false,
            diagnostics = false,
        },
        highlights = {
            -- set tab fill to slightly darker color
            fill = {
                guifg = c.grey,
                guibg = c.bg_d,
            },
            background = {
                guifg = c.grey,
                guibg = c.bg_d,
            },
            separator = {
                guifg = c.bg_d,
                guibg = c.bg_d,
            },
        },
    }
end

function config.onedark()
    vim.g.disable_toggle_style = 1
    require('onedark').setup()
    local c = require('onedark.colors')
    -- telescope highlight override
    vim.api.nvim_command[[autocmd ColorScheme * highlight TelescopeBorder guifg=c.grey]]
end

function config.gitsigns()
    if not packer_plugins['plenary.nvim'].loaded then
        vim.cmd [[packadd plenary.nvim]]
    end
    require('gitsigns').setup {
        signs = {
            add          = {hl = 'GitSignsAdd'   , text = '+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
            change       = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
            delete       = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
            topdelete    = {hl = 'GitSignsDelete', text = '-', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
            changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
        },
        keymaps = {
            -- Default keymap options
            noremap = true,
            buffer = true,

            ['n ]g'] = { expr = true, "&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
            ['n [g'] = { expr = true, "&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

            ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
            ['n <leader>gu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
            ['n <leader>gr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
            ['n <leader>gv'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
            ['n <leader>gb'] = '<cmd>lua require"gitsigns".blame_line()<CR>',

            ['n <leader>gt'] = '<cmd>lua require"gitsigns".toggle_signs()<CR>',

            -- Text objects
            ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
            ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
        },
        current_line_blame = false,
        current_line_blame_delay = 750,
        current_line_blame_position = 'eol',
    }
end

function config.indent_blankline()
    vim.g.indent_blankline_char = "│"
    vim.g.indent_blankline_show_first_indent_level = true
    vim.g.indent_blankline_filetype_exclude = {
        "startify",
        "dashboard",
        "dotooagenda",
        "log",
        "fugitive",
        "gitcommit",
        "packer",
        "vimwiki",
        "markdown",
        "json",
        "txt",
        "vista",
        "help",
        "todoist",
        "peekaboo",
        "git",
        "TelescopePrompt",
        "undotree",
        "flutterToolsOutline",
        "" -- for all buffers without a file type
    }
    vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_current_context = true
    vim.g.indent_blankline_context_patterns = {
        "class",
        "function",
        "method",
        "block",
        "list_literal",
        "selector",
        "^if",
        "^table",
        "if_statement",
        "while",
        "for"
    }
    -- because lazy load indent-blankline so need readd this autocmd
    vim.cmd('autocmd CursorMoved * IndentBlanklineRefresh')
end

function config.which_key()
    require("which-key").setup {
        show_help = true,
        ignore_missing = false,
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CMD>", "<CR>", "<cr>", "call", "lua", "^:", "^ ", "<Plug>"},
        key_labels = {
            ["<space>"] = "SPC",
            ["<cr>"] = "ENTER",
            ["<tab>"] = "TAB"
        },
        plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = false, -- adds help for operators like d, y, ...
                motions = false, -- adds help for motions
                text_objects = false, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "→", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
        },
        triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
        },
        window = {
            border = "none", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 6, -- spacing between columns
            align = "left",
        },
    }
    require('keymap.whichkeymapping')
end

function config.vimwiki()
    wikipath = require('core.global').filestore..'/wikinotes'
    vim.g.vimwiki_list = {{path=wikipath,
        syntax='markdown',
        ext='.md',
        auto_diary_index=1}}
    vim.g.vimwiki_global_ext = 0
    vim.g.vimwiki_key_mappings = {['table_mappings']='0'} -- disable backspace as back
    vim.g.vimwiki_autowriteall = 1 -- enable auto save on vimwiki filetype
end

function config.nvim_comment()
    require('nvim_comment').setup()
end

function config.sessions()
    require('auto-session').setup{
        auto_session_enable_last_session = false,
        auto_session_enable = true,
        auto_session_root_dir = require('core.global').cache_dir.."sessions/",
        auto_save_enabled = true,
    }
end

function config.markdownpreview()
    vim.g.mkdp_auto_start = 0 -- prevent auto preview
    vim.g.mkdp_filetypes = {'markdown','vimwiki'} -- include markdown and vimwiki filetypes
    vim.g.mkdp_open_to_the_world = 1 -- enable external node to view the server
end

return config
