require("neo-tree").setup()
vim.keymap.set('n', '<leader>f', '<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<CR>', {})
