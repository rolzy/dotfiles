local lsp = require('lsp-zero')

lsp.preset('recommended')
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {'pyright', 'rust_analyzer', 'bashls', 'yamlls', 'lua_ls'},
    handlers = {
        lsp.default_setup,
    }
})

lsp.new_client({
  name = 'cfnls',
  cmd = {'/home/rolzy/.local/bin/cfn-lsp-extra'},
  filetypes = {'yaml.cloudformation'},
  root_dir = function()
    return lsp.dir.find_first({'.git'})
  end
})

lsp.configure('yamlls', {
    on_attach = on_attach,
    capabilities = capabilities,
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

local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format()
local cmp_action = require('lsp-zero').cmp_action()
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    ['<CR>'] = cmp.mapping.confirm({
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	})
})

cmp.setup({
    sources = {
        -- This one provides the data from copilot.
        {name = 'copilot'},

        --- These are the default sources for lsp-zero
        {name = 'path'},
        {name = 'nvim_lsp', keyword_length = 3},
        {name = 'buffer', keyword_length = 3},
        {name = 'luasnip', keyword_length = 2},
    },
    preselect = 'none',
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect'
    },
    mapping = cmp_mappings,
    window = {
      documentation = cmp.config.window.bordered(),
    },
    formatting = cmp_format
})


lsp.on_attach(function(client, bufnr)
	local opts = { 
        buffer = bufnr,
        remap = false
    }
    lsp.default_keymaps(opts)

	vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function () vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "gi", "gi", opts)
	vim.keymap.set("i", "<C-h>", function () vim.lsp.buf.signature_help() end, opts)
end)

vim.opt.signcolumn = 'yes'
vim.o.updatetime = 150
vim.cmd [[autocmd! CursorHold, * lua vim.diagnostic.open_float(nil, {focusable=false})]]

lsp.setup()

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = false,
  float = true,
})
