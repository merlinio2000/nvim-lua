return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"vimdoc",
					"vim",
					"regex",
					"lua",
					"c",
					"cpp",
					"rust",
					"python",
					"javascript",
					"typescript",
					"markdown",
					"markdown_inline",
				},
				sync_install = false,
				highlight = { enable = true, disable = { "latex" } },
				indent = { enable = true },
			})
		end,
	},
	{
		url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					commonlisp = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterBlue",
					"RainbowDelimiterRed",
					"RainbowDelimiterCyan",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterYellow",
					"RainbowDelimiterOrange",
				},
				blacklist = { "c", "cpp" },
			}
		end,
	},
}
