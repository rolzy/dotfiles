-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

-- Disable netrw
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1

return require('lazy').setup({
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { { 'nvim-lua/plenary.nvim' } }
  },

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate'
  },

  { "catppuccin/nvim", name = "catppuccin" },
  -- Colorscheme for 2024 - Kanagawa
  -- {
  --   'rebelot/kanagawa.nvim',
  --   as = 'kanagawa',
  --   config = function()
  --     vim.cmd('autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE')
  --     vim.cmd('colorscheme kanagawa')
  --   end
  -- },
  --
  -- {
  --   "0xstepit/flow.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },

  -- File tree for 2025 - neotree
  {
    "nvim-neo-tree/neo-tree.nvim",
    -- Open neo-tree in full screen when opening a directory
    -- https://www.reddit.com/r/neovim/comments/195mfz2/open_only_neotree_when_opening_a_directory/
    cmd = 'Neotree',
    init = function()
      vim.api.nvim_create_autocmd('BufEnter', {
        -- make a group to be able to delete it later
        group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
        callback = function()
          local f = vim.fn.expand('%:p')
          if vim.fn.isdirectory(f) ~= 0 then
            vim.cmd('Neotree current dir=' .. f)
            -- neo-tree is loaded now, delete the init autocmd
            vim.api.nvim_clear_autocmds { group = 'NeoTreeInit' }
          end
        end
      })
    end,
    opts = {
      filesystem = {
        hijack_netrw_behavior = 'open_current',
        filtered_items = {
          always_show_by_pattern = {
            ".env*",
            ".github*",
            ".gitignore"
          }
        }
      },
      -- Open neotree with relative line numbers
      -- https://stackoverflow.com/questions/77927924/add-relative-line-numbers-in-neo-tree-using-lazy-in-neovim
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(arg)
            vim.cmd([[
                setlocal relativenumber
              ]])
          end,
        },
      },
    },
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
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
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },

  -- LSP manager
  {
    'williamboman/mason.nvim',
    lazy = false,
    opts = {},
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = 'yes'
    end,
    config = function()
      local lsp_defaults = require('lspconfig').util.default_config

      -- Add cmp_nvim_lsp capabilities settings to lspconfig
      -- This should be executed before you configure any language server
      lsp_defaults.capabilities = vim.tbl_deep_extend(
        'force',
        lsp_defaults.capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf }

          local function HoverFixed()
            vim.api.nvim_command('set eventignore=CursorHold')
            vim.lsp.buf.hover()
            vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
          end

          vim.keymap.set("n", "K", HoverFixed, opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', 'gR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        end,
      })

      require('mason-lspconfig').setup({
        ensure_installed = {},
        automatic_installation = false,
        handlers = {
          -- this first function is the "default handler"
          -- it applies to every language server without a "custom handler"
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })
    end
  },

  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp"
  },

  'windwp/nvim-autopairs',
  'ray-x/lsp_signature.nvim',
  'b0o/schemastore.nvim',

  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
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
    version = "*", -- recommended, use latest release instead of latest commit
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
  {
    "stevearc/conform.nvim"
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    }
  },
  "mfussenegger/nvim-dap-python",

  -- Virtualenv selector
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
      { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    lazy = false,
    branch = "regexp", -- This is the regexp branch, use this for the new version
    config = function()
      require("venv-selector").setup()
    end,
  },

  {
    'numToStr/Comment.nvim',
    config = function()
      -- To avoid waiting for g@
      vim.keymap.del('n', 'gcc')

      -- Unify shortcut for normal and visual modes
      vim.keymap.set('n', '<C-_>', function()
        require('Comment.api').toggle.linewise.current()
      end)

      -- Preserve visual selection after toggling comment/uncomment
      vim.keymap.set('x', '<C-_>', function()
        local api = require 'Comment.api'
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.api.nvim_feedkeys(esc, 'nx', false)
        api.locked 'toggle.linewise' (vim.fn.visualmode())
        vim.cmd 'normal! gv'
      end, { desc = 'Comment toggle linewise (visual) and preserve the visual selection' })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      -- Show python version and virtualenv in status line
      local activated_venv = function()
        local venv_name = require("venv-selector").venv()
        return venv_name:match("([^/]+)$")
      end

      local cached_python_version = nil

      local function get_python_version()
        if cached_python_version then
          return cached_python_version
        end
        local handle = io.popen("python -V 2>&1", "r")
        if handle then
          local python_version = handle:read("*a")
          handle:close()
          cached_python_version = python_version:match("%d+%.%d+%.%d+") or ""
        else
          cached_python_version = ""
        end
        return cached_python_version
      end

      local function lualine_python()
        local parts = {}
        local venv = activated_venv()
        local python_version = get_python_version()
        if venv ~= "" then
          table.insert(parts, venv)
        end
        if python_version ~= "" then
          table.insert(parts, python_version)
        end
        return table.concat(parts, " [") .. (#parts > 1 and "]" or "")
      end
      local function isRecording()
        local reg = vim.fn.reg_recording()
        if reg == "" then
          -- not recording
          return ""
        end
        return "recording to " .. reg
      end
      require("lualine").setup({
        sections = {
          lualine_x = {
            "fileformat",
            "filetype",
            { isRecording, icon = "" }
          },
          lualine_y = {
            { lualine_python },
          },
        },
      })
    end,
  }
})
