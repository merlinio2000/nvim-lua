---@module 'lazy'
---@type LazySpec
return {
	---@type LazySpec
	{

		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		---@module 'lazydev'
		---@type lazydev.Config
		opts = {
			library = {
				-- auto-load types and stuff without require(...) from lazy.nvim
				"lazy.nvim",
			},
		},
	},
	---@type LazySpec
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",

			"saghen/blink.cmp",
		},
		config = function()
			local servers = {
				asm_lsp = {},
				basedpyright = {},
				bashls = {},
				clangd = {},
				dockerls = {
					settings = {
						docker = {
							languageserver = {
								formatter = {
									ignoreMultilineInstructions = true,
								},
							},
						},
					},
				},
				docker_compose_language_service = {},
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
				jdtls = {},
				jsonls = {
					settings = {
						json = {
							schemas = require("schemastore").json.schemas(),
							validate = { enable = true },
						},
					},
				},
				lua_ls = {},
				-- managed through rustacean.nvim
				-- rust_analyzer = {},
				-- probably want to disable formatting for this lang server
				vtsls = {},
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
			vim.lsp.inlay_hint.enable()

			vim.diagnostic.config({
				virtual_lines = true,
			})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"bashls",
					"jsonls",
					"yamlls",
				},
			})

			for name, config in pairs(servers) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities(
					config.capabilities
				)
				vim.lsp.config(name, config)
				vim.lsp.enable(name)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function()
					-- TODO: look at this
					vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
					local key_opts = { buffer = 0 }

					key_opts["desc"] = "Goto Definition"
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, key_opts)
					key_opts["desc"] = "Goto Declaration"
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, key_opts)
					key_opts["desc"] = "Goto Type"
					vim.keymap.set(
						"n",
						"gT",
						vim.lsp.buf.type_definition,
						key_opts
					)

					key_opts["desc"] = "Workspace Symbols"
					vim.keymap.set(
						"n",
						"<leader>cw",
						vim.lsp.buf.workspace_symbol,
						key_opts
					)
					key_opts["desc"] = "Diagnostics (float)"
					vim.keymap.set(
						"n",
						"<leader>cd",
						vim.diagnostic.open_float,
						key_opts
					)
				end,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^9",
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
