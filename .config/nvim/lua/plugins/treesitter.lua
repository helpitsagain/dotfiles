local options = require('configs.treesitter')

return {
  {
    'nvim-treesitter/nvim-treesitter',

    ensure_installed = options.ensure_installed,

    highlight = options.highlight,

    indent = options.indent,
  },
}
