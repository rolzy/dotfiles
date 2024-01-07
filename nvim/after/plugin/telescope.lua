require("telescope").setup { 
    pickers = {
        live_grep = {
            file_ignore_patterns = { 'node_modules', '.git/', 'env/' },
            additional_args = function(_)
                return { "--hidden" }
            end
        },
        find_files = {
            file_ignore_patterns = { 'node_modules', '.git/', 'env/' },
            hidden = true
        },
    }
}

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {noremap=true})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
