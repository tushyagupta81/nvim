local ls = require("luasnip")
local s = ls.snippet
-- local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("python", {
	-- Function snippet using fmt for formatting
	s(
		"__main",
		fmt(
			[[
      if __name__ == "__main__":
          {}
      ]],
			{
				i(0),
			}
		)
	),
})
