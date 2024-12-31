local ls = require("luasnip")
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
	s(
		"con",
		fmt(
			[[
    console.log({});
    ]],
			{ i(0) }
		)
	),
}

ls.add_snippets("javascript", snippets)
ls.add_snippets("typescript", snippets)
ls.add_snippets("javascriptreact", snippets)
ls.add_snippets("typescriptreact", snippets)
