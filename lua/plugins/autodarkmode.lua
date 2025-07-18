return {
  {
	"f-person/auto-dark-mode.nvim",
	enabled = false,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        -- vim.mycolors.set_terminal_colors()
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        -- vim.mycolors.set_terminal_colors()
      end,
	fallback = "dark",
    },
  },
}
