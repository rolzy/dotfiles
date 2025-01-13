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

vim.api.nvim_create_user_command("OpenFileExplorer", function()
    -- Get the current file's absolute path in WSL
    local path = vim.api.nvim_buf_get_name(0)

    -- If the path is empty (like in Neo-tree), handle it properly
    if path == "" then
        print("No file selected.")
        return
    end

    if utils.is_wsl() then
        -- Convert the Linux path to a Windows UNC path
        -- For example, convert /mnt/c/... to \\wsl.localhost\Ubuntu\...
        local unc_path = path:gsub("^/mnt/c/", "\\\\wsl.localhost\\Ubuntu\\")
        unc_path = unc_path:gsub("/", "\\")

        -- Debug: print the UNC path before opening it
        print("Opening file in Explorer: " .. unc_path)

        -- Open the file in Windows Explorer
        os.execute('explorer.exe /select,"' .. unc_path .. '"')
    else
        -- Debug: print the path before opening it
        print("Opening file in Explorer: " .. path)

        -- Open the file in the Linux file explorer in the background
        os.execute('nohup dolphin --select ' .. path .. ' > /dev/null 2>&1 &')
    end
end, {})
vim.keymap.set("n", "<leader>e", "<cmd>OpenFileExplorer<CR>", { desc = "Open in File Explorer" })
