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
    {
        'mbbill/undotree'
    },
    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    -- { 'nvim-treesitter/playground' },
    {

        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {
            'jay-babu/mason-null-ls.nvim'
        }
    },
    {
        'glepnir/lspsaga.nvim',
        event = 'LspAttach',
        branch = 'main',
    },
    {
        'lervag/vimtex',
        ft = { 'tex', 'bib' }
    },
    {
        'simrat39/rust-tools.nvim',
        ft = { 'rust', 'toml' }
    },
    {
        'numToStr/Comment.nvim',
        event = 'InsertEnter'
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
        dependencies = { 'nvim-lua/plenary.nvim' }
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
        -- stylua: ignore
        keys = require('merlinio.lazyconfigs.flash.keys')
    },
    {
        'nvim-lualine/lualine.nvim'
    },
    {
        'akinsho/bufferline.nvim',
        version = 'v3.*', -- TODO upgrade to v4
        dependencies = 'nvim-tree/nvim-web-devicons'
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
