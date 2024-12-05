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
