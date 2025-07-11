return {
  {
    "olimorris/codecompanion.nvim", -- The KING of AI programming
    dependencies = {
      -- "j-hui/fidget.nvim",
      {
        "Davidyz/VectorCode",
        version = "*",
        build = "pipx upgrade vectorcode",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
      -- { "echasnovski/mini.pick", config = true },
      -- { "ibhagwan/fzf-lua", config = true },
    },
    opts = {
      adapters = {
		anthropic = function()
			return require("codecompanion.adapters").extend("anthropic", {
				env = {
					api_key = "cmd:gopass show -o personal/Anthropic_API",
				},
			})
		end,
		copilot = function()
			return require("codecompanion.adapters").extend("copilot", {
				schema = {
					model = {
						default = "claude-3.7-sonnet",
					},
				},
			})
		end,
		deepseek = function()
			return require("codecompanion.adapters").extend("deepseek", {
				env = {
					api_key = "cmd:gopass show -o personal/DeepSeek_API",
				},
			})
		end,
		gemini = function()
			return require("codecompanion.adapters").extend("gemini", {
				env = {
					api_key = "cmd:gopass show -o personal/Gemini_API",
				},
			})
		end,
		novita = function()
			return require("codecompanion.adapters").extend("novita", {
				env = {
					api_key = "cmd:gopass show -o personal/Novita_API",
				},
				schema = {
					model = {
						default = function()
							return "meta-llama/llama-3.1-8b-instruct"
						end,
					},
				},
			})
		end,
		ollama = function()
			return require("codecompanion.adapters").extend("ollama", {
				schema = {
					model = {
						default = "llama3.1:latest",
					},
					num_ctx = {
						default = 20000,
					},
				},
			})
		end,
		openai = function()
			return require("codecompanion.adapters").extend("openai", {
				opts = {
					stream = true,
				},
				env = {
					api_key = "cmd:gopass show -o personal/OpenAI_API",
				},
				schema = {
					model = {
						default = function()
							return "gpt-4o"
						end,
					},
				},
			})
		end,
		xai = function()
			return require("codecompanion.adapters").extend("xai", {
				env = {
					api_key = "cmd:gopass show -o personal/xAI_API",
				},
			})
		end,
		},
      prompt_library = {
        ["Docusaurus"] = {
          strategy = "chat",
          description = "Write documentation for me",
          opts = {
            index = 11,
            is_slash_cmd = false,
            auto_submit = false,
            short_name = "docs",
          },
          references = {
            {
              type = "file",
              path = {
                "doc/.vitepress/config.mjs",
                "lua/codecompanion/config.lua",
                "README.md",
              },
            },
          },
          prompts = {
            {
              role = "user",
              content = [[I'm rewriting the documentation for my plugin CodeCompanion.nvim, as I'm moving to a vitepress website. Can you help me rewrite it?

I'm sharing my vitepress config file so you have the context of how the documentation website is structured in the `sidebar` section of that file.

I'm also sharing my `config.lua` file which I'm mapping to the `configuration` section of the sidebar.
]],
            },
          },
        },
        ["Test workflow"] = {
          strategy = "workflow",
          description = "Use a workflow to test the plugin",
          opts = {
            index = 4,
          },
          prompts = {
            {
              {
                role = "user",
                content = "Generate a Python class for managing a book library with methods for adding, removing, and searching books",
                opts = {
                  auto_submit = false,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write unit tests for the library class you just created",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Create a TypeScript interface for a complex e-commerce shopping cart system",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write a recursive algorithm to balance a binary search tree in Java",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Generate a comprehensive regex pattern to validate email addresses with explanations",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Create a Rust struct and implementation for a thread-safe message queue",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write a GitHub Actions workflow file for CI/CD with multiple stages",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Create SQL queries for a complex database schema with joins across 4 tables",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Write a Lua configuration for Neovim with custom keybindings and plugins",
                opts = {
                  auto_submit = true,
                },
              },
            },
            {
              {
                role = "user",
                content = "Generate documentation in JSDoc format for a complex JavaScript API client",
                opts = {
                  auto_submit = true,
                },
              },
            },
          },
        },
      },
      strategies = {
        chat = {
          adapter = "copilot",
          roles = {
            user = "tlimbach",
          },
          keymaps = {
            send = {
              modes = {
                i = { "<C-CR>", "<C-s>" },
              },
            },
            completion = {
              modes = {
                i = "<C-x>",
              },
            },
          },
          slash_commands = {
            ["buffer"] = {
              opts = {
                keymaps = {
                  modes = {
                    i = "<C-b>",
                  },
                },
              },
            },
            ["help"] = {
              opts = {
                max_lines = 1000,
              },
            },
          },
          tools = {
            vectorcode = {
              description = "Run VectorCode to retrieve the project context.",
              callback = function()
                return require("vectorcode.integrations").codecompanion.chat.make_tool()
              end,
            },
          },
        },
        inline = { adapter = "copilot" },
      },
      display = {
        action_palette = {
          provider = "default",
        },
        chat = {
          -- show_references = true,
          -- show_header_separator = false,
          -- show_settings = false,
        },
        diff = {
          provider = "mini_diff",
        },
      },
      opts = {
        log_level = "DEBUG",
      },
    },
	init = function()
		vim.cmd([[cab cc CodeCompanion]])

		require("which-key").add({
			{ "<leader>a", group = "+AI" },
		})

		vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "AI: Open Action Palette" })
		vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "AI: Toggle Chat Buffer" })
		vim.keymap.set({ "n", "v" }, "<leader>as", "<cmd>CodeCompanionChat Add<cr>", { desc = "AI: Add Selected to Chat" })
		vim.keymap.set("n", "<leader>av", function()
			require("vectorcode.integrations").codecompanion.chat.make_tool()
		end, { desc = "AI: Run VectorCode Context" })

		-- require("plugins.custom.spinner"):init()
	end
	},
}
