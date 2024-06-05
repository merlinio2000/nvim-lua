return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		dependencies = { "rafamadriz/friendly-snippets" },
		keys = {
			{
				"<C-f>",
				mode = { "i", "s" },
				function()
					require("luasnip").jump(1)
				end,
				{ silent = true },
			},
			{
				"<C-b>",
				mode = { "i", "s" },
				function()
					require("luasnip").jump(-1)
				end,
				{ silent = true },
			},
		},
	},
}
