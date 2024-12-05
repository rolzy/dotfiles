-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

return require('lazy').setup({
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },

  -- Colorscheme for 2024 - Kanagawa
  {
    'rebelot/kanagawa.nvim',
    as = 'kanagawa',
    config = function()
        vim.cmd('autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE')
        vim.cmd('colorscheme kanagawa')
    end
  },

  -- File tree for 2025 - neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},
      {'windwp/nvim-autopairs'},
      {'ray-x/lsp_signature.nvim'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      -- {'rafamadriz/friendly-snippets'},
      -- {'saadparwaiz1/cmp_luasnip'}
    }
  },

  'b0o/schemastore.nvim',

  {
    "yetone/avante.nvim",
    build = 'make',
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim"
    }
  },

  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-sleuth',

  'zbirenbaum/copilot.lua',
  'zbirenbaum/copilot-cmp',

  -- Obsidian
  {
    'epwalsh/obsidian.nvim',
    version = "*",  -- recommended, use latest release instead of latest commit
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    }
  },

  -- Bullets
  'bullets-vim/bullets.vim',

  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },

  -- Formatting
  "stevearc/conform.nvim"
})
