local default_colors = require("kanagawa.colors").setup().palette

require 'kanagawa'.setup({
  overrides = function(colors)
    return {
      Visual = { bg = default_colors.autumnGreen }
    }
  end
})
vim.cmd("colorscheme kanagawa")
