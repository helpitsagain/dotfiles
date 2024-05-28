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
    config = function()
      require('configs.mason')
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
  },
}
