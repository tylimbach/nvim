vim.o.bg = "light"

return {
  -- lush used by zenbones
  { "rktjmp/lush.nvim" },

  { "ellisonleao/gruvbox.nvim" },

  { "rose-pine/neovim" },

  { "zenbones-theme/zenbones.nvim" },

  {
    dir = "../../colors/gruvbones.lua",
    config = function()
      require("colors.gruvbones")
    end,
    lazy = true,
  },
  {
    dir = "../../colors/mybones.lua",
    config = function()
      require("colors.mybones")
    end,
    lazy = true,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "mybones",
    },
  },
}
