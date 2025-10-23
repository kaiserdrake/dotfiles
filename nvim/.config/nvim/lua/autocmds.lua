require "nvchad.autocmds"

-- File extension specific conceallevel
vim.cmd [[ autocmd Filetype org setlocal conceallevel=2 ]]

-- Disable colorcolumn on selected filetypes
vim.cmd [[ autocmd Filetype orgagenda setlocal colorcolumn=0 ]]

-- Disable Copilot in specific directories
local augroup = vim.api.nvim_create_augroup("copilot-disable-patterns", { clear = true })
local disable_dirs = {
    vim.fn.expand "$HOME/WORKSPACE/CONFIDENTIAL" .. "/*",
    vim.fn.expand "$HOME/WORKSPACE/jpman" .. "/*",
    vim.fn.expand "/mnt/workspace/CONFIDENTIAL" .. "/*",
}
for _, pattern in ipairs(disable_dirs) do
    vim.api.nvim_create_autocmd("LspAttach", {
        group = augroup,
        pattern = "*", -- This pattern will match all files, including new buffers
        callback = function(args)
            -- Check if the buffer has a name (file associated) or if CWD starts with /home/user/Documents
            local bufname = vim.api.nvim_buf_get_name(0)
            local cwd = vim.fn.getcwd()

            if bufname == "" and cwd:match("^" .. pattern) or bufname:match(pattern) then
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.name == "copilot" then
                    vim.defer_fn(function()
                        vim.cmd "silent Copilot detach"
                    end, 0)
                end
            end
        end,
    })
end
