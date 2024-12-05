local lsp = require('lsp-zero')

lsp.preset('recommended')
require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
	'pyright',
	'bashls',
	'yamlls',
	'lua_ls'
    },
    handlers = {
        lsp.default_setup,
    }
})

require("mason-lspconfig").setup_handlers({
	-- Will be called for each installed server that doesn't have
	-- a dedicated handler.
	--
	function(server_name) -- default handler (optional)
		-- https://github.com/neovim/nvim-lspconfig/pull/3232
		if server_name == "tsserver" then
			server_name = "ts_ls"
		end
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("lspconfig")[server_name].setup({

			capabilities = capabilities,
		})
	end,
})

lsp.new_client({
    cmd = { os.getenv("HOME") .. '/.local/bin/cfn-lsp-extra' },
    filetypes = { 'yaml.cloudformation', 'json.cloudformation' },
    root_dir = function(fname)
      return require('lspconfig').util.find_git_ancestor(fname) or vim.fn.getcwd()
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

require('lspconfig').lua_ls.setup {
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
}

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
        {name = 'nvim_lsp', priority = 5000000},
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

function HoverFixed()
    vim.api.nvim_command('set eventignore=CursorHold')
    vim.lsp.buf.hover()
    vim.api.nvim_command('autocmd CursorMoved <buffer> ++once set eventignore=""')
end

lsp.on_attach(function(client, bufnr)
	local opts = { 
        buffer = bufnr,
        remap = false
    }
    lsp.default_keymaps(opts)

	vim.keymap.set("n", "gd", function () vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", HoverFixed, opts)
	vim.keymap.set("n", "gi", "gi", opts)
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
