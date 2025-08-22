local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node
-- local t = ls.text_node
local i = ls.insert_node

local fmt = require("luasnip.extras.fmt").fmt

local get_filename = function(_, _)
	return vim.fn.fnamemodify(vim.fn.expand("%"), ":t:r")
end

ls.add_snippets("c", {
	-- Function snippet using fmt for formatting
	s(
		"ray",
		fmt(
			[[
        #include "raylib.h"

        int {}() {{
          // Tell the window to use vsync and work on high DPI displays
          SetConfigFlags(FLAG_VSYNC_HINT | FLAG_WINDOW_HIGHDPI);

          // Create the window and OpenGL context
          InitWindow(1280, 800, "{}");

          // game loop
          while (!WindowShouldClose()) {{
            // drawing
            BeginDrawing();

            // Setup the back buffer for drawing (clear color and depth buffers)
            ClearBackground(BLACK);
            {}

            EndDrawing();
          }}

          // destroy the window and cleanup the OpenGL context
          CloseWindow();
          return 0;
        }}
      ]],
			{
				f(get_filename, {}),
				f(get_filename, {}),
				i(),
			}
		)
	),
})
