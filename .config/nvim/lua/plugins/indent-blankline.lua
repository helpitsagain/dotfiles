---@diagnostic disable-next-line: unused-local
local highlight = {
  'CursorColumn',
  'Whitespace',
}

return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    require('ibl').setup({
      scope = { enabled = true, show_start = false, char = '|' },
      -- whitespace = {
      --   remove_blankline_trail = false,
      --   highlight = highlight,
      -- },
    })
  end,
}
