require("bufferline").setup({
	options = {
		tab_size = 18,
		diagnostics = "nvim_lsp",
		show_buffer_close_icons = false,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				text_align = "center",
				separator = true,
			},
		},
	},
	highlights = require("catppuccin.groups.integrations.bufferline").get(),
})
