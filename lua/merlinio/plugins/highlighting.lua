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
				highlight = {
					enable = true,
					disable = function(lang, buf)
						if lang == "latex" then
							return true
						end
						local max_filesize = 1024 * 1024 -- 1 MiB
						local ok, stats = pcall(
							vim.loop.fs_stat,
							vim.api.nvim_buf_get_name(buf)
						)
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
				indent = { enable = true },
			})
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		submodules = false,
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
				condition = function(bufnr)
					local max_filesize = 1024 * 1024 -- 1 MiB
					local ok, stats = pcall(
						vim.loop.fs_stat,
						vim.api.nvim_buf_get_name(bufnr)
					)
					if ok and stats and stats.size > max_filesize then
						return false
					else
						return true
					end
				end,
				blacklist = { "c", "cpp" },
			}
		end,
	},
}
