local ls = require("luasnip")
local s = ls.snippet
-- local t = ls.text_node
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("cpp", {
	-- Function snippet using fmt for formatting
	s(
		"#in",
		fmt(
			[[
        #include <iostream>
        using namespace std;

        int main() {{
          {}
          return 0;
        }}
      ]],
			{
				i(0),
			}
		)
	),
})
