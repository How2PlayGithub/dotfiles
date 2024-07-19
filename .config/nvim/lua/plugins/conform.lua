require("conform").setup({
    formatters_by_ft = {
        markdown = { "prettier" },
        ["*"] = { "codespell" },
        ["_"] = { "trim_whitespace" },
        python = { "black" }
    },
    format_on_save = {
        lsp_fallback = true,
        timeout_ms = 500,
    }
})

require("conform").formatters.shfmt = {
    prepend_args = function(ctx)
        return { "--indent", tostring(vim.bo[ctx.buf].shiftwidth) }
    end
}
