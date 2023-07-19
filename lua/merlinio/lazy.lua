require('lazy').setup({
    -- Theme
    {
        'olimorris/onedarkpro.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('merlinio.theme')
        end
    },
    { 'nvim-tree/nvim-web-devicons' },
    -- misc
    { 'nvim-lua/plenary.nvim' }, -- Useful lua functions used by lots of plugins
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    { 'mbbill/undotree', lazy = false },
    -- LSP helper
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = true,
        config = function()
            -- This is where you modify the settings for lsp-zero
            -- Note: autocompletion settings will not take effect
            require('lsp-zero.settings').preset('recommended')
        end
    },
    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' },
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp
            require('lsp-zero.cmp').extend({
                set_sources = 'recommended',
                set_basic_mappings = true,
                set_extra_mappings = false,
                use_luasnip = true,
                set_format = true,
                documentation_window = true,
            })
        end
    },
    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
            {
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp = require('lsp-zero')

            lsp.on_attach(require('merlinio.lazyconfigs.lsp.on_attach'))

            -- (Optional) Configure lua language server for neovim
            require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

            require('merlinio.lazyconfigs.lsp.jsonls')

            -- will be done later on 'manually'
            lsp.skip_server_setup({ 'rust_analyzer' })

            lsp.setup()

            require('merlinio.lazyconfigs.lsp.rust-tools') -- TODO only load based on ft
            require('merlinio.lazyconfigs.lsp.null_ls')
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        event = { 'BufReadPost', 'BufNewFile' },
        config = function()
            require('merlinio.lazyconfigs.treesitter')
        end
    },
    -- { 'nvim-treesitter/playground' },
    {
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            'jose-elias-alvarez/null-ls.nvim',
        },
        config = function()
            require('mason-null-ls').setup({
                ensure_installed = { 'prettierd', 'shellcheck', 'shfmt' }
            })
        end,
    },
    {
        'glepnir/lspsaga.nvim',
        event = 'LspAttach',
        branch = 'main',
        config = function()
            require('merlinio.lazyconfigs.lspsuga.saga')
        end
    },
    {
        'lervag/vimtex',
        ft = { 'tex', 'bib' },
        config = function()
            require('merlinio.lazyconfigs.lsp.vimtex')
        end
    },
    {
        'simrat39/rust-tools.nvim',
        ft = { 'rust', 'toml' }
    },
    {
        'numToStr/Comment.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function()
            require('merlinio.lazyconfigs.lsp.comment')
        end
    },
    {
        'folke/trouble.nvim',
        event = 'LspAttach',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    -- Navigation
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        lazy = false
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    {
        'theprimeagen/harpoon' -- TODO rework config
    },
    -- Motion
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        ---@type Flash.Config
        opts = {},
        keys = require('merlinio.lazyconfigs.flash.keys')
    },
    { 'nvim-lualine/lualine.nvim', lazy = false },
    {
        'akinsho/bufferline.nvim',
        version = 'v3.*', -- TODO upgrade to v4
        dependencies = 'nvim-tree/nvim-web-devicons',
        lazy = false
    },
    -- Git
    { 'tpope/vim-fugitive' }, -- TODO investigate neogit
    -- Filebrowsing
    {
        'nvim-tree/nvim-tree.lua',
        version = '*',
        lazy = false,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    }
})
