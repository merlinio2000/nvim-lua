vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)


vim.keymap.set('n', '+', '<C-w>>', {desc='Enlarge Buffer'})
vim.keymap.set('n', '-', '<C-w><', {desc='Shrink Buffer'})
vim.keymap.set('n', '>', '<C-w>l', {desc='Right Screen'})
vim.keymap.set('n', '<', '<C-w>h', {desc='Left Screen'})
vim.keymap.set('n', '<C-l>', '<C-w>l', {desc='Right Screen'})
vim.keymap.set('n', '<C-h>', '<C-w>h', {desc='Left Screen'})
vim.keymap.set('n', 'H', ':bprev<CR>', {desc='Previous Buffer'})
vim.keymap.set('n', 'L', ':bnext<CR>', {desc='Next Buffer'})

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever ?????
-- vim.keymap.set("x", "<leader>pp", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>pp", [["+p]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>xf", "<cmd>!chmod +x %<CR>", { desc = 'Make File executable' })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>ft', builtin.live_grep, { desc = 'Find Text' })
vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = 'Find Git Files' })
vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = 'Find Resume previous' })


