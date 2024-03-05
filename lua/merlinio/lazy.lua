require("lazy").setup({
	-- Theme
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		opts = {
			integrations = {
				lsp_trouble = true,
				which_key = true,
				lsp_saga = true,
				noice = true,
			},
		},
	},
	{ "nvim-tree/nvim-web-devicons" },
	-- misc
	{ "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{ "mbbill/undotree", lazy = false },
	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },
	-- LSP helper
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		branch = "v3.x",
		lazy = true,
		config = nil,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	-- Autocompletion
	-- Dont exactly know why but these dont get recognized
	-- if we only have them as deps in nvim-cmp
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			-- Here is where you configure the autocompletion settings.
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_cmp()

			-- And you can configure cmp even more, if you want to.
			local cmp = require("cmp")

			local cmp_action = lsp_zero.cmp_action()
			local cmp_format = lsp_zero.cmp_format()

			cmp.setup({
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
				}, {
					{ name = "luasnip", keyword_length = 2 },
					{ name = "buffer", keyword_length = 3 },
				}),
				formatting = cmp_format,
				mapping = cmp.mapping.preset.insert({
					-- snippets
					["<Tab>"] = cmp_action.luasnip_jump_forward(),
					["<S-Tab>"] = cmp_action.luasnip_jump_backward(),

					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					-- scroll up and down the documentation window
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
				}),
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
				},
			})
		end,
	},
	-- LSP
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	-- tools for nvim config development
	{ "folke/neodev.nvim" },
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			require("neodev").setup({})
			-- This is where all the LSP shenanigans will live
			local lsp = require("lsp-zero")
			lsp.extend_lspconfig()

			lsp.on_attach(require("merlinio.lazyconfigs.lsp.on_attach"))

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "stylua", "rust_analyzer" },
				handlers = {
					lsp.default_setup,
					-- will be done later on 'manually'
					jsonls = lsp.noop,
					rust_analyzer = lsp.noop,
				},
			})
			-- manually setup servers
			require("merlinio.lazyconfigs.lsp.jsonls")
			require("merlinio.lazyconfigs.lsp.rust-tools") -- TODO only load based on ft
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("merlinio.lazyconfigs.treesitter")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		url = "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
		config = function()
			local rainbow_delimiters = require("rainbow-delimiters")

			vim.g.rainbow_delimiters = {
				strategy = {
					[""] = rainbow_delimiters.strategy["global"],
					commonlisp = rainbow_delimiters.strategy["local"],
				},
				query = {
					[""] = "rainbow-delimiters",
					lua = "rainbow-blocks",
				},
				highlight = {
					"RainbowDelimiterBlue",
					"RainbowDelimiterRed",
					"RainbowDelimiterCyan",
					"RainbowDelimiterGreen",
					"RainbowDelimiterViolet",
					"RainbowDelimiterYellow",
					"RainbowDelimiterOrange",
				},
				blacklist = { "c", "cpp" },
			}
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		branch = "main",
		config = function()
			require("merlinio.lazyconfigs.lspsuga.saga")
		end,
	},
	-- linting
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = require("merlinio.lazyconfigs.lint"),
	},
	-- formatting
	require("merlinio.lazyconfigs.format"),
	{
		"lervag/vimtex",
		ft = { "tex", "bib" },
		config = function()
			require("merlinio.lazyconfigs.lsp.vimtex")
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = { "rust", "toml" },
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("merlinio.lazyconfigs.lsp.comment")
		end,
	},
	{
		"folke/trouble.nvim",
		event = "LspAttach",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- Navigation
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
		lazy = false,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		"theprimeagen/harpoon", -- TODO rework config
	},
	-- Motion
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
		keys = require("merlinio.lazyconfigs.flash.keys"),
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = require("merlinio.lazyconfigs.surround.setup"),
	},
	-- UI
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		opts = {
			options = {
				theme = "catppuccin",
				component_separators = "|",
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {
						"NvimTree",
					},
				},
			},
		},
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		lazy = false,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = false, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		},
		keys = {
			{
				"<S-Enter>",
				function()
					require("noice").redirect(vim.fn.getcmdline())
				end,
				mode = "c",
				desc = "Redirect Cmdline",
			},
			{
				"<leader>nh",
				function()
					require("noice").cmd("history")
				end,
				desc = "Noice History",
			},
			{
				"<leader>nd",
				function()
					require("noice").cmd("dismiss")
				end,
				desc = "Dismiss All",
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
	},
	-- Git
	{ "tpope/vim-fugitive" }, -- TODO investigate neogit
	-- Filebrowsing
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
})
