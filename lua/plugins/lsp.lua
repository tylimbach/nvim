vim.lsp.config.jetls = {
	cmd = {
		"julia",
		"--startup-file=no",
		"--history-file=no",
		"--project=/Users/ty/dev/JETLS.jl",
		"/Users/ty/dev/JETLS.jl/runserver.jl",
	},
	filetypes = { "julia" },
	root_markers = { "Project.toml", "JuliaProject.toml", ".git" },
}

vim.lsp.enable({ "jetls" })

return {
	-- roslyn lsp wrapper for csharp
	{
		"seblyng/roslyn.nvim",
		name = "roslyn",
		commit = "7f8c18c6aac3667e0c0ec1aa30ecc77d3d36807f", -- lock target seems broken in recent
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
		"mason-org/mason.nvim",
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
					enabled = false,
					mason = false,
					cmd = {
						"julia",
						"--project=".."~/.julia/environments/lsp/",
						"--startup-file=no",
						"--history-file=no",
						"-e", [[
							using Pkg
							Pkg.instantiate()
							using LanguageServer
						depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
						project_path = let
							dirname(something(
								## 1. Finds an explicitly set project (JULIA_PROJECT)
								Base.load_path_expand((
									p = get(ENV, "JULIA_PROJECT", nothing);
										p === nothing ? nothing : isempty(p) ? nothing : p
									)),
										## 2. Look for a Project.toml file in the current working directory,
										##    or parent directories, with $HOME as an upper boundary
										Base.current_project(),
										## 3. First entry in the load path
										get(Base.load_path(), 1, nothing),
										## 4. Fallback to default global environment,
										##    this is more or less unreachable
									Base.load_path_expand("@v#.#"),
								))
							end
									@info "Running language server" VERSION pwd() project_path depot_path
									server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path)
						server.runlinter = true
							run(server)
						]]
					},
					filetypes = { 'julia' },
					root_markers = { "Project.toml", "JuliaProject.toml" },
					settings = {}
					-- root_dir = require("lspconfig.util").find_git_ancestor,
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
