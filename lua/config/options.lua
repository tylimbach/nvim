-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

--[[
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.colorcolumn = "120"
--]]

vim.g.lazyvim_python_lsp = "basedpyright"

vim.opt.guicursor = "i-ci-ve:ver25,r-cr-o:hor20,a:blinkwait0-blinkoff0-blinkon0"
vim.opt.updatetime = 2000
vim.opt.cursorline = false
vim.opt.termguicolors = true

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.o.shell = 'C:/"Program Files"/Git/bin/bash.exe'
	vim.o.shellcmdflag = "-s"
end

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.list = false
vim.g.autoformat = false

vim.g.snacks_animate = false
vim.g.ai_cmp = false

if vim.g.neovide then
  -- vim.opt.guifont = "Iosevka Nerd Font:h15:#e-subpixelantialias"
  vim.g.neovide_position_animation_length = 0.15
  vim.g.neovide_scroll_animation_length = 0.10
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_cursor_animation_length = 0.05
  vim.g.neovide_cursor_trail_size = 0.0 --0.5 ref
  vim.g.neovide_opacity = 1.0
  vim.g.transparent_groups = {}
  -- transparency
  vim.opt.winblend = 3
  vim.opt.pumblend = 3
  vim.opt.linespace = 3
end

