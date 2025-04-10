vim.mycolors = vim.mycolors or {}

vim.mycolors.set_terminal_colors = function()
	local colors = {
		dark_grey = "#282828",
		red = "#cc241d",
		green = "#98971a",
		yellow = "#d79921",
		blue = "#458588",
		purple = "#b16286",
		aqua = "#689d6a",
		light_grey = "#a89984",
		bright_grey = "#928374",
		bright_red = "#fb4934",
		bright_green = "#b8bb26",
		bright_yellow = "#fabd2f",
		bright_blue = "#83a598",
		bright_purple = "#d3869b",
		bright_aqua = "#8ec07c",
		bright_white = "#ebdbb2",
	}

	-- Set terminal colors using Vimscript commands
	-- vim.cmd(
	-- 	string.format(
	-- 		[[
	-- 			let g:terminal_color_0 = '%s'
	-- 			let g:terminal_color_1 = '%s'
	-- 			let g:terminal_color_2 = '%s'
	-- 			let g:terminal_color_3 = '%s'
	-- 			let g:terminal_color_4 = '%s'
	-- 			let g:terminal_color_5 = '%s'
	-- 			let g:terminal_color_6 = '%s'
	-- 			let g:terminal_color_7 = '%s'
	-- 			let g:terminal_color_8 = '%s'
	-- 			let g:terminal_color_9 = '%s'
	-- 			let g:terminal_color_10 = '%s'
	-- 			let g:terminal_color_11 = '%s'
	-- 			let g:terminal_color_12 = '%s'
	-- 			let g:terminal_color_13 = '%s'
	-- 			let g:terminal_color_14 = '%s'
	-- 			let g:terminal_color_15 = '%s'
	-- 		]],
	-- 		colors.dark_grey,
	-- 		colors.red,
	-- 		colors.green,
	-- 		colors.yellow,
	-- 		colors.blue,
	-- 		colors.purple,
	-- 		colors.aqua,
	-- 		colors.light_grey,
	-- 		colors.bright_grey,
	-- 		colors.bright_red,
	-- 		colors.bright_green,
	-- 		colors.bright_yellow,
	-- 		colors.bright_blue,
	-- 		colors.bright_purple,
	-- 		colors.bright_aqua,
	-- 		colors.bright_white
	-- 	)
	-- )
end

return {
	-- lush used by zenbones
	{ "rktjmp/lush.nvim" },

	{
		"ellisonleao/gruvbox.nvim",
		opts = {
			terminal_colors = true, -- add neovim terminal colors
			undercurl = true,
			underline = true,
			bold = false,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_selection = false,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			inverse = true, -- invert background for search, diffs, statuslines and errors
			contrast = "", -- can be "hard", "soft" or empty string
			palette_overrides = {},
			overrides = {
				LspReferenceText = { bg = "#ebdbb2" },
				LspReferenceWrite = { bg = "#ebdbb2" },
				LspReferenceRead = { bg = "#ebdbb2" },
				-- Operator = { fg = "#282828" },
				-- ["@constructor.lua"] = { fg = "#282828" },
				-- ["@punctuation.bracket.lua"] = { fg = "#282828" },
			},
			dim_inactive = false,
			transparent_mode = false,
		}
	},

	{ "rose-pine/neovim" },

	{ "zenbones-theme/zenbones.nvim" },

	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
		},
	},
}
