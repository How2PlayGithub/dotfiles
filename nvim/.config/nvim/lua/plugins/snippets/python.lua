local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- Function to generate attributes dynamically
local function gen_attrs(args, snip)
    local nodes = {}
    local count = tonumber(args[1][1]) or 1
    for j = 1, count do
        table.insert(nodes, t({"", "\t\tself.__"}))
        table.insert(nodes, i(j, "attr" .. j))
        table.insert(nodes, t(" = p" .. j))
    end
    return sn(nil, nodes)
end

-- Function to generate parameters dynamically
local function gen_params(args, snip)
    local nodes = {}
    local count = tonumber(args[1][1]) or 1
    for j = 1, count do
        table.insert(nodes, i(j, "p" .. j))
        if j < count then table.insert(nodes, t(", ")) end
    end
    return sn(nil, nodes)
end

ls.add_snippets("python", {
    s("exam_dyn", {
        -- 1. Class Header & Inheritance (Q2 2023/2025)
        t("class "), i(1, "ClassName"),
        c(2, { t(""), sn(nil, { t("("), i(1, "Parent"), t(")") }) }), t({":", ""}),

        -- 2. Choice for super() call (Q2 Helicopter/PuzzleBox) [cite: 490, 1038]
        c(3, { t(""), t({"\tdef __init__(self):", "\t\tsuper().__init__()", ""}),
               sn(nil, { t("\tdef __init__(self, "), d(1, gen_params, {4}), t({"):", ""}),
                         t("\t\tsuper().__init__()"), d(2, gen_attrs, {4}) })
        }),

        -- 4. Attribute Counter (Type 1-5 here)
        t({"", "\t# Number of specific attributes: "}), i(4, "1"),

        -- 5. Dynamic body generation
        d(5, gen_attrs, {4}),
        i(0)
    })
})
