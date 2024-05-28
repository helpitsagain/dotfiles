local options = {
  ensure_installed = {
    'lua-language-server',
    'stylua',
    'html-lsp',
    'css-lsp',
    'prettier',
    'typescript-language-server',
    'bash-language-server',
    'rust-analyzer',
  },
  ui = {
    icons = {
      package_installed = '',
      package_pending = '',
      package_uninstalled = '',
    },
  },
}

require('mason').setup(options)
