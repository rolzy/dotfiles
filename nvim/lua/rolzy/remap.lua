local utils = require("rolzy.utils")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

if utils.is_wsl() then
    vim.keymap.set("v", "<C-c>",
        "y:tabnew ~/.vimbuffer<CR>VGp:x<CR> | :!cat ~/.vimbuffer | /mnt/c/Windows/System32/clip.exe <CR><CR>")
else
    vim.keymap.set("v", "<C-c>",
        "y:tabnew ~/.vimbuffer<CR>VGp:x<CR> | :!cat ~/.vimbuffer | wl-copy <CR><CR>")
end

-- Remap tab and S-tab to indent in insert mode
vim.keymap.set("i", "<Tab>", "<C-t>")
vim.keymap.set("i", "<S-Tab>", "<C-d>")
