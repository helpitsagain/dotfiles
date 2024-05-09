local options = require('configs.mason')

return {
  {
    'williamboman/mason.nvim',
    opts = options.ensure_installed,
  },
}
