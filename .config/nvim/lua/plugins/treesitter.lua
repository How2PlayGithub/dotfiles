require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "c",
        "rust",
        "lua",
        "typescript",
        "http",
        "html",
        "css",
        "hjson",
        "diff",
        "bash",
        "cmake",
        "dot",
        "javascript",
        "java",
        "latex",
        "markdown",
        "markdown_inline",
        "php",
        "python",
        "regex",
        "query",
        "scss",
        "sql",
        "rasi",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },
    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,
    -- Automatically install missing parsers when entering buffer
    auto_install = true,
    -- List of parsers to ignore installing (for "all")
    ignore_install = {},
    highlight = {
        enable = true,
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB

            -- Get the file name and check its stats
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if not ok or not stats then
                return false
            end

            -- Check if the file size exceeds the maximum allowed size
            if stats.size > max_filesize then
                return true
            end

            -- Check if the file is a LaTeX file based on its extension
            local file_name = vim.api.nvim_buf_get_name(buf)
            local ext = file_name:match("%.([%w]+)$")
            if ext and ext:lower() == 'tex' then
                return true
            end

            return false
        end,
        additional_vim_regex_highlighting = false,
    },
})
