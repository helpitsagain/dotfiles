return {
  -- override plugin configs
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },

  {
    'williamboman/mason-lspconfig.nvim',
    -- opts = overrides.mason,
    lazy = false,
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'lua_ls',
          'tsserver',
          'clangd',
          'pyright',
          'omnisharp',
        },
      })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.configs.lspconfig')

      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({})
      lspconfig.tsserver.setup({})
      lspconfig.pyright.setup({})
      lspconfig.omnisharp.setup({})
    end,         -- Override to setup mason-lspconfig
  },
}
