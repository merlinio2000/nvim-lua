return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"folke/neodev.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",

			-- Schema information
			"b0o/SchemaStore.nvim",
		},
		config = function()
			vim.lsp.inlay_hint.enable()
			require("neodev").setup({
				-- library = {
				--   plugins = { "nvim-dap-ui" },
				--   types = true,
				-- },
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
					"rust_analyzer",
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
				lua_ls = true,
				-- managed through rustacean.nvim
				-- rust_analyzer = true,
				-- probably want to disable formatting for this lang server
				tsserver = true,
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
				if config == true then
					config = {}
				end
				config = vim.tbl_deep_extend("force", {
					capabilities = capabilities,
				}, config)

				lspconfig[name].setup(config)
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
					opts["desc"] = "Goto References"
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

					opts["desc"] = "Hover info"
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

					opts["desc"] = "Signature Help"
					vim.keymap.set(
						"i",
						"<C-h>",
						vim.lsp.buf.signature_help,
						opts
					)

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
					opts["desc"] = "Code Actions"
					vim.keymap.set(
						"n",
						"<leader>ca",
						vim.lsp.buf.code_action,
						opts
					)
					opts["desc"] = "Rename Reference"
					vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
				end,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		lazy = false, -- This plugin is already lazy
	},
	{
		"lervag/vimtex",
		ft = { "tex", "bib" },
		config = function()
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
