-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(0.15)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(-0.15)
end)
