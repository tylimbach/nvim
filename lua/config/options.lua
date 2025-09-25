-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- vim.opt.colorcolumn = "120"

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

vim.g.dadbod_debug = 1

local function add_all_dbs(dbs, name, server)
	local cmd = [[sqlcmd -S "]]..server..[[" -E -h-1 -W -Q "SET NOCOUNT ON;SELECT name FROM sys.databases WHERE state=0 ORDER BY name"]]
	local fh = io.popen(cmd)
	if not fh then
		print("Failed to open pipe for sqlcmd")
		return
	end

	local count = 0
	for line in fh:lines() do
		local db = line:gsub("\r",""):match("^%s*(.-)%s*$")  -- trim spaces and \r
		if db ~= "" then
			table.insert(dbs, {
				name = name .. "/" .. db,
				url  = "sqlserver://" .. server .. "?database=" .. db
			})
			count = count + 1
		end
	end
	fh:close()

	print(("Total databases added for %s: %d"):format(server, count))
end

local cache_path = vim.fn.stdpath("cache") .. "/dbs.json"

local function load_dbs_cache()
    local f = io.open(cache_path, "r")
    if f then
        local content = f:read("*a")
        f:close()
        local ok, data = pcall(vim.json.decode, content)
        if ok and type(data) == "table" then
            return data
        end
    end
    return nil
end

local function save_dbs_cache(dbs)
    local f = io.open(cache_path, "w")
    if f then
        f:write(vim.json.encode(dbs))
        f:close()
    end
end

local dbs = load_dbs_cache() or {}
vim.g.dbs = dbs

local function load_env_file(path)
    local f = io.open(path, "r")
    if not f then return end
    for line in f:lines() do
        local key, value = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
        if key and value then
            vim.fn.setenv(key, value)
        end
    end
    f:close()
end

local env_path = vim.fn.stdpath("config") .. "/.env"
vim.api.nvim_create_user_command("RescanDbs", function()
	load_env_file(env_path)
	local dbs = {}
	for k, v in pairs(vim.fn.environ()) do
		if k:match("^WT_DB_") and v and v ~= "" then
			add_all_dbs(dbs, v, v)
		end
	end
    save_dbs_cache(dbs)
    vim.g.dbs = dbs
    print("Database cache updated!")
end, {})

