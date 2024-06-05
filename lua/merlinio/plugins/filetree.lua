return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				adaptive_size = true,
			},
		})

		vim.keymap.set(
			"n",
			"<leader>tt",
			"<cmd>NvimTreeToggle<CR>",
			{ desc = "Toggle File Tree" }
		)
		vim.keymap.set(
			"n",
			"<leader>tc",
			"<cmd>NvimTreeFindFile | NvimTreeFocus<CR>",
			{ desc = "Focus Current File in Tree" }
		)
	end,
}
