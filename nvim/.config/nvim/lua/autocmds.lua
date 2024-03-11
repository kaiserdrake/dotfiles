-- File extension specific conceallevel
vim.cmd [[ autocmd Filetype org setlocal conceallevel=2 ]]

-- Disable colorcolumn on selected filetypes
vim.cmd [[ autocmd Filetype orgagenda setlocal colorcolumn=0 ]]
