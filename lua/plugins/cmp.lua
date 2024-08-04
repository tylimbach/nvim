return {
  -- idk if this is doing anything
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        experimental = {
          ghost_text = false,
        },
        sources = cmp.config.sources.insert({
          { name = "cmdline" },
        }),
      }
    end,
  },
}
