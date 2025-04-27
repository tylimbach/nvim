return {
	-- roslyn lsp wrapper for csharp
	{
		"seblyng/roslyn.nvim",
		name = "roslyn",
		ft = "cs",
		opts = {
			-- config = {},
			-- exe = {
			--   "dotnet",
			--   "C:/Program Files/Microsoft.CodeAnalysis.LanguageServer/content/LanguageServer/win-x64/Microsoft.CodeAnalysis.LanguageServer.dll",
			-- },
			filewatching = "roslyn", -- try disabling if slow
			-- autoformat = false,
			-- single_file_mode = true,
			lock_target = true,
		},
	},

	-- overriden lsp configs
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				omnisharp = {
					-- disable omnisharp lsp lazy extras adds, we use roslyn
					enabled = false,
					mason = false,
				},
				rust_analyzer = {
					-- disable rust_analyzer since rustaceanvim will configure it
					enabled = false,
					mason = false,
				},
				basedpyright = {
					analysis = {
						diagnosticMode = "workspace",
					},
				},
				-- xml
				lemminx = {},
			},
			inlay_hints = { enabled = true },
		},
	},
}
