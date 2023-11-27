local wk = require("which-key")

wk.setup()

wk.register({
	["<leader>"] = {
		f = { name = "+find", g = "+git" },
		g = { name = "+git" },
		h = { name = "+harpoon" },
		s = { name = "+suga [LSP]" },
		t = { name = "+file tree" },
		v = {
			name = "+view",
			w = { name = "+workspace" },
			r = { name = "+reference" },
		},
		x = { name = "+trouble" },
	},
	c = { name = "+comment [LSP]" },
	g = { name = "+goto" },
})
