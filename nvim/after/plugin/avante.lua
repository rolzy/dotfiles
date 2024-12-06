local utils = require("rolzy.utils")

local provider_config

if utils.is_wsl() then
  vim.notify("Using Azure provider for WSL", vim.log.levels.INFO)
  provider_config = {
    provider = "azure",
    azure = {
      endpoint = "https://oairtdsdevsusdnamlopsptu02.openai.azure.com/",
      deployment = "gpt-4o",
      -- model = "gpt-4o",
      api_version = "2024-06-01",
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 4096,
    },
  }
else
  vim.notify("Using Claude provider for non-WSL", vim.log.levels.INFO)
  provider_config = {
    provider = "claude",
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20240620",
      temperature = 0,
      max_tokens = 4096,
    },
  }
end

require("avante").setup(vim.tbl_extend("force", provider_config, {
  mappings = {
    edit = "<leader>ae",
    refresh = "<leader>ar",
    diff = {
      ours = "co",
      theirs = "ct",
      both = "cb",
      next = "]x",
      prev = "[x",
    },
    jump = {
      next = "]]",
      prev = "[[",
    },
    submit = {
      normal = "<CR>",
      insert = "<C-s>",
    },
    toggle = {
      debug = "<leader>ad",
      hint = "<leader>ah",
    },
  },
  hints = { enabled = true },
  windows = {
    wrap = true,        -- similar to vim.o.wrap
    width = 30,         -- default % based on available width
    sidebar_header = {
      align = "center", -- left, center, right for title
      rounded = true,
    },
  },
  highlights = {
    diff = {
      current = "DiffText",
      incoming = "DiffAdd",
    },
  },
  diff = {
    debug = false,
    autojump = true,
    list_opener = "copen",
  },
}))

vim.keymap.set("n", "<leader>c", "<cmd>AvanteChat<CR>", { desc = "Chat with Avante" })
