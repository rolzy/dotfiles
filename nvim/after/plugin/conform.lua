require('conform').setup({
  notify_on_error = false,
  formatters_by_ft = {
    css = { 'prettier' },
    html = { 'prettier' },
    javascript = { 'prettier' },
    json = { 'fixjson' },
    terraform = { 'terraform_fmt' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    python = { 'ruff_fix', 'ruff_format' }
  },

  formatters = {
    ruff_fix = {
      args = { "check", "--ignore", "F401" },
    }
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 100, lsp_format = "fallback" }
  end,
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
