-- Lua
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
          'require'
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    }
  }
})

-- Terraform
vim.lsp.config('terraformls', {})

-- YamlLS
vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
      customTags = {
        "!Cidr",
        "!Cidr sequence",
        "!And",
        "!And sequence",
        "!If",
        "!If sequence",
        "!Not",
        "!Not sequence",
        "!Equals",
        "!Equals sequence",
        "!Or",
        "!Or sequence",
        "!FindInMap",
        "!FindInMap sequence",
        "!Base64",
        "!Join",
        "!Join sequence",
        "!Ref",
        "!Sub",
        "!Sub sequence",
        "!GetAtt",
        "!GetAZs",
        "!ImportValue",
        "!ImportValue sequence",
        "!Select",
        "!Select sequence",
        "!Split",
        "!Split sequence",
      },
    }
  }
})

-- CloudFormation
vim.lsp.config("cfn-lsp-extra", {
  cmd = { os.getenv("HOME") .. '/.local/bin/cfn-lsp-extra' },
  filetypes = { 'yaml.cloudformation', 'json.cloudformation' },
  root_markers = { '.git' },
  settings = {
    documentFormatting = false,
  },
})
vim.lsp.enable("cfn-lsp-extra")
