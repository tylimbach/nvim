-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

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

local augroup_xaml = vim.api.nvim_create_augroup("xaml", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.xaml",
  group = augroup_xaml,
  command = "setfiletype xml",
})
