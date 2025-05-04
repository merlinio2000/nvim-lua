return {
	{

		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- auto-load types and stuff without require(...) from lazy.nvim
				"lazy.nvim",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			vim.lsp.inlay_hint.enable()

			vim.diagnostic.config({
				virtual_lines = true,
			})

			local capabilities = nil
			if pcall(require, "cmp_nvim_lsp") then
				capabilities = require("cmp_nvim_lsp").default_capabilities()
			end

			require("mason").setup()
			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"jsonls",
					"yamlls",
				},
			})

			local servers = {
				bashls = true,
				gopls = {
					settings = {
						gopls = {
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								functionTypeParameters = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				},
				basedpyright = true,
				clangd = true,
				dockerls = true,
				docker_compose_language_service = true,
				lua_ls = true,
				jdtls = true,
				-- managed through rustacean.nvim
				-- rust_analyzer = true,
				-- probably want to disable formatting for this lang server
				ts_ls = true,
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				yamlls = {
					settings = {
						yaml = {
							schemaStore = {
								enable = false,
								url = "",
							},
							schemas = require("schemastore").yaml.schemas(),
						},
					},
				},
			}

			for name, config in pairs(servers) do
				if config then
					if config == true then
						config = {}
					end
					config = vim.tbl_deep_extend("force", {
						capabilities = capabilities,
					}, config)

					vim.lsp.config(name, config)
					vim.lsp.enable(name)
				end
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function()
					-- TODO: look at this
					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					local opts = { buffer = 0 }

					opts["desc"] = "Goto Definition"
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					opts["desc"] = "Goto Declaration"
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					opts["desc"] = "Goto Type"
					vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)

					opts["desc"] = "Workspace Symbols"
					vim.keymap.set(
						"n",
						"<leader>cw",
						vim.lsp.buf.workspace_symbol,
						opts
					)
					opts["desc"] = "Diagnostics (float)"
					vim.keymap.set(
						"n",
						"<leader>cd",
						vim.diagnostic.open_float,
						opts
					)
				end,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5",
		lazy = false, -- This plugin is already lazy
	},
	{
		"lervag/vimtex",
		lazy = false, -- already is a ft plugin
		init = function()
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"glepnir/lspsaga.nvim",
		config = function()
			local keymap = vim.keymap.set
			local saga = require("lspsaga")

			saga.setup({})
			keymap(
				"n",
				"<leader>sf",
				"<cmd>Lspsaga lsp_finder<CR>",
				{ silent = true }
			)
			keymap(
				"n",
				"<leader>sd",
				"<cmd>Lspsaga peek_definition<CR>",
				{ silent = true }
			)
			keymap(
				"n",
				"<leader>si",
				"<cmd>Lspsaga incoming_calls<CR>",
				{ silent = true }
			)
			keymap(
				"n",
				"<leader>si",
				"<cmd>Lspsaga outgoing_calls<CR>",
				{ silent = true }
			)
			-- keeps hover window open pinned to the right
			keymap(
				"n",
				"<leader>sK",
				"<cmd>Lspsaga hover_doc ++keep<CR>",
				{ silent = true }
			)
		end,
	},
}
