require("chatgpt").setup({
    yank_register = "",
    keymaps = {
        close = { "<C-c>", "<Esc>" },
        yank_last = "<C-y>",
        scroll_up = "<C-u>",
        scroll_down = "<C-d>",
        new_session = "<C-N>",
        toggle_settings = "<C-o>",
        cycle_windows = "<Tab>",
        submit = "<CR>"
    },
})
vim.keymap.set("n", "<leader>c", vim.cmd.ChatGPT);
vim.keymap.set("v", "<leader>e", "<cmd>ChatGPTRun explain_code<CR>");
