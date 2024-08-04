local colors_name = "mybones"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require("lush")
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require("zenbones.util")

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
-- Based on https://github.com/gruvbox-community/gruvbox#palette
local palette
if bg == "light" then
  palette = util.palette_extend({
    bg = hsluv("#fbf1c7"),
    bg2 = hsluv("#eedaba"),
    bg3 = hsluv("#ebdbb2"),
    fg = hsluv("#3c3836"),
    rose = hsluv("#9d0006"),
    leaf = hsluv("#79740e"),
    wood = hsluv("#b57614"),
    water = hsluv("#076678"),
    blossom = hsluv("#8f3f71"),
    sky = hsluv("#7F7252"),
  }, bg)
else
  palette = util.palette_extend({
    bg = hsluv("#282828"),
    fg = hsluv("#ebdbb2"),
    rose = hsluv("#fb4934"),
    leaf = hsluv("#b8bb26"),
    wood = hsluv("#fabd2f"),
    water = hsluv("#83a598"),
    blossom = hsluv("#d3869b"),
    sky = hsluv("#83c07c"),
  }, bg)
end

-- Generate the lush specs using the generator util
local generator = require("zenbones.specs")
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
  return {
    Function({ fg = palette.wood }),
    Statement({ base_specs.Statement, fg = palette.wood }),
    Special({ fg = palette.water, gui = "None" }),
    SpecialKey({ fg = palette.wood, gui = "None" }),
    Type({ fg = palette.sky, gui = "None" }),
    Number({ fg = palette.fg }),
    WarningMsg({ base_specs.WarningMsg, fg = base_specs.Comment.fg }),
    FlashBackdrop({ base_specs.FlashBackdrop, bg = palette.bg3 }),
    FloatBorder({ base_specs.FloatBorder, bg = palette.sky }),
    NormalFloat({ base_specs.NormalFloat, bg = palette.bg3 }),
    StatusLine({ base_specs.StatusLine, bg = palette.bg }),
    StatusLineNC({ base_specs.StatusLineNC, bg = palette.bg }),
    Pmenu({ base_specs.Pmenu, bg = palette.bg3 }),
    PmenuSel({ base_specs.CursorLine }),
    PmenuSbar({ base_specs.CursorLine }),
    DiagnosticVirtualTextError({ base_specs.DiagnosticVirtualTextError, bg = palette.bg }),
    DiagnosticVirtualTextWarn({ base_specs.DiagnosticVirtualTextWarn, bg = palette.bg }),
    DiagnosticVirtualTextInfo({ base_specs.DiagnosticVirtualTextInfo, bg = palette.bg }),
    DiagnosticVirtualTextHint({ base_specs.DiagnosticVirtualTextHint, bg = palette.bg }),
    DiagnosticVirtualTextOk({ base_specs.DiagnosticVirtualTextOk, bg = palette.bg }),
    RenderMarkdownCode({ bg = palette.bg3 }),
    RenderMarkdownBullet({ bg = palette.bg3 }),
    RenderMarkdownTableRow({ bg = palette.bg3 }),
    Constant({ fg = palette.leaf }),
    --Comment({ WarningMsg, italics = true }),
  }
end)

-- Pass the specs to lush to apply
lush(specs)

-- Optionally set term colors
--require("zenbones.term").apply_colors(palette)
