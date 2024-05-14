return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('nvchad.configs.lspconfig').defaults()
      require('configs.lspconfig')
    end,
  },

  {
    'williamboman/mason.nvim',
    opts = require('configs.mason'),
  },

  {
    'williamboman/mason-lspconfig.nvim',
  },
}
