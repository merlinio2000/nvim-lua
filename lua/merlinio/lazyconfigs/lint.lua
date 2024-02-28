return function()
	require("lint").linters_by_ft = {
		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		javascriptreact = { "eslint_d" },
		typescriptreact = { "eslint_d" },
		shell = { "shellcheck" },
		python = { "ruff" },
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
end
