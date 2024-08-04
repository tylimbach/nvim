-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- csharp
local augroup_cs = vim.api.nvim_create_augroup("csharp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*.cs",
  group = augroup_cs,
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.g.autoformat = false
  end,
})

-- xaml
local augroup_xaml = vim.api.nvim_create_augroup("xaml", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.xaml",
  group = augroup_xaml,
  command = "setfiletype xml",
})

-- lsp
local augroup_semantic_tokens = vim.api.nvim_create_augroup("lsp_semantic_tokens", { clear = true })
vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup_semantic_tokens,
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

-- colors
local augroup_colors = vim.api.nvim_create_augroup("colors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup_colors,
  callback = vim.mycolors.set_terminal_colors,
})
