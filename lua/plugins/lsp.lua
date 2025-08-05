return {
	-- roslyn lsp wrapper for csharp
	{
		"seblyng/roslyn.nvim",
		name = "roslyn",
		commit = "7f8c18c6aac3667e0c0ec1aa30ecc77d3d36807f",
		ft = "cs",
		opts = {
			-- config = {},
			-- exe = {
			--   "dotnet",
			--   "C:/Program Files/Microsoft.CodeAnalysis.LanguageServer/content/LanguageServer/win-x64/Microsoft.CodeAnalysis.LanguageServer.dll",
			-- },
			filewatching = "roslyn", -- try disabling if slow
			single_file_mode = false,
			lock_target = true,
		},
	},

	-- Override Mason configuration to add custom registry
	{
		"williamboman/mason.nvim",
		-- version = "^1.0.0", -- workaround for 2.0 breaking changes
		opts = function(_, opts)
		opts.registries = {
			"github:mason-org/mason-registry",
			"github:Crashdummyy/mason-registry",
		}
		return opts
		end,
	},

	-- workaround for 2.0 breaking changes
	-- { "williamboman/mason-lspconfig.nvim" },

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
				roslyn_ls = {
					enabled = false,
					mason = false,
				},
				-- basedpyright = {
				-- 	analysis = {
				-- 		diagnosticMode = "workspace",
				-- 	},
				-- },
				julials = {
					mason = false,
					cmd = {
						"julia",
						"--project=@nvim-lspconfig",
						"--startup-file=no",
						"--history-file=no",
						"-e", [[
							using LanguageServer, SymbolServer;
							env = get(ENV, "JULIA_PROJECT", "@nvim-lspconfig");
							server = LanguageServer.LanguageServerInstance(stdin, stdout, env);
							server.runlinter = true;
							run(server);
						]]
					},
					filetypes = { "julia" },
					-- root_dir = require("lspconfig.util").find_git_ancestor,
				},
				-- xml
				lemminx = {},
				sourcekit = {
					filetypes = { "swift", "objective-c", "objective-cpp" },
					-- cmd = {
					-- 	"/Applications/Xcode-beta.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"
					-- },
					-- cmd_env = {
					-- 	DEVELOPER_DIR = "/Applications/Xcode-beta.app/Contents/Developer",
					-- 	SDKROOT = "/Applications/Xcode-beta.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk",
					-- 	MACOSX_DEPLOYMENT_TARGET = "14.0",
					-- },
				},
			},
			inlay_hints = { enabled = true },
		},
	},
}
