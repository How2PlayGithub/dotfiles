vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal spell wrap",
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local line = vim.fn.line("'\"")
        if line > 1 and line <= vim.fn.line("$") then
            vim.cmd("normal! g'\"")
        end
    end,
})
