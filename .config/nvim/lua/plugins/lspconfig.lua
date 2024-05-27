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
    -- config = require('mason').setup({
    --   ui = {
    --     icons = {
    --       package_installed = '',
    --       package_pending = '',
    --       package_uninstalled = '',
    --     },
    --   },
    -- }),
    -- config = require('configs.mason'),
  },

  {
    'williamboman/mason-lspconfig.nvim',
  },
}
