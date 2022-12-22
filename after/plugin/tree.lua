require('nvim-tree').setup({})
local api = require('nvim-tree.api')


function focusCurrentBufInTree()
    api.tree.toggle(true, false)
end



vim.keymap.set('n', '<leader>tt', ':NvimTreeToggle<CR>', {desc='Toggle File Tree'})
vim.keymap.set('n', '<leader>tc', focusCurrentBufInTree, {desc='Focus Current File in Tree'})
