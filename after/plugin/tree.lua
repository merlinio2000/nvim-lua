require('nvim-tree').setup({
    view = {
        adaptive_size = true,
    }
})

vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>', { desc = 'Toggle File Tree' })
vim.keymap.set('n', '<leader>tc', ':NvimTreeFindFile | NvimTreeFocus<CR>', { desc = 'Focus Current File in Tree' })
