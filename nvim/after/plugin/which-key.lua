require("which-key").setup {
  ---@type false | "classic" | "modern" | "helix"
  preset = "classic",

  -- Delay before showing the popup. Can be a number or a function that returns a number.
  ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
  delay = 100,

  plugins = {
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true
    },
    registers = true
  }
}

local wk = require("which-key")
wk.add({
  { "<leader>a", group = "Avante", icon = { icon = "" } },
  { "<leader>d", group = "Debugger", icon = { icon = "" } },
  { "<leader>h", group = "Harpoon", icon = { icon = "󱡀" } },
  { "<leader>o", group = "Obsidian", icon = { icon = "󱞁" } },

  { "<leader>f", "<cmd>Neotree action=focus source=filesystem position=left toggle=true reveal=true<CR>:set relativenumber<CR>", desc = "Toggle Neo-Tree", mode = "n" },

  { "<leader>x", "<cmd>!chmod +x %<CR>", desc = "chmod +x" },
})
