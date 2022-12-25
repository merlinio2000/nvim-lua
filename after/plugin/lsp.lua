local lsp = require("lsp-zero")

vim.lsp.set_log_level('debug')

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
    'rust_analyzer',
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        -- error = 'E',
        -- warn = 'W',
        -- hint = 'H',
        -- info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- if client.name == 'eslint' then
    --     vim.cmd.LspStop('eslint')
    --     return
    -- end

    opts['desc'] = 'Format Buffer'
    vim.keymap.set({ "n", 'v' }, "==", vim.lsp.buf.format)
    opts['desc'] = 'Goto Definition'
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    opts['desc'] = 'Goto Next Diagnostic'
    vim.keymap.set("n", "gnd", vim.diagnostic.goto_next, opts)
    opts['desc'] = 'Goto Previous Diagnostic'
    vim.keymap.set("n", "gnp", vim.diagnostic.goto_prev, opts)
    -- opts['desc'] = 'Hover info'
    -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    opts['desc'] = 'View Workspace Symbol'
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    opts['desc'] = 'View Diagnostics'
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    opts['desc'] = 'View Code Action'
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    opts['desc'] = 'View References'
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    opts['desc'] = 'View Reference Rename'
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    opts['desc'] = 'Signature Help'
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

    -- vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, vim.lsp.buf.document_highlight)
    -- vim.api.nvim_create_autocmd("CursorMoved" , vim.lsp.buf.clear_references)
end)

local lspconfig = require('lspconfig')
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- lspconfig.emmet_ls.setup({
--     -- on_attach = on_attach,
--     capabilities = capabilities,
--     filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
--     init_options = {
--       html = {
--         options = {
--           -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
--           ["bem.enabled"] = true,
--         },
--       },
--       scss = {
--         options = {
--           -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
--           ["bem.enabled"] = true,
--         },
--       },
--     }
-- })
--
--

lsp.setup()



vim.diagnostic.config({
    virtual_text = true,
--     signs = true,
--     update_in_insert = false,
--     underline = true,
--     severity_sort = true,
--     float = true,
})
