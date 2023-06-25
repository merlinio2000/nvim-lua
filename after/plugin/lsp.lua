-- todo hack remove once fedora upgrades neovim
local ok, wf = pcall(require, "vim.lsp._watchfiles")
if ok then
 -- disable lsp watcher. Too slow on linux
 wf._watchfunc = function()
   return function() end
 end
end


local lsp = require("lsp-zero")

-- vim.lsp.set_log_level('debug')

require("mason-null-ls").setup({
    ensure_installed = { "prettierd", "shellcheck", "shfmt" }
})


lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'lua_ls',
    'rust_analyzer',
})

-- configure lua language server for neovim
-- see :help lsp-zero.nvim_workspace()
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Down>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

-- -- disable completion with tab
-- -- this helps with copilot setup
-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = true,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- if client.name == 'eslint' then
    --     vim.cmd.LspStop('eslint')
    --     return
    -- end
    if client.name == "eslint" or client.name == "volar" or client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentFormattingRangeProvider = false
    end

    opts['desc'] = 'Format Buffer'
    vim.keymap.set({ "n", 'v' }, "==", vim.lsp.buf.format, opts)
    opts['desc'] = 'Goto Definition'
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    opts['desc'] = 'Goto Next Diagnostic'
    vim.keymap.set("n", "gnd", vim.diagnostic.goto_next, opts)
    opts['desc'] = 'Goto Previous Diagnostic'
    vim.keymap.set("n", "gnp", vim.diagnostic.goto_prev, opts)
    opts['desc'] = 'Hover info'
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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
    opts['desc'] = 'Completions'
    vim.keymap.set("i", "<C-.>", vim.lsp.buf.completion, opts)

    -- vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, vim.lsp.buf.document_highlight)
    -- vim.api.nvim_create_autocmd("CursorMoved" , vim.lsp.buf.clear_references)
end)


lsp.configure('jsonls', {
    settings = {
        json = {
            schemas = {
                {
                    fileMatch = { 'package.json' },
                    url = 'https://json.schemastore.org/package.json',
                },
                {
                    fileMatch = { 'tsconfig.json', 'tsconfig.*.json' },
                    url = 'http://json.schemastore.org/tsconfig',
                },
            },
        },
    },
})

lsp.setup()

local rust_lsp = lsp.build_options('rust_analyzer', {
    single_file_support = false,
})

require('rust-tools').setup({ server = rust_lsp })

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup({
    on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)
        ---
        -- you can add other stuff here....
        ---
    end,
    sources = {
        null_ls.builtins.formatting.prettierd,
        -- null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.shellcheck,
        null_ls.builtins.code_actions.shellcheck,
        null_ls.builtins.formatting.shfmt,
    }
})


vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = true,
})
