require('conform').setup({
  notify_on_error = false,
  formatters_by_ft = {
    css = { 'prettier' },
    html = { 'prettier' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    terraform = { 'tflint' },
    python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' }
  },

  formatters = {
    ruff_fix = {
      args = { "check", "--ignore", "F401" }
    }
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = "fallback",
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
