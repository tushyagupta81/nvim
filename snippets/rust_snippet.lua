local ls = require("luasnip")
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("rust", {
	-- Function snippet using fmt for formatting
	s(
		"Rese",
		fmt(
			[[
        Result<{},Box<dyn Error>>
      ]],
			{
				i(0),
			}
		)
	),
})
