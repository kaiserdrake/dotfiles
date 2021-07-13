local config = {}

function config.nvim_lsp()
    require('modules.completion.lspconfig')
end

function config.nvim_compe()
    require'compe'.setup {
        enabled = true;
        debug = false;
        min_length = 2;
        preselect = 'disable';
        max_abbr_width = 60;
        max_kind_width = 60;
        max_menu_width = 60;
        allow_prefix_unmatch = false;
        source = {
            path = true;
            buffer = true;
            calc = true;
            vsnip = true;
            nvim_lsp = true;
            nvim_lua = true;
            vsnip = true;
            ultisnips = true;
            spell = false;
            tags = true;
            snippets_nvim = false;
        };
    }
end

function config.vim_vsnip()
    vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config/nvim/snippets'
end

function config.vim_sonictemplate()
    vim.g.sonictemplate_postfix_key = '<C-,>'
    vim.g.sonictemplate_vim_template_dir = os.getenv("HOME").. '/.config/nvim/template'
end

function config.gutentags()
    -- set ctags location in cache dir
    vim.g.gutentags_cache_dir = require('core.global').cache_dir..'/ctags/'
    vim.cmd('command! -nargs=0 GutentagsClearCache call system(\'rm \' . g:gutentags_cache_dir . \'/*\')')
    -- limit generation of tags to project folders only
    vim.g.gutentags_add_default_project_roots = 0
    vim.g.gutentags_project_root = {"package.json", ".git/"}
    -- update tags on buffer write
    vim.g.gutentags_generate_on_new = 1
    vim.g.gutentags_generate_on_missing = 1
    vim.g.gutentags_generate_on_write = 1
    vim.g.gutentags_generate_on_empty_buffer = 0
end

return config
