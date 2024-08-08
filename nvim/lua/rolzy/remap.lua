vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("v", "<C-c>", "y:tabnew ~/.vimbuffer<CR>VGp:x<CR> | :!cat ~/.vimbuffer | /mnt/c/Windows/System32/clip.exe <CR><CR>")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

local function make_new_note_with_title()
    local title = vim.fn.input("Enter New Note Title: ")
    vim.cmd("ObsidianNew " .. title)
end

vim.keymap.set("n", "<leader>oo", ":ObsidianOpen<CR>")
vim.keymap.set("n", "<leader>on", make_new_note_with_title)
vim.keymap.set("n", "<leader>ob", ":ObsidianBacklinks<CR>")
vim.keymap.set("v", "<leader>ol", ":ObsidianLinkNew<CR>")

-- Remap tab and S-tab to indent in insert mode
vim.keymap.set("i", "<Tab>", "<C-t>")
vim.keymap.set("i", "<S-Tab>", "<C-d>")
