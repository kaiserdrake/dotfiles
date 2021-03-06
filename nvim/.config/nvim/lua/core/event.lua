local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(command)
        end
        vim.api.nvim_command('augroup END')
    end
end

function autocmd.load_autocmds()
    local definitions = {
        packer = {
            {"BufWritePost", "*.lua", "lua require('core.packer').auto_compile()"};
        },
        bufs = {
            -- Reload vim config automatically
            {"BufWritePost", [[$VIM_PATH/{*.vim,*.yaml,vimrc} nested source $MYVIMRC | redraw]]};
            -- Reload Vim script automatically if setlocal autoread
            {"BufWritePost,FileWritePost",
             "*.vim", [[nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]]};
            {"BufWritePre", "/tmp/*", "setlocal noundofile"};
            {"BufWritePre", "COMMIT_EDITMSG", "setlocal noundofile"};
            {"BufWritePre", "MERGE_MSG", "setlocal noundofile"};
            {"BufWritePre", "*.tmp", "setlocal noundofile"};
            {"BufWritePre", "*.bak", "setlocal noundofile"};
            {"BufNewFile", "*filestore/wikinotes/diary/*.md",
            "call append(0,['# '.split(expand('%:r'),'/')[-1],'','## ToDo From Previous Day','','## ToDo','','## Notes', ''])"};
        };

        wins = {
            -- Open default file scratch when no argument is supplied
            {"VimEnter", "*", [[if eval("@%") == "" | e $FILESTORE_PATH/wikinotes/Scratch.md | setl filetype=vimwiki | endif]]};
            -- Highlight current line only on focused window
            {"WinEnter,BufEnter,InsertLeave", "*",
             [[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]]};
            {"WinLeave,BufLeave,InsertEnter", "*",
             [[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]]};
            -- Highlight trailing whitespace
            {"VimEnter", "*", [[call matchadd('NvimInternalError', '\s\+$', 100)]]};
            -- Equalize window dimensions when resizing vim window
            {"VimResized", "*", [[tabdo wincmd =]]};
            -- Force write shada on leaving nvim
            {"VimLeave", "*", [[if has('nvim') | wshada! | else | wviminfo! | endif]]};
            -- Check if file changed when its window is focus, more eager than 'autoread'
            {"FocusGained", "* checktime"};
        };

        ft = {
            {"FileType", "dashboard", "set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2"};
            {"BufNewFile,BufRead","*.toml"," setf toml"};
            {"BufEnter", "*.org", "setlocal formatoptions-=t"};
            {"FileType", "vimwiki,markdown", "nmap <C-x><BS> <Plug>VimwikiGoBackLink"};
        };

        yank = {
            {"TextYankPost", [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=400})]]};
        };
    }

    autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
