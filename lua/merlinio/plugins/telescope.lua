---@module "lazy"
---@type LazyConfig
return {
	"nvim-telescope/telescope.nvim",
	version = "^0.2.1",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			version = "^1",
		},
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local tel = require("telescope")
		local builtin = require("telescope.builtin")
		local lga_actions = require("telescope-live-grep-args.actions")
		local live_grep_args_shortcuts =
			require("telescope-live-grep-args.shortcuts")
		local open_with_trouble = require("trouble.sources.telescope").open
		tel.setup({
			defaults = require("telescope.themes").get_ivy({
				wrap_results = true,
				mappings = {
					i = {
						["<C-x>"] = open_with_trouble,
						["<C-f>"] = "to_fuzzy_refine",
					},
					n = { ["<C-x>"] = open_with_trouble },
				},
				preview = { filesize_limit = 5 },
			}),
			extensions = {
				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
					mappings = {
						i = {
							["<C-i>"] = lga_actions.quote_prompt({
								postfix = " -u",
							}),
						},
					},
					-- ... also accepts theme settings, for example:
					-- theme = "dropdown", -- use dropdown theme
					-- layout_config = { mirror=true }, -- mirror preview pane
				},
				fzf = {},
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
			},
		})

		tel.load_extension("live_grep_args")
		tel.load_extension("fzf")
		tel.load_extension("ui-select")
		local keymap = vim.keymap.set
		keymap("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		keymap(
			"n",
			"<leader>ft",
			tel.extensions.live_grep_args.live_grep_args,
			{ desc = "Find Text" }
		)
		keymap(
			"n",
			"<leader>fc",
			live_grep_args_shortcuts.grep_word_under_cursor,
			{ desc = "Find word under Cursor" }
		)
		keymap(
			"v",
			"<leader>fv",
			live_grep_args_shortcuts.grep_visual_selection,
			{ desc = "Find current Visual selection" }
		)
		keymap("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		keymap(
			"n",
			"<leader>fo",
			builtin.oldfiles,
			{ desc = "Find Old Files (previously used)" }
		)
		keymap(
			"n",
			"<leader>fgf",
			builtin.git_files,
			{ desc = "Find Git Files" }
		)
		keymap(
			"n",
			"<leader>fgb",
			builtin.git_branches,
			{ desc = "Find Git Branches" }
		)
		keymap(
			"n",
			"<leader>fgc",
			builtin.git_commits,
			{ desc = "Find Git Commits" }
		)
		keymap(
			"n",
			"<leader>fgl",
			builtin.git_bcommits,
			{ desc = "Find Git Commits for this Buffer" }
		)
		keymap(
			"n",
			"<leader>fgs",
			builtin.git_status,
			{ desc = "Find Git Status (local changes)" }
		)
		keymap(
			"n",
			"<leader>fr",
			builtin.resume,
			{ desc = "Find Resume last search" }
		)
		keymap(
			"n",
			"<leader>fp",
			builtin.pickers,
			{ desc = "Find Resume previous pickers" }
		)
		keymap("n", "<leader>fx", builtin.builtin, { desc = "Find Pickers" })
	end,
}
