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
	highlight = { enable = true },
	indent = { enable = true },
})
