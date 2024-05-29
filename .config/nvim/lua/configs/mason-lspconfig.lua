local options = {
  ensure_installed = {
    'bashls',
    'cssls',
    'html',
    'lua_ls',
    'rust_analyzer',
    'tsserver',
  },
  automatic_installation = true,
}

require('mason-lspconfig').setup(options)
