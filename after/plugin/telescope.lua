local tel = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
tel.setup({
	extensions = {
		live_grep_args = {
			auto_quoting = true, -- enable/disable auto-quoting
			-- define mappings, e.g.
			mappings = { -- extend mappings
				i = {
					["<C-q>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				},
			},
			-- ... also accepts theme settings, for example:
			-- theme = "dropdown", -- use dropdown theme
			-- theme = { }, -- use own theme spec
			-- layout_config = { mirror=true }, -- mirror preview pane
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})

tel.load_extension("live_grep_args")

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
tel.load_extension("fzf")
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set(
	"n",
	"<leader>ft",
	":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ desc = "Find Text" }
)
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
vim.keymap.set("n", "<leader>fc", live_grep_args_shortcuts.grep_word_under_cursor, { desc = "Find word under Cursor" })
vim.keymap.set(
	"v",
	"<leader>fv",
	live_grep_args_shortcuts.grep_visual_selection,
	{ desc = "Find current Visual selection" }
)

vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })

vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find Old Files (previously used)" })

vim.keymap.set("n", "<leader>fgf", builtin.git_files, { desc = "Find Git Files" })
vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Find Git Branches" })
vim.keymap.set("n", "<leader>fgc", builtin.git_commits, { desc = "Find Git Commits" })
vim.keymap.set("n", "<leader>fgl", builtin.git_bcommits, { desc = "Find Git Commits for this Buffer" })
vim.keymap.set("n", "<leader>fgs", builtin.git_status, { desc = "Find Git Status (local changes)" })

vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Find Resume last search" })
vim.keymap.set("n", "<leader>fp", builtin.pickers, { desc = "Find Resume previous pickers" })

vim.keymap.set("n", "<leader>fx", builtin.builtin, { desc = "Find Pickers" })
