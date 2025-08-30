local ls = require("luasnip")
local s = ls.snippet
-- local t = ls.text_node
local f = ls.function_node
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt
local get_filename = function(_, _)
	return string.upper(vim.fn.fnamemodify(vim.fn.expand("%"), ":t:r") .. "_h")
end

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
	s(
		"def",
		fmt(
			[[
#ifndef {}
#define {}


#endif // !{}
      ]],
			{
				f(get_filename, {}),
				f(get_filename, {}),
				f(get_filename, {}),
			}
		)
	),
})
