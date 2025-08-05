return {
	{
		"michaelb/sniprun",
		branch = "master",

		build = "sh install.sh 1",
		-- do 'sh install.sh 1' if you want to force compile locally
		-- (instead of fetching a binary from the github release). Requires Rust >= 1.65

		config = function()
			require("sniprun").setup({
				selected_interpreters = { "Python3_fifo" },
				repl_enable = { "Python3_fifo", "Julia_original" },
				display = {
					"TerminalWithCode",
				},
				interpreter_options = {
					Python3_fifo = {
						interpreter = "python3",
						venv = vim.env.VIRTUAL_ENV,
					},
				},
			})
		end,
		init = function()
			local toggle = require("snacks.toggle")

			require("which-key").add({
				{ "<leader>r", group = "+Sniprun" },
				{ "<leader>rd", group = "+Display Modes", mode = "n" },
			})

			vim.keymap.set({ "n" }, "<leader>rr", "<cmd>SnipRun<cr>", { desc = "SnipRun line" })
			vim.keymap.set({ "x", "v" }, "<leader>rr", ":'<,'>SnipRun<cr>", { desc = "SnipRun selection" })
			vim.keymap.set({ "n", "v" }, "<leader>ri", "<cmd>SnipInfo<cr>", { desc = "SnipInfo" })
			vim.keymap.set({ "n", "v" }, "<leader>rs", "<cmd>SnipReset<cr>", { desc = "SnipReset" })
			vim.keymap.set({ "n", "v" }, "<leader>rx", "<cmd>SnipReplMemoryClean<cr>", { desc = "SnipReplMemoryClean" })
			vim.keymap.set({ "n", "v" }, "<leader>rc", "<cmd>SnipClose<cr>", { desc = "SnipClose" })
			vim.keymap.set({ "n", "v" }, "<leader>rl", "<cmd>SnipLive<cr>", { desc = "SnipLive" })

			local display_modes = {
				{ key = "c", name = "Classic", desc = "Command line output" },
				{ key = "l", name = "VirtualLine", desc = "Virtual line" },
				{ key = "i", name = "VirtualText", desc = "Virtual text" },
				{ key = "f", name = "TempFloatingWindow", desc = "Temporary floating window" },
				{ key = "F", name = "LongTempFloatingWindow", desc = "Long-lived floating window" },
				{ key = "t", name = "Terminal", desc = "Terminal split" },
				{ key = "T", name = "TerminalWithCode", desc = "Terminal with source code" },
				{ key = "n", name = "NvimNotify", desc = "Nvim-notify messages" },
			}

			for _, mode in ipairs(display_modes) do
				local t = toggle.new({
					id = "sniprun_" .. mode.name:lower(),
					name = mode.name,
					get = function()
						local active_modes = require("sniprun").config_values.display
						return vim.tbl_contains(active_modes, mode.name)
					end,
					set = function(state)
						local active_modes = require("sniprun").config_values.display

						if state then
							-- Enable the display mode if not already enabled
							if not vim.tbl_contains(active_modes, mode.name) then
								table.insert(active_modes, mode.name)
							end
						else
							-- Disable the display mode
							for i, m in ipairs(active_modes) do
								if m == mode.name then
									table.remove(active_modes, i)
									break
								end
							end
						end

						require("sniprun").setup({
							display = active_modes,
						})
					end,
				})

				-- Map the toggle to the key with which-key integration
				t:map("<leader>rd" .. mode.key, {
					desc = mode.desc
				})
			end
		end,
	},
}
