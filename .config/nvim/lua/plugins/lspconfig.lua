local mason_opts = require('configs.mason')

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
    opts = mason_opts.ensure_installed,
  },

  {
    'williamboman/mason-lspconfig.nvim',
  }
}
