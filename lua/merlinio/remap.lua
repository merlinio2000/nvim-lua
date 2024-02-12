vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "+", "<C-w>>", { desc = "Enlarge Buffer" })
vim.keymap.set("n", "-", "<C-w><", { desc = "Shrink Buffer" })
vim.keymap.set("n", "H", "<cmd>bprev<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "Next Buffer" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>pp", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

-- all my homies hate q
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<localleader>m", "q", { desc = "Record Macro" })
vim.keymap.set("n", "q", "<nop>")

vim.keymap.set("n", "<localleader>q", "<cmd>cnext<CR>zz", { desc = "Quick-Fix Next" })
vim.keymap.set("n", "<localleader>Q", "<cmd>cprev<CR>zz", { desc = "Quick-Fix Previous" })
vim.keymap.set("n", "<localleader>l", "<cmd>lnext<CR>zz", { desc = "Locationlist Next" })
vim.keymap.set("n", "<localleader>L", "<cmd>lprev<CR>zz", { desc = "Locationlist Previous" })

vim.keymap.set("n", "<leader>s", [[:%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left><Left>]])
