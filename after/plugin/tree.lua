require("nvim-tree").setup({
	view = {
		adaptive_size = true,
	},
})

vim.keymap.set("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Tree" })
vim.keymap.set("n", "<leader>tc", "<cmd>NvimTreeFindFile | NvimTreeFocus<CR>", { desc = "Focus Current File in Tree" })
