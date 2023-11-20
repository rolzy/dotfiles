vim.filetype.add {
  pattern = {
    ['.*'] = {
      priority = math.huge,
      function(path, bufnr)
        local line1 = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
        if string.find(line1, "AWSTemplateFormatVersion") then
          vim.api.nvim_command("echom 'Loading CloudFormation LSP...'")
        end
        if string.find(line1, "AWSTemplateFormatVersion") then
          return 'yaml.cloudformation'
        end
      end,
    },
  },
}
