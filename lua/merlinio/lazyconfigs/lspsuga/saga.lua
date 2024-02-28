local keymap = vim.keymap.set
local saga = require("lspsaga")

saga.setup({
	-- "single" | "double" | "rounded" | "bold" | "plus"
	border = "single",
	scroll_preview = { scroll_up = "<C-p>", scroll_down = "<C-n>" },
	hover = {
		-- open a link in hover window with this key
		open_link = "gx",
		-- open_cmd = '!firefox' could be used to override
	},
	diagnostic = {
		show_code_action = true,
		jump_num_shortcut = true,
		extend_relatedInformation = true,
		keys = {
			quit = { "q", "<ESC>" },
			quit_in_show = { "q", "<ESC>" },
			exec = "<CR>",
		},
	},
	finder = {
		finder_action_keys = {
			toggle_or_open = { "o", "<CR>" },
			vsplit = "s",
			split = "h",
			tabe = "t",
			close = { "q", "<ESC>" },
			quit = { "q", "<ESC>" },
		},
	},
	code_action = {
		num_shortcut = true,
		show_server_name = true,
		keys = {
			quit = { "q", "<ESC>" },
			exec = "<CR>",
		},
	},
	definition = {
		keys = {
			edit = "<C-c>o",
			vsplit = "<C-c>v",
			split = "<C-c>i",
			tabe = "<C-c>t",
			quit = { "q", "<ESC>" },
		},
	},
	rename = {
		in_select = true,
		keys = {
			quit = { "q", "<ESC>" },
		},
	},
	symbol_in_winbar = {
		enable = true,
		separator = " ",
		show_file = true,
		folder_level = 4,
	},
	outline = {
		win_position = "right",
		win_width = 30,
		auto_enter = true,
		auto_preview = true,
		auto_refresh = true,
		keys = {
			toggle_or_jump = "o",
			quit = { "q", "<ESC>" },
		},
	},
})

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "<leader>sf", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

-- Code action
keymap(
	{ "n", "v" },
	"<leader>sa",
	"<cmd>Lspsaga code_action<CR>",
	{ silent = true }
)

-- Rename
keymap("n", "<F2>", "<cmd>Lspsaga rename<CR>", { silent = true })

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "<leader>sd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })

-- Outline
keymap("n", "<leader>so", "<cmd>Lspsaga outline<CR>", { silent = true })

-- Hover Doc
keymap("n", "<leader>sk", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- keeps hover window open pinned to the right
keymap(
	"n",
	"<leader>sK",
	"<cmd>Lspsaga hover_doc ++keep<CR>",
	{ silent = true }
)
