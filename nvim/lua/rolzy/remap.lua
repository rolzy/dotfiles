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

local function make_new_note_with_title()
    local title = vim.fn.input("Enter New Note Title: ")
    vim.cmd("ObsidianNew " .. title)
end

local wk = require("which-key")
wk.add({
    { "<leader>o",  group = "Obsidian" },
    { "<leader>oo", "<cmd>ObsidianOpen<CR>",                                                                 desc = "Open Obsidian",     mode = "n" },
    { "<leader>on", "make_new_note_with_title",                                                              desc = "New Obsidian note", mode = "n" },
    { "<leader>ol", "<cmd>ObsidianLinkNew<CR>",                                                              desc = "New Obsidian link", mode = "v" },

    { "<leader>f",  "<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<CR>", desc = "Toggle Neo-Tree",   mode = "n" },

    { "<leader>x",  "<cmd>!chmod +x %<CR>",                                                                  desc = "chmod +x" },
})
