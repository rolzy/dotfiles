vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.cinkeys:remove('0#')

vim.opt.ignorecase = true
vim.opt.mouse = 'n'

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

-- vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- For obsidian concealment features
-- https://github.com/epwalsh/obsidian.nvim#concealing-characters
vim.opt.conceallevel = 1
