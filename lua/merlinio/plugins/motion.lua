return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = {
					"n", --[[ "x", "o" ]]
				},
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			}, -- TODO how to use this effectively
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		---@type user_options
		opts = {
			keymaps = {
				insert = false,
				insert_line = false,
				normal = "ys",
				normal_cur = "yss",
				normal_line = false,
				normal_cur_line = false,
				visual = "S",
				visual_line = false,
				delete = "ds",
				change = "cs",
				change_line = false,
			},
		},
	},
}
