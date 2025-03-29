-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- local augroup_cs = vim.api.nvim_create_augroup("csharp", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "cs",
--   group = augroup_cs,
--   callback = function()
--     vim.opt_local.expandtab = false
--     vim.opt_local.tabstop = 4
--     vim.opt_local.shiftwidth = 4
--     vim.opt_local.softtabstop = 4
--     vim.g.autoformat = false
--   end,
--   desc = "Csharp Specific Formatting",
-- })
--
-- local augroup_ps = vim.api.nvim_create_augroup("ps", { clear = true })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "ps1",
--   group = augroup_ps,
--   callback = function()
--     vim.opt_local.expandtab = false
--     vim.opt_local.tabstop = 4
--     vim.opt_local.shiftwidth = 4
--     vim.opt_local.softtabstop = 4
--     vim.g.autoformat = false
--   end,
--   desc = "PowerShell Specific Formatting",
-- })

-- local augroup_semantic_tokens = vim.api.nvim_create_augroup("lsp_semantic_tokens", { clear = true })
-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = augroup_semantic_tokens,
--   callback = function(args)
-- 	for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
-- 		vim.api.nvim_set_hl(0, group, {})
-- 	end
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
-- 	if client ~= nil then
-- 		client.server_capabilities.semanticTokensProvider = nil
-- 	end
--   end,
--   desc = "Disable Lsp Semantic Tokens",
-- })
--

-- local augroup_colors = vim.api.nvim_create_augroup("colors", { clear = true })
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   group = augroup_colors,
--   callback = function()
--     vim.mycolors.set_terminal_colors()
--   end,
--   desc = "Update Terminal Colors",
-- })

local augroup_xaml = vim.api.nvim_create_augroup("xaml", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.xaml",
  group = augroup_xaml,
  command = "setfiletype xml",
  desc = "Load xaml as xml",
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comments",
})

local excluded_groups = {
	["@lsp.type.hint"] = true,
	["LspInlayHint"] = true, -- Optional: exclude inlay hints too if desired
}

local semantic_tokens_enabled = true
local lsp_highlight_cache = {}

local function cache_lsp_highlights()
	for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
		if not excluded_groups[group] then
			lsp_highlight_cache[group] = vim.api.nvim_get_hl(0, { name = group })
		end
	end
	for _, group in ipairs(vim.fn.getcompletion("Lsp", "highlight")) do
		if not excluded_groups[group] then
			lsp_highlight_cache[group] = vim.api.nvim_get_hl(0, { name = group })
		end
	end
end

local function toggle_semantic_highlights()
	semantic_tokens_enabled = not semantic_tokens_enabled
	if semantic_tokens_enabled then
		for group, attrs in pairs(lsp_highlight_cache) do
			vim.api.nvim_set_hl(0, group, attrs)
		end
		local Util = require("lazyvim.util")
		Util.notify("Enabled **LspSemanticHighlight**", {
			title = "LspSemanticHighlight",
			level = vim.log.levels.INFO,
		})
	else
		for group, _ in pairs(lsp_highlight_cache) do
			vim.api.nvim_set_hl(0, group, {})
		end
		local Util = require("lazyvim.util")
		Util.notify("Disabled **LspSemanticHighlight**", {
			title = "LspSemanticHighlight",
			level = vim.log.levels.WARN,
		})
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		cache_lsp_highlights()
		if not semantic_tokens_enabled then
			for group, _ in pairs(lsp_highlight_cache) do
				vim.api.nvim_set_hl(0, group, {})
			end
		end
	end,
})

vim.api.nvim_create_user_command("ToggleSemanticHighlight", toggle_semantic_highlights, {})
vim.keymap.set("n", "<leader>ts", toggle_semantic_highlights, { desc = "Toggle Semantic Highlighting" })


