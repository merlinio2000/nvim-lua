local lsp = require("lsp-zero")

-- vim.lsp.set_log_level('debug')

require("mason-null-ls").setup({
    ensure_installed = { "prettierd" }
})


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


lsp.setup()


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
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.eslint,
    }
})

local prettier = require("prettier")

prettier.setup({
    bin = 'prettierd', -- or `'prettierd'` (v0.22+)
    filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
    },
    ["null-ls"] = {
        condition = function()
            return prettier.config_exists({
                -- if `false`, skips checking `package.json` for `"prettier"` key
                check_package_json = true,
            })
        end,
        runtime_condition = function(params)
            -- return false to skip running prettier
            return true
        end,
        timeout = 5000,
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
