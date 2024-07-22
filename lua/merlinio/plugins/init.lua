return {
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = true,
	-- 	priority = 1000,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		---@type CatppuccinOptions
		opts = {
			integrations = {
				lsp_trouble = true,
				which_key = true,
				lsp_saga = true,
				noice = true,
				nvim_surround = true,
			},
		},
	},
	{ "nvim-tree/nvim-web-devicons" },
	-- misc
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			local wk = require("which-key")

			wk.add({
				{ "<leader>c", group = "code" },
				{ "<leader>f", group = "find" },
				{ "<leader>fg", group = "git" },
				{ "<leader>g", group = "git" },
				{ "<leader>h", group = "harpoon" },
				{ "<leader>s", group = "suga [LSP]" },
				{ "<leader>t", group = "file tree" },
				{ "<leader>x", group = "trouble" },
				{ "[", group = "previous" },
				{ "]", group = "next" },
				{ "c", group = "comment [LSP]" },
				{ "g", group = "goto" },
			})
		end,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
}
