return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				progress = {
					enabled = false, -- Disable LSP progress
				},
			},
		},
		-- version = "4.4.7",
	},
	{
		"rcarriga/nvim-notify",
	}
}
