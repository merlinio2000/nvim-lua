return function()
	require("nvim-surround").setup({
		keymaps = {
			insert = false,
			insert_line = false,
			normal = "ys",
			normal_cur = false,
			normal_line = false,
			normal_cur_line = false,
			visual = false,
			visual_line = false,
			delete = "ds",
			change = "cs",
			--TODO: remove after my MR is merged:
			-- https://github.com/kylechui/nvim-surround/pull/286
			change_line = "cX",
		},
	})
end
