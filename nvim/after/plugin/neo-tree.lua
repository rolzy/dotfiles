require("neo-tree").setup({
  -- Open neo-tree in full screen when opening a directory
  -- https://www.reddit.com/r/neovim/comments/195mfz2/open_only_neotree_when_opening_a_directory/
  init = function()
    vim.api.nvim_create_autocmd('BufEnter', {
      -- make a group to be able to delete it later
      group = vim.api.nvim_create_augroup('NeoTreeInit', {clear = true}),
      callback = function()
        local f = vim.fn.expand('%:p')
        if vim.fn.isdirectory(f) ~= 0 then
          vim.cmd('Neotree current dir=' .. f)
          -- neo-tree is loaded now, delete the init autocmd
          vim.api.nvim_clear_autocmds{group = 'NeoTreeInit'}
        end
      end
    })
    -- keymaps
  end,
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'open_current'
    }
  }
})
