local wk = require('which-key')

-- Register global <leader> mappings
wk.register({
    b = {"<cmd>Telescope buffers<cr>", "Buffers"},
    c = {"<cmd>noh<cr>", "Clear highlights"},
    f = {
        name = "+Find",
        f = {"<cmd>Telescope find_files find_command=rg,-uu,--files,--follow<cr>",
        "Find file"},
        F = {"<cmd>Telescope find_files find_command=rg,-uu,--files,--follow cwd="..os.getenv("HOME").."<cr>",
        "Find all files"},
        d = {"<cmd>Telescope dotfiles path="..os.getenv("HOME").."/.dotfiles<cr>", "Find dotfile"},
        g = {"<cmd>Telescope git_files<cr>", "Find git file"},
        b = {"<cmd>lua require('telescope.builtin').file_browser({hidden=true})<cr>", "Browse file"},
        e = {"<cmd>Explore .<cr>", "Exlore mode"},
        w = {"<cmd>Telescope grep_string<cr>", "Find under cursor"},
        r = {"<cmd>Telescope live_grep grep_open_files=true<cr>", "Search buffers"},
        S = {"<cmd>Telescope live_grep cwd="..os.getenv("HOME").."<cr>", "Search all"},
        s = {"<cmd>Telescope live_grep<cr>", "Search"},
    },
    g = {
        name = "+Git",
        n = {"Next hunk"},
        p = {"Previous hunk"},
        b = {"Blame line"},
        B = {"<cmd>Gitsigns toggle_current_line_blame<cr>", "Blame current line blame line on hover"},
        u = {"Undo stage hunk"},
        v = {"Preview hunk"},
        r = {"Reset hunk"},
        s = {"Stage hunk"},
        t = {"Toggle signs"},
    },
    l = {
        name = "+Lsp",
        S = {"<cmd>LspStart<cr>", "LspStart"},
        s = {"<cmd>LspStop<cr>", "LspStop"},
        r = {"<cmd>LspRestart<cr>", "LspRestart"},
        i = {"<cmd>LspInfo<cr>", "LspInfo"},
        ["="] = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Formatting"},
        d = {"<cmd>lua vim.lsp.buf.document_symbol()<cr>", "Document symbol"},
        k = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Show diagnostic message"},
        w = {"<cmd>lua vim.lsp.buf.workspace_symbol()<cr>", "Workspace symbol"},
        a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code action"},
    },
    n = {
        name = "+Line number",
        n = {"<cmd>lua require('core.global'):set_linenumber('on')<cr>", "Show number"},
        r = {"<cmd>lua require('core.global'):set_linenumber('relative')<cr>", "Show relative number"},
        h = {"<cmd>lua require('core.global'):set_linenumber('off')<cr>", "Hide number"},
    },
    s = {
        name = "+Session",
        s = {"<cmd>SaveSession<cr>", "Save"},
        l = {"<cmd>RestoreSession<cr>", "Load"},
        d = {"<cmd>DeleteSession<cr>", "Delete"},
    },
    t = {
        name = "+Tools",
        g = {
            name = "+Ctags",
            c = {"<cmd>GutentagsClearCache<cr>", "Clear cache"},
            u = {"<cmd>GutentagsUpdate<cr>", "Update tags"},
        },
        m = {
            name = "+MarkdownPreview",
            s = {"<cmd>MarkdownPreview<cr>", "Preview"},
            S = {"<cmd>MarkdownPreviewStop<cr>", "Preview stop"},
            m = {"<cmd>MarkdownPreviewToggle<cr>", "Preview toggle"},
        },
        p = {
            name = "+Packer",
            u = {"<cmd>PackerUpdate<cr>", "Update"},
            i = {"<cmd>PackerInstall<cr>", "Install"},
            c = {"<cmd>PackerCompile<cr>", "Compile"},
            d = {"<cmd>PackerClean<cr>", "Clean"},
            s = {"<cmd>PackerSync<cr>", "Sync"},
        },
    },
    w = {
        name = "+VimWiki",
        x = {"<cmd>VimwikiIndex<cr><cmd>VimwikiGoto Scratch<cr>", "Scratch"},
        c = {"<cmd>VimwikiIndex<cr><cmd>VimwikiGoto commands<cr>", "Commands"},
        w = "Index",
        i = "Diary index",
        s = "Select",
        r = "Rename file",
        d = "Delete file",
        n = "GoTo",
        h = "Convert to HTML",
        t = "which_key_ignore", -- tab not used making this command reduandant with "w"
        ["<space>"] = {
            name = "+More...",
            i = "Diary generate links",
            w = "Diary entry",
            m = "Diary for tomorrow",
            y = "Diary entry from yesterday",
            t = "which_key_ignore", -- tab not used making this command reduandant with "w"
        },
    },
}, { prefix = "<leader>" })

-- Register "]" (next) mappings
wk.register({
    b = "Next buffer",
    c = "Next quickfix entry",
    g = "Next git hunk",
    l = {"<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next LSP diagnostic"},
    w = "Next whitespace",
}, { prefix = "]" })

-- Register "[" (previous) mappings
wk.register({
    b = "Previous buffer",
    c = "Previous quickfix entry",
    g = "Previous git hunk",
    l = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Previous LSP diagnostic"},
    w = "Previous whitespace",
}, { prefix = "[" })

-- Register <C-x> (shortcuts) mappings
wk.register({
    b = "Buffers",
    c = "Quickfix",
    d = "Insert date",
    f = "Find files",
    F = "Find all files",
    k = "Delete buffer",
}, { prefix = "<C-x>" })
