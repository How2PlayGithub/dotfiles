local lspconfig = require("lspconfig")

require("mason").setup({})
require("mason-lspconfig").setup({
    ensure_installed = {
        "bashls",
        "clangd",
        "csharp_ls",
        "cssls",
        "dotls",
        "eslint",
        "html",
        "jsonls",
        "lua_ls",
        -- "marksman",
        "pylsp",
        "rust_analyzer",
        "sqlls",
        "taplo",
        "tinymist",
        "yamlls",
    },
    automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
