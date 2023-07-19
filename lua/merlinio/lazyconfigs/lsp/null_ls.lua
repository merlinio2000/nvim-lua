local null_ls = require('null-ls')

null_ls.setup({
    on_attach = function(client, bufnr)
        require('merlinio.lazyconfigs.lsp.on_attach')(client, bufnr)
    end,
    sources = {
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.formatting.shfmt,
    }
})
