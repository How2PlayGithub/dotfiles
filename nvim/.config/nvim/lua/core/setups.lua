vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

require("lualine").setup({
    options = {
        component_separators = " ",
        section_separators = { left = "", right = "" },
    },
})

require("nvim-autopairs").setup()

require("gitsigns").setup()

require("ibl").setup({
    indent = { char = "┊" },
    scope = { enabled = false },
})

require("colorizer").setup()
require("todo-comments").setup()

vim.cmd("packadd cfilter")

vim.cmd([[
call deoplete#custom#var('omni', 'input_patterns', {
    \ 'tex': g:vimtex#re#deoplete
    \})
    ]])

require('mini.surround').setup()
require("oil").setup({
    view_options = {
        show_hidden = true,
    }
})

require('obsidian').setup({
    workspaces = {
        {
            name = "personal",
            path = "~/valley of riches/",
        }
    },

    notes_subdir = "Notes",
    new_notes_location = "~/valley of riches/Notes/",

    templates = {
        folder = "~/valley of riches/99 - Meta/Templates/",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
    },

    disable_frontmatter = true,
    ui = { enable = false }
})

require("lspconfig")["tinymist"].setup {
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
        semanticTokens = "disable"
    }
}

vim.g.vsnip_snippet_dir = vim.fn.expand('~/.config/nvim/lua/plugins/snippets/')

local ls = require("luasnip")

ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
})

vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

require("luasnip.loaders.from_lua").load({
    paths = { vim.fn.stdpath("config") .. "/lua/plugins/snippets/" }
})
