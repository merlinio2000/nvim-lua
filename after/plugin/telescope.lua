local tel = require("telescope")
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
tel.setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
tel.load_extension("fzf")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>ft", builtin.live_grep, { desc = "Find Text" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files (previously used)" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })

vim.keymap.set("n", "<leader>fgf", builtin.git_files, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Find Git Branches" })
vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "Find Git Commits" })
vim.keymap.set("n", "<leader>fgl", builtin.git_bcommits, { desc = "Find Git Commits for this Buffer" })
vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Find Git Status (local changes)" })

vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume last search" })
vim.keymap.set("n", "<leader>fp", builtin.pickers, { desc = "Find Resume previous pickers" })

vim.keymap.set("n", "<leader>fx", builtin.builtin, { desc = "Find Pickers" })
