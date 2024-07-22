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

			wk.setup()

			-- TODO: move to .add
			wk.register({
				["<leader>"] = {
					f = { name = "+find", g = { name = "+git" } },
					g = { name = "+git" },
					h = { name = "+harpoon" },
					s = { name = "+suga [LSP]" },
					t = { name = "+file tree" },
					c = {
						name = "+code",
					},
					x = { name = "+trouble" },
				},
				c = { name = "+comment [LSP]" },
				g = { name = "+goto" },
				["]"] = { name = "+next" },
				["["] = { name = "+previous" },
			})
		end,
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
}
