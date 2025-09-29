return {
    "mfussenegger/nvim-dap",
    config = function()
	local dap = require("dap")

	dap.adapters.coreclr = {
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe",
		args = { "--interpreter=vscode" },
        options = {
            detached = false,
            justMyCode = false,
            stopAtEntry = false,
        },
	}

	local function find_build_outputs()
		local results = {}
		-- Get the root directory as determined by LazyVim (same as :LazyRoot)
		local root_dir = require("lazyvim.util.root").get()

		local excluded_dirs = { "lib", "node_modules", ".git", ".vscode", "bin", "obj" }
		local function is_excluded(dir_name)
			for _, excluded in ipairs(excluded_dirs) do
				if dir_name == excluded then
					return true
				end
			end
			return false
		end

		for _, project_dir in ipairs(vim.fn.glob(root_dir .. "/*", true, true)) do
			if vim.fn.isdirectory(project_dir) == 1 then
				local project_name = vim.fn.fnamemodify(project_dir, ":t")

				if not is_excluded(project_name) then
					local target_dir = project_dir .. "/bin/Debug/"
					if vim.fn.isdirectory(target_dir) == 1 then
						local target_pattern = "W.R." .. project_name:gsub("%.", "%%.") .. "%.exe"
						-- Look for matching .exe files in the target directory
						for _, file in ipairs(vim.fn.glob(target_dir .. "*.exe", true, true)) do
							if file:match(target_pattern) then
								table.insert(results, file)
							end
						end
					end
				end
			end
		end

		return results
	end

	local function pick_build_output(callback)
		local build_outputs = find_build_outputs()
		if #build_outputs == 0 then
			vim.notify("No matching build outputs found in bin/Debug for projects", vim.log.levels.ERROR)
			return
		end

		-- Use LazyVim's picker utility
		vim.ui.select(build_outputs, {
			prompt = "Select Build Output:",
			format_item = function(item)
				return vim.fn.fnamemodify(item, ":t") .. " (" .. vim.fn.fnamemodify(item, ":h") .. ")"
			end,
		}, function(selected_file)
			if selected_file then
				callback(selected_file)
			end
		end)
	end

	dap.configurations.cs = {
		-- TODO: figure out why launch crashes but attach works fine
		{
			type = "coreclr",
			name = "Launch - CoreCLR",
			request = "launch",
			justMyCode = false,
			program = function()
				return coroutine.create(function(dap_run)
					pick_build_output(function(selected_file)
						vim.g.dap_selected_program = selected_file
						coroutine.resume(dap_run, selected_file)
					end)
				end)
			end,
			cwd = function()
				local selected_file = vim.g.dap_selected_program
				if selected_file then
					return vim.fn.fnamemodify(selected_file, ":h")
				else
					return require("lazyvim.util.root").get()
				end
			end,
		},
		{
			type = "coreclr",
			name = "Attach - CoreCLR",
			request = "attach",
			justMyCode = false,
			processId = require("dap.utils").pick_process,
		},
	}
    end,
}
