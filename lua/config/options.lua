-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--[[
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 750
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.colorcolumn = "120"
--]]

vim.opt.cursorline = false
vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

if vim.g.neovide then
  -- vim.opt.guifont = "Iosevka Nerd Font:h15:#e-subpixelantialias"
  vim.g.neovide_position_animation_length = 0.15
  vim.g.neovide_scroll_animation_length = 0.10
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.0 --0.5 ref
end
