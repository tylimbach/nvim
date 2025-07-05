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

	-- Override Mason configuration to add custom registry
	{
		"williamboman/mason.nvim",
		version = "^1.0.0", -- workaround for 2.0 breaking changes
		opts = function(_, opts)
		opts.registries = {
			"github:mason-org/mason-registry",
			"github:Crashdummyy/mason-registry",
		}
		return opts
		end,
	},

	-- workaround for 2.0 breaking changes
	{ "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },

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
				-- rust_analyzer = {
				-- 	-- disable rust_analyzer since rustaceanvim will configure it
				-- 	enabled = true,
				-- 	mason = true,
				-- },
				basedpyright = {
					analysis = {
						diagnosticMode = "workspace",
					},
				},
				-- xml
				lemminx = {},
				sourcekit = {
					filetypes = { "swift", "objective-c", "objective-cpp" },
					cmd = {
						"/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"
					},
					cmd_env = {
						DEVELOPER_DIR = "/Applications/Xcode-beta.app/Contents/Developer",
						SDKROOT = "/Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk",
						MACOSX_DEPLOYMENT_TARGET = "14.0",
					},
				},
			},
			inlay_hints = { enabled = true },
		},
	},
}
