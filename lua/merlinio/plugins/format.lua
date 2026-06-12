local js_config = { "biome", "prettierd", stop_after_first = true }

---@module 'lazy'
---@type LazySpec
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
	opts = {
		format = {
			timeout_ms = 3000,
			async = false, -- not recommended to change
			quiet = false, -- not recommended to change
		},
		format_on_save = { timeout_ms = 500, lsp_fallback = true },
		formatters_by_ft = {
			rust = { "rustfmt" },
			lua = { "stylua" },
			sh = { "shfmt" },
			javascript = js_config,
			typescript = js_config,
			javascriptreact = js_config,
			typescriptreact = js_config,
			json = js_config,
			jsonc = js_config, -- json with comments like tsconfig
			html = js_config,
			css = js_config,
			python = { "ruff_format" },
			go = { "golangci-lint" },
		},
	},
	-- init = function()
	-- 	-- TODO: what does this do
	-- 	-- If you want the formatexpr, here is the place to set it
	-- 	vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	-- end,
}
