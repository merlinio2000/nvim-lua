return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{
			"==",
			function()
				require("conform").format({ lsp_fallback = true })
			end,
			mode = { "n", "v" },
			desc = "Format Buffer",
		},
	},
	opts = function()
		---@class ConformOpts
		local opts = {
			format = {
				timeout_ms = 3000,
				async = false, -- not recommended to change
				quiet = false, -- not recommended to change
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
			---@type table<string, conform.FormatterUnit[]>
			formatters_by_ft = {
				rust = { "rustfmt" },
				lua = { "stylua" },
				sh = { "shfmt" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				json = { "prettierd" },
				jsonc = { "prettierd" }, -- json with comments like tsconfig
				html = { "prettierd" },
				css = { "prettierd" },
				python = { "ruff_format" },
			},
		}
		return opts
	end,
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
