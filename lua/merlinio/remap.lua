vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "+", "<C-w>>", { desc = "Enlarge Buffer" })
vim.keymap.set("n", "-", "<C-w><", { desc = "Shrink Buffer" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Right Screen" })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Left Screen" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Lower Screen" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Upper Screen" })
vim.keymap.set("n", "H", ":bprev<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "L", ":bnext<CR>", { desc = "Next Buffer" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever ?????
-- vim.keymap.set("x", "<leader>pp", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>pp", [["+p]])

-- next greatest remap ever : asbjornHaland
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
