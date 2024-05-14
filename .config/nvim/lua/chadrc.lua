-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  theme = 'catppuccin',

  hl_override = {
    Comment = { italic = true },
    ['@comment'] = { italic = true },
  },

  telescope = { style = 'bordered' },

  nvdash = {
    load_on_startup = false,

    header = {
      '           ▄ ▄                   ',
      '       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ',
      '       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ',
      '    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ',
      '  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ',
      '  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄',
      '▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █',
      '█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █',
      '    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ',
    },

    buttons = {
      { '  Find File', 'Spc f f', 'Telescope find_files' },
      { '󰈚  Recent Files', 'Spc f o', 'Telescope oldfiles' },
      { '󰈭  Find Word', 'Spc f w', 'Telescope live_grep' },
      { '  Bookmarks', 'Spc m a', 'Telescope marks' },
      { '  Themes', 'Spc t h', 'Telescope themes' },
      { '  Mappings', 'Spc c h', 'NvCheatsheet' },
    },
  },

  cheatsheet = {
    theme = 'grid', -- simple/grid
    excluded_groups = {}, -- can add group name or with mode
  },

  lsp = { signature = true },

  term = {
    hl = 'Normal:term,WinSeparator:WinSeparator',
    sizes = { sp = 0.3, vsp = 0.2 },
    float = {
      relative = 'editor',
      row = 0.05,
      col = 0.05,
      width = 0.9,
      height = 0.8,
      border = 'single',
    },
  },
}

return M
