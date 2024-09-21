require("avante").setup({
  -- provider = "openai",
  -- openai = {
  --   endpoint = "https://api.openai.com/v1",
  --   model = "gpt-4",
  --   timeout = 30000, -- Timeout in milliseconds
  --   temperature = 0,
  --   max_tokens = 4096,
  --   ["local"] = false,
  -- },
  provider = "azure",
  azure = {
    endpoint = "https://oairtdsdevsusdnamlopsptu01.openai.azure.com/",
    deployment = "gpt-4o",
    model = "gpt-4o",
    api_version = "2024-06-01",
    timeout = 30000, -- Timeout in milliseconds
    temperature = 0,
    max_tokens = 4096,
    ["local"] = false,
  },
  mappings = {
    ask = "<leader>c",
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
    wrap = true, -- similar to vim.o.wrap
    width = 30, -- default % based on available width
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
})

