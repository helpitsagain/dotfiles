return {
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },

    config = function()
      require('configs.nvim-tree')
    end,
  },
}
