return function(client, bufnr)
	-- formatting is handled separately

	local opts = { buffer = bufnr, remap = false }

	opts["desc"] = "Goto Definition"
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

	opts["desc"] = "Goto Next Diagnostic"
	vim.keymap.set("n", "gnd", vim.diagnostic.goto_next, opts)

	opts["desc"] = "Goto Previous Diagnostic"
	vim.keymap.set("n", "gpd", vim.diagnostic.goto_prev, opts)

	opts["desc"] = "Hover info"
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

	opts["desc"] = "View Workspace Symbol"
	vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)

	opts["desc"] = "View Diagnostics"
	vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)

	opts["desc"] = "View Code Action"
	vim.keymap.set("n", "<leader>va", vim.lsp.buf.code_action, opts)

	opts["desc"] = "View References"
	vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)

	opts["desc"] = "View Reference Rename"
	vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)

	opts["desc"] = "Completions"
	vim.keymap.set("i", "<C-.>", vim.lsp.buf.completion, opts)
end
