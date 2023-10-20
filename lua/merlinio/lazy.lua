require("lazy").setup({
	-- Theme
	{
		"olimorris/onedarkpro.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("merlinio.theme")
		end,
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
	{ "L3MON4D3/LuaSnip" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "rafamadriz/friendly-snippets" },
	-- LSP helper
	{
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip" },
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
				formatting = cmp_format,
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					-- scroll up and down the documentation window
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					-- snippets
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
				}),
			})
		end,
	},
	-- LSP
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
	},
	{
		"neovim/nvim-lspconfig",
		cmd = "LspInfo",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			-- This is where all the LSP shenanigans will live
			local lsp = require("lsp-zero")
			lsp.extend_lspconfig()

			lsp.on_attach(require("merlinio.lazyconfigs.lsp.on_attach"))

			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "rust_analyzer" },
				handlers = {
					lsp.default_setup,
					lua_ls = function()
						local lua_opts = lsp.nvim_lua_ls()
						require("lspconfig").lua_ls.setup(lua_opts)
					end,
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
		dependencies = { "nvim-lua/plenary.nvim" },
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
	{ "nvim-lualine/lualine.nvim", lazy = false },
	{
		"akinsho/bufferline.nvim",
		version = "v3.*", -- TODO upgrade to v4
		dependencies = "nvim-tree/nvim-web-devicons",
		lazy = false,
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
