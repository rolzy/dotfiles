require('conform').setup({
  log_level = vim.log.levels.DEBUG,
  formatters_by_ft = {
    css = { 'prettier' },
    html = { 'prettier' },
    bash = { 'shellcheck', 'shfmt' },
    zsh = { 'shellcheck', 'shfmt' },
    javascript = { 'prettier' },
    json = { 'fixjson' },
    terraform = { 'terraform_fmt' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    python = {
      -- To fix auto-fixable lint errors.
      "ruff_fix",
      -- To run the Ruff formatter.
      "ruff_format",
      -- To organize the imports.
      "ruff_organize_imports",
    },
  },

  formatters = {
    ruff_fix = {
      append_args = { "--ignore", "F401" },
    }
  },

  format_on_save = { lsp_format = "fallback", timeout_ms = 500, }
  --format_on_save = function(bufnr)
  --  --    -- Disable with a global or buffer-local variable
  --  --    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
  --  --      return
  --  --    end
  --  return { lsp_format = "fallback" }
  --end,
})

-- vim.api.nvim_create_user_command("FormatDisable", function(args)
--   if args.bang then
--     -- FormatDisable! will disable formatting just for this buffer
--     vim.b.disable_autoformat = true
--   else
--     vim.g.disable_autoformat = true
--   end
-- end, {
--   desc = "Disable autoformat-on-save",
--   bang = true,
-- })
-- vim.api.nvim_create_user_command("FormatEnable", function()
--   vim.b.disable_autoformat = false
--   vim.g.disable_autoformat = false
-- end, {
--   desc = "Re-enable autoformat-on-save",
-- })
