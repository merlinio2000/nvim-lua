local js_config = { "biomejs", "eslint_d" }

return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.env.ESLINT_D_PPID = vim.fn.getpid()
		require("lint").linters_by_ft = {
			javascript = js_config,
			typescript = js_config,
			javascriptreact = js_config,
			typescriptreact = js_config,
			shell = { "shellcheck" },
			python = { "ruff" },
			go = { "golangcilint" },
		}

		local lint_group = vim.api.nvim_create_augroup("Linting", {
			clear = true,
		})
		vim.api.nvim_create_autocmd(
			{ "BufWritePost", "BufReadPost", "InsertLeave" },
			{
				group = lint_group,
				callback = function()
					require("lint").try_lint()
				end,
			}
		)
	end,
}
