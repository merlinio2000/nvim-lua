-- This file can be loaded by calling `lua require('packer')` from your init.vim

-- Only required if you have packer configured as `opt
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    -- TODO: migr to lazy.nvim and use keys from git
    use 'folke/flash.nvim'

    -- theme
    -- use { "ellisonleao/gruvbox.nvim" }
    use "olimorris/onedarkpro.nvim"

    use { 'kyazdani42/nvim-web-devicons' }


    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use "numToStr/Comment.nvim" -- Easily comment stuff

    -- use 'JoosepAlviste/nvim-ts-context-commentstring'

    use 'theprimeagen/harpoon'

    use 'mbbill/undotree'

    use 'tpope/vim-fugitive'

    use {
        'folke/which-key.nvim',
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        lazy = false
    }

    use { 'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' }

    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- prettier format
            { 'jose-elias-alvarez/null-ls.nvim' },
            -- {'MunifTanjim/prettier.nvim'},
        }
    }

    use { "jay-babu/mason-null-ls.nvim" }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    }

    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
    })

    use 'simrat39/rust-tools.nvim'


    -- latex
    use 'lervag/vimtex'
end)
